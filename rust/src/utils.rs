use bdk::bitcoin::Network as BdkNetwork;
use bdk::blockchain::{AnyBlockchain, AnyBlockchainConfig, ConfigurableBlockchain, ElectrumBlockchainConfig};
use bdk::blockchain::esplora::EsploraBlockchainConfig;
use bdk::{ KeychainKind as BdkKeychainKind};
use bdk::keys::bip39::WordCount as BdkWordCount;
use crate::types::{ BlockchainConfig, DatabaseConfig, Entropy, KeyChainKind, Network, WordCount};
use bdk::database::any:: SqliteDbConfiguration;
use bdk::database::{AnyDatabaseConfig};
pub fn config_network(network: Network) -> BdkNetwork {
    return match network {
        Network::SIGNET => BdkNetwork::Signet,
        Network::TESTNET=> BdkNetwork::Testnet,
        Network::REGTEST => BdkNetwork::Regtest,
        Network::BITCOIN => BdkNetwork::Bitcoin,
    };
}
pub fn config_bdk_network(network: BdkNetwork) -> Network {
    return match network {
        BdkNetwork::Signet => Network::SIGNET,
        BdkNetwork::Testnet => Network::TESTNET,
        BdkNetwork::Regtest => Network::REGTEST,
        BdkNetwork::Bitcoin => Network::BITCOIN,
    };
}
pub fn config_word_count(word_count: WordCount) -> BdkWordCount {
    return match word_count {
        WordCount::WORDS12 => BdkWordCount::Words12,
        WordCount::WORDS18 => BdkWordCount::Words18,
        WordCount::WORDS24 => BdkWordCount::Words24,
    };
}
pub fn config_entropy(entropy: Entropy) -> usize {
    return match entropy {
        Entropy::ENTROPY128 => 16,
        Entropy::ENTROPY192 => 24,
        Entropy::ENTROPY256 => 32,
    };
}
pub fn config_blockchain(
    blockchain_config: BlockchainConfig
) -> AnyBlockchain {
    let any_blockchain_config = match blockchain_config {
        BlockchainConfig::ELECTRUM { config } => {
            AnyBlockchainConfig::Electrum(ElectrumBlockchainConfig {
                retry: config.retry,
                socks5: config.socks5,
                timeout: config.timeout,
                url: config.url,
                stop_gap: usize::try_from(config.stop_gap).unwrap(),
            })
        }
        BlockchainConfig::ESPLORA { config } => {
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
pub fn config_keychain_kind(keychain: KeyChainKind) -> BdkKeychainKind {
    return match keychain {
        KeyChainKind::EXTERNAL => BdkKeychainKind::External,
        KeyChainKind::INTERNAL => BdkKeychainKind::Internal,
    };
}
pub fn config_database(database_config: DatabaseConfig) -> AnyDatabaseConfig {
    return match database_config {
        DatabaseConfig::MEMORY => AnyDatabaseConfig::Memory(()),
        DatabaseConfig::SQLITE { config } => AnyDatabaseConfig::Sqlite(SqliteDbConfiguration{ path: config.path }),
    };
}
