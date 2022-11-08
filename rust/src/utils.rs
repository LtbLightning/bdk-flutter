use bdk::bitcoin::Network as BdkNetwork;
use bdk::blockchain::esplora::EsploraBlockchainConfig;
use bdk::blockchain::{
    AnyBlockchain, AnyBlockchainConfig, ConfigurableBlockchain, ElectrumBlockchainConfig,
};
use bdk::database::any::{SledDbConfiguration, SqliteDbConfiguration};
use bdk::database::AnyDatabaseConfig;
use bdk::keys::bip39::WordCount as BdkWordCount;
use bdk::KeychainKind as BdkKeychainKind;

use crate::types::{BlockchainConfig, DatabaseConfig, KeyChainKind, Network, WordCount};

pub fn config_network(network: Network) -> BdkNetwork {
    return match network {
        Network::Signet => BdkNetwork::Signet,
        Network::Testnet => BdkNetwork::Testnet,
        Network::Regtest => BdkNetwork::Regtest,
        Network::Bitcoin => BdkNetwork::Bitcoin,
    };
}

#[allow(dead_code)]
pub fn config_bdk_network(network: BdkNetwork) -> Network {
    return match network {
        BdkNetwork::Signet => Network::Signet,
        BdkNetwork::Testnet => Network::Testnet,
        BdkNetwork::Regtest => Network::Regtest,
        BdkNetwork::Bitcoin => Network::Bitcoin,
    };
}

pub fn config_word_count(word_count: WordCount) -> BdkWordCount {
    return match word_count {
        WordCount::Words12 => BdkWordCount::Words12,
        WordCount::Words18 => BdkWordCount::Words18,
        WordCount::Words24 => BdkWordCount::Words24,
    };
}

pub fn config_blockchain(blockchain_config: BlockchainConfig) -> AnyBlockchain {
    let any_blockchain_config = match blockchain_config {
        BlockchainConfig::Electrum { config } => {
            AnyBlockchainConfig::Electrum(ElectrumBlockchainConfig {
                retry: config.retry,
                socks5: config.socks5,
                timeout: config.timeout,
                url: config.url,
                stop_gap: usize::try_from(config.stop_gap).unwrap(),
            })
        }
        BlockchainConfig::Esplora { config } => {
            AnyBlockchainConfig::Esplora(EsploraBlockchainConfig {
                base_url: config.base_url,
                proxy: config.proxy,
                concurrency: config.concurrency,
                stop_gap: usize::try_from(config.stop_gap).unwrap(),
                timeout: config.timeout,
            })
        }
    };
    let blockchain = AnyBlockchain::from_config(&any_blockchain_config).unwrap();
    blockchain
}

#[allow(dead_code)]
pub fn config_keychain_kind(keychain: KeyChainKind) -> BdkKeychainKind {
    return match keychain {
        KeyChainKind::External => BdkKeychainKind::External,
        KeyChainKind::Internal => BdkKeychainKind::Internal,
    };
}

pub fn config_database(database_config: DatabaseConfig) -> AnyDatabaseConfig {
    return match database_config {
        DatabaseConfig::Memory => AnyDatabaseConfig::Memory(()),
        DatabaseConfig::Sqlite { config } => {
            AnyDatabaseConfig::Sqlite(SqliteDbConfiguration { path: config.path })
        }
        DatabaseConfig::Sled { config } => AnyDatabaseConfig::Sled(SledDbConfiguration {
            path: config.path,
            tree_name: config.tree_name,
        }),
    };
}
