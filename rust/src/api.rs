use std::ops::Deref;
use crate::ffi::{restore_extended_key, AddressIndex, ExtendedKeyInfo, PartiallySignedBitcoinTransaction, Transaction, TxBuilder, Wallet, generate_mnemonic};
// use anyhow::{anyhow, Result};
use bdk::bitcoin::Network;
use bdk::blockchain::esplora::EsploraBlockchainConfig;
use bdk::blockchain::{
    AnyBlockchain, AnyBlockchainConfig, Blockchain as BdkBlockChain, ConfigurableBlockchain,
    ElectrumBlockchainConfig,
};
use lazy_static::lazy_static;
use std::sync::RwLock;
use bdk::keys::bip39::WordCount;

lazy_static! {
    static ref WALLET: RwLock<Wallet> = RwLock::new(Wallet::default());
    static ref BLOCKCHAIN: RwLock<AnyBlockchain> = RwLock::new(default_blockchain());
}
fn config_network(network: String) -> Network {
    return match network.as_str() {
        "SIGNET" => Network::Signet,
        "TESTNET" => Network::Testnet,
        "REGTEST" => Network::Regtest,
        "BITCOIN" => Network::Bitcoin,
        _ => Network::Testnet,
    };
}

fn config_word_count(word_count: String) -> WordCount {
    return match word_count.as_str() {
        "Words12" => WordCount::Words12,
        "Words15" => WordCount::Words15,
        "Words18" => WordCount::Words18,
        "Words21" => WordCount::Words21,
        "Words24" => WordCount::Words24,
        _ => WordCount::Words12
    };
}

fn config_entropy(entropy: String) -> u8 {
    return match entropy.as_str() {
        "Entropy32" => 32,
        "Entropy64" => 64,
        "Entropy96" => 96,
        "Entropy128" => 128,
        "Entropy160" => 160,
        "Entropy192" => 192,
        "Entropy224" => 224,
        _ => 128
    };
}

fn default_blockchain() -> AnyBlockchain {
    let config = AnyBlockchainConfig::Electrum(ElectrumBlockchainConfig {
        url: "ssl://electrum.blockstream.info:60002".into(),
        retry: 2,
        socks5: None,
        timeout: None,
        stop_gap: 20,
    });
    return AnyBlockchain::from_config(&config).unwrap();
}

fn config_blockchain(blockchain: &str, url: String, _socks5_or_proxy: Option<String>) -> AnyBlockchain {
    return match blockchain {
        "ELECTRUM" => {
            let config = AnyBlockchainConfig::Electrum(ElectrumBlockchainConfig {
                url: url.into(),
                retry: 2,
                socks5: None,
                timeout: None,
                stop_gap: 20,
            });
            AnyBlockchain::from_config(&config).unwrap()
        }
        "ESPLORA" => {
            let config = AnyBlockchainConfig::Esplora(EsploraBlockchainConfig {
                base_url: url.to_string(),
                proxy: None,
                timeout: None,
                stop_gap: 20,
                concurrency: None,
            });
            AnyBlockchain::from_config(&config).unwrap()
        }
        &_ => {
            let config = AnyBlockchainConfig::Electrum(ElectrumBlockchainConfig {
                url: url.into(),
                retry: 2,
                socks5: None,
                timeout: None,
                stop_gap: 20,
            });
            AnyBlockchain::from_config(&config).unwrap()
        }
    };
}

pub struct BdkFlutterWallet {
    pub balance: u64,
    pub address: String,
}

fn blockchain_init(blockchain: &str, url: String, socks5: Option<String>) {
    let blockchain = config_blockchain(blockchain, url, socks5);
    let mut new_blockchain = BLOCKCHAIN.write().unwrap();
    *new_blockchain = blockchain;
}

pub fn wallet_init(
    descriptor: String,
    change_descriptor: String,
    network: String,
    blockchain: String,
    url: String,
    socks5_or_proxy: String,
) {
    let node_network = config_network(network.clone());
    let optional_socks5_or_proxy = if socks5_or_proxy.is_empty() { None } else { Some(socks5_or_proxy) };
    blockchain_init(blockchain.as_str(), url, optional_socks5_or_proxy);
    let wallet = Wallet::new(
        descriptor.clone(),
        Some(change_descriptor.clone()),
        node_network,
    )
        .unwrap();
    let blockchain_obj = BLOCKCHAIN.read().unwrap();
    wallet.sync(blockchain_obj.deref());
    let mut new_wallet = WALLET.write().unwrap();
    *new_wallet = wallet;
}

pub fn get_wallet() -> BdkFlutterWallet {
    let wallet = WALLET.read().unwrap();
    let blockchain_obj = BLOCKCHAIN.read().unwrap();
    wallet.sync(blockchain_obj.deref());
    BdkFlutterWallet {
        balance: get_balance(),
        address: get_new_address(),
    }
}

pub fn generate_mnemonic_seed(word_count: String, entropy: String) -> String {
    let entropy_u8 = config_entropy(entropy);
    let word_count = config_word_count(word_count);
    let mnemonic = generate_mnemonic(word_count, entropy_u8);
    mnemonic.to_string()
}

// pub fn generate_key(node_network: String, word_count:String, entropy:String, password: Option<String>,) -> ExtendedKeyInfo {
//     let entropy_u8 = config_entropy(entropy);
//     let word_count = config_word_count(word_count);
//     let node_network = config_network(node_network);
//     let response = generate_extended_key(node_network, word_count,entropy_u8, password);
//     return response.unwrap();
// }
pub fn create_key(node_network: String, mnemonic: String, password: Option<String>) -> ExtendedKeyInfo {
    let node_network = config_network(node_network);
    let response = restore_extended_key(node_network, mnemonic, password);
    return response.unwrap();
}

pub fn sync_wallet() {
    let wallet = WALLET.read().unwrap();
    let blockchain_obj = BLOCKCHAIN.read().unwrap();
    wallet.sync(blockchain_obj.deref());
}

pub fn get_balance() -> u64 {
    let res = WALLET.read().unwrap();
    let balance = res.get_balance().unwrap();
    balance
}

pub fn get_new_address() -> String {
    let res = WALLET.read().unwrap();
    let address = res.get_address(AddressIndex::New).unwrap().address;
    address
}

pub fn get_last_unused_address() -> String {
    let res = WALLET.read().unwrap();
    res.get_address(AddressIndex::New).unwrap().address
}

pub fn get_transactions() -> Vec<Transaction> {
    let res = WALLET.read().unwrap();
    let response: Vec<Transaction> = res.get_transactions().unwrap();
    return response;
}

pub fn create_transaction(recipient: String, amount: u64, fee_rate: f32) -> String {
    let res = WALLET.read().unwrap();
    sync_wallet();
    let tx_builder = TxBuilder::new();
    let x = tx_builder
        .add_recipient(recipient, amount)
        .fee_rate(fee_rate)
        .finish(&res);
    x.unwrap().serialize()
}

pub fn sign_and_broadcast(psbt_str: String) -> String {
    let wallet = WALLET.read().unwrap();
    let blockchain = BLOCKCHAIN.read().unwrap();
    wallet.sync(&blockchain);
    //  let psbt= deserialize(&base64::decode(&psbt_str).unwrap()).unwrap();
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    wallet.sign(&psbt).unwrap();
    let tx = psbt.internal.lock().unwrap().clone().extract_tx();
    blockchain.broadcast(&tx).unwrap();
    tx.txid().to_string()
}

#[cfg(test)]
mod tests {
    use crate::api::{wallet_init, BLOCKCHAIN, WALLET};
    use bdk::blockchain::{
        AnyBlockchain, AnyBlockchainConfig, ConfigurableBlockchain, ElectrumBlockchainConfig,
        EsploraBlockchain,
    };
    use crate::ffi::AddressIndex;

    #[test]
    fn init_wallet() {
        wallet_init(
            "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*)".to_string(),
            "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/1/*)".to_string(),
            "TESTNET".to_string(),
            "ELECTRUM".to_string(),
            "ssl://electrum.blockstream.info:60002".to_string(),
            "".to_string());
        let wallet = WALLET.read().unwrap();
        let balance = wallet.get_balance().unwrap();
        let address = wallet.get_address(AddressIndex::New).unwrap();
        assert_eq!(address.address, "test");
        assert_eq!(balance, 2450110);
    }
}

//
// #[derive(Serialize, Deserialize, PartialEq, Debug)]
// pub struct BridgeResult {
//     result: String,
//     data: Vec<String>,
// }
//
// impl Default for BridgeResult {
//     fn default() -> BridgeResult {
//         BridgeResult {
//             result: "".to_string(),
//             data: vec!["".to_string()],
//         }
//     }
// }
//
// impl BridgeResult {
//     fn err<E: std::fmt::Debug>(desc: &'static str, err: E) -> BridgeResult {
//         //this should write a log of every error
//         let mut file = OpenOptions::new()
//             .write(true)
//             .append(true)
//             .create(true)
//             .open("log.txt")
//             .expect("failed to open log");
//         let local: DateTime<Local> = Local::now();
//         file.write(format!("{} ///{}: {:?}\n", local.date(), desc, err).as_bytes())
//             .expect("failed to write log");
//         BridgeResult {
//             result: "Err()".to_string(),
//             data: vec![format!("{}: {:?}", desc, err)],
//         }
//     }
//
//     fn ok<D: std::string::ToString>(data: D) -> BridgeResult {
//         BridgeResult {
//             result: "Ok()".to_string(),
//             data: vec![data.to_string()],
//         }
//     }
// }
