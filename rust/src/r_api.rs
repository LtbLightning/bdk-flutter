use crate::ffi::{AddressIndex, ExtendedKeyInfo, PartiallySignedBitcoinTransaction, Transaction, TxBuilder, Wallet, generate_mnemonic_from_word_count, generate_mnemonic_from_entropy, ResponseWallet, Balance, DescriptorSecretKey, DerivationPath, AddressAmount, get_extended_key_info, DerivedKeyInfo};
use std::ops::Deref;
// use anyhow::{anyhow, Result};
use bdk::bitcoin::Network;
use bdk::blockchain::esplora::EsploraBlockchainConfig;
use bdk::blockchain::{
    AnyBlockchain, AnyBlockchainConfig, Blockchain as BdkBlockChain, ConfigurableBlockchain,
    ElectrumBlockchainConfig,
};
use bdk::keys::bip39::WordCount;
use lazy_static::lazy_static;
use std::sync::{Arc, RwLock};
use bdk::Error;
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
        _ => WordCount::Words12,
    };
}

fn config_entropy(entropy: String) -> usize {
    return match entropy.as_str() {
        "Entropy128" => 16,
        "Entropy160" => 20,
        "Entropy192" => 24,
        "Entropy224" => 28,
        "Entropy256" => 32,
        _ => 16,
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

fn config_blockchain(
    blockchain: &str,
    url: String,
    _socks5_or_proxy: Option<String>,
) -> AnyBlockchain {
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
    let optional_socks5_or_proxy = if socks5_or_proxy.is_empty() {
        None
    } else {
        Some(socks5_or_proxy)
    };
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

pub fn get_wallet() -> ResponseWallet {
    let wallet = WALLET.read().unwrap();
    let blockchain_obj = BLOCKCHAIN.read().unwrap();
    wallet.sync(blockchain_obj.deref());
    ResponseWallet {
        balance: get_balance(),
        address: get_new_address(),
    }
}

pub fn sync_wallet() {
    let wallet = WALLET.read().unwrap();
    let blockchain_obj = BLOCKCHAIN.read().unwrap();
    wallet.sync(blockchain_obj.deref());
}

pub fn get_balance() -> Balance {
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
    let response: Vec<Transaction> = res.get_transactions().unwrap().to_vec();
    return response;
}

pub fn create_transaction(recipient: String, amount: u64, fee_rate: f32) -> String {
    let wallet = WALLET.read().unwrap();
    sync_wallet();
    let tx_builder = TxBuilder::new();
    let psbt = tx_builder
        .add_recipient(recipient, amount)
        .fee_rate(fee_rate)
        .finish(&wallet);
    psbt.unwrap().serialize()
}

pub fn create_multi_sig_transaction( recipients: Vec<AddressAmount>, fee_rate: f32) -> String {
    let wallet = WALLET.read().unwrap();
    let tx_builder = TxBuilder::new();
    let psbt = tx_builder.set_recipients(recipients).fee_rate(fee_rate).finish(&wallet);
    psbt.unwrap().serialize()
}

pub fn sign_and_broadcast(psbt_str: String) -> String {
    let wallet = WALLET.read().unwrap();
    let blockchain = BLOCKCHAIN.read().unwrap();
    wallet.sync(&blockchain);
    let psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    wallet.sign(&psbt).unwrap();
    let tx = psbt.internal.lock().unwrap().clone().extract_tx();
    blockchain.broadcast(&tx).unwrap();
    tx.txid().to_string()
}

pub fn generate_seed_from_entropy( entropy: String) -> String {
    let entropy_u8 = config_entropy(entropy);
    let mnemonic = generate_mnemonic_from_entropy( entropy_u8);
    mnemonic.to_string()
}

pub fn generate_seed_from_word_count(word_count: String) -> String {
    let word_count = config_word_count(word_count);
    let mnemonic = generate_mnemonic_from_word_count(word_count);
    mnemonic.to_string()
}
pub fn create_key(
    node_network: String,
    mnemonic: String,
    password: Option<String>,
) -> ExtendedKeyInfo {
    let node_network = config_network(node_network);
    let response =  get_extended_key_info(node_network, mnemonic, password);
    return response;
}
pub fn create_descriptor_secret_keys(
    node_network: String,
    mnemonic: String,
    path:String,
    password: Option<String>,
) -> DerivedKeyInfo {
    let descriptor_secret = get_descriptor_secret_key( mnemonic.clone(), node_network,password);
    let derived_secret = derive_dsk(&descriptor_secret, path.as_str()).unwrap();
    let response = DerivedKeyInfo{
        xprv: derived_secret.as_string(),
        xpub: derived_secret.as_public().as_string()
    };
    return response
}

fn get_descriptor_secret_key(mnemonic:String, network:String, password:Option<String>) -> DescriptorSecretKey {
    let node_network = config_network(network);
    DescriptorSecretKey::new(node_network, mnemonic, password).unwrap()
}

fn derive_dsk(
    key: &DescriptorSecretKey,
    path: &str,
) -> Result<Arc<DescriptorSecretKey>, Error> {
    let path = Arc::new(DerivationPath::new(path.to_string()).unwrap());
    key.derive(path)
}
// fn extend_dsk(key: &DescriptorSecretKey, path: &str) -> Arc<DescriptorSecretKey> {
//     let path = Arc::new(DerivationPath::new(path.to_string()).unwrap());
//     key.extend(path)
// }

// fn extend_dpk(key: &DescriptorPublicKey, path: &str) -> Arc<DescriptorPublicKey> {
//     let path = Arc::new(DerivationPath::new(path.to_string()).unwrap());
//     key.extend(path)
// }

#[cfg(test)]
mod tests {
    use std::error::Error;
    use std::sync::Arc;
    use std::time::{SystemTime, UNIX_EPOCH};
    use bdk::bitcoin::{Address, Network};
    use serde::Serialize;

    use crate::ffi::{DerivationPath, DescriptorPublicKey, DescriptorSecretKey, PartiallySignedBitcoinTransaction};
    use crate::r_api::{ config_network, create_transaction, derive_dsk, generate_seed_from_entropy, generate_seed_from_word_count, get_balance, get_descriptor_secret_key, get_transactions, wallet_init};
    #[test]
    fn test_derive_hardened_path_using_public() {
        let master_dsk = get_descriptor_secret_key("chaos fabric time speed sponsor all flat solution wisdom trophy crack object robot pave observe combine where aware bench orient secret primary cable detect".to_string(),
                                                   "testnet".to_string(),None);
        let derived_sk = &derive_dsk(&master_dsk, "m/44/0/0/0/0").unwrap();
        assert_eq!(derived_sk.as_public().as_string(),"[d1d04177/44/0/0/0/0]tpubDH97TH9B3jVk4DodNDKD1HvaXcVU87j4SgGnGWTQq1pRZXCBeZufq3f9xPYQF14sAnL1Pb7WvQ5fZzbSCubTL5LhGFw3tu3DtPomnkKdA9F/*");
    }

    #[test]
    fn test_derive_hardened_path_using_private() {
        let master_dsk = get_descriptor_secret_key("chaos fabric time speed sponsor all flat solution wisdom trophy crack object robot pave observe combine where aware bench orient secret primary cable detect".to_string(),
                                                   "testnet".to_string(),None);
        let derived_sk = &derive_dsk(&master_dsk, "m").unwrap();
        assert_eq!(derived_sk.as_string(),"[d1d04177]tprv8kT5Js6vuMp5AkmqUZecbtGTxayXxnY9sNfzyzR7Qk22j2wR2B65eZ3HnFDFEqULi6kNMhtZLexeD4qoh4kpEoF1LkmPMViwHJRYXPL6EP3/*");
    }

    #[test]
    fn test_generate_descriptor_secret_key() {
        let master_dsk = get_descriptor_secret_key("chaos fabric time speed sponsor all flat solution wisdom trophy crack object robot pave observe combine where aware bench orient secret primary cable detect".to_string(),
                                                   "testnet".to_string(),None);
        assert_eq!(master_dsk.as_string(), "tprv8ZgxMBicQKsPdWuqM1t1CDRvQtQuBPyfL6GbhQwtxDKgUAVPbxmj71pRA8raTqLrec5LyTs5TqCxdABcZr77bt2KyWA5bizJHnC4g4ysm4h/*");
        assert_eq!(master_dsk.as_public().as_string(), "tpubD6NzVbkrYhZ4WywdEfYbbd62yuvqLjAZuPsNyvzCNV85JekAEMbKHWSHLF9h3j45SxewXDcLv328B1SEZrxg4iwGfmdt1pDFjZiTkGiFqGa/*");
    }

    fn test_init_wallet() {
        wallet_init(
            "wpkh([d1d04177]tprv8ZgxMBicQKsPdWuqM1t1CDRvQtQuBPyfL6GbhQwtxDKgUAVPbxmj71pRA8raTqLrec5LyTs5TqCxdABcZr77bt2KyWA5bizJHnC4g4ysm4h/*)".to_string(),
            "wpkh([d1d04177]tprv8ZgxMBicQKsPdWuqM1t1CDRvQtQuBPyfL6GbhQwtxDKgUAVPbxmj71pRA8raTqLrec5LyTs5TqCxdABcZr77bt2KyWA5bizJHnC4g4ysm4h/*)".to_string(),
            "TESTNET".to_string(),
            "ELECTRUM".to_string(),
            "ssl://electrum.blockstream.info:60002".to_string(),
            "".to_string());
    }

    #[test]
    fn create_broadcast_transaction_test() {
        test_init_wallet();
        let psbt = create_transaction("mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt".to_string(), 1200, 1.0);
        let res = broadcast(psbt);
        assert_eq!(res.is_empty(), false);
    }
    #[test]
    fn create_transaction_test() {
        test_init_wallet();
        let psbt = create_transaction("mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt".to_string(), 1200, 1.0);
        let x = PartiallySignedBitcoinTransaction::new(psbt).unwrap();
        let script =  x.internal.lock().unwrap().unsigned_tx.output.get(0).cloned().unwrap().script_pubkey;
        let output_address = Address::from_script(
            &script,
            Network::Testnet).unwrap().to_string();
        assert_eq!(output_address, "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt".to_string());
    }
    #[test]
    fn get_transactions_test() {
        test_init_wallet();
        assert_eq!(get_transactions().is_empty(), false);
    }
    #[test]
    fn get_balance_test() {
        test_init_wallet();
        assert_eq!(get_balance().total, 0);
    }

    #[test]
    fn generate_mnemonic_word_count_test(){
        let mnemonic= generate_seed_from_word_count("Words24".to_string());
        assert_eq!(mnemonic.split(" ").count(), 24)
    }
    #[test]
    fn generate_mnemonic_with_entropy_test(){
        let mnemonic= generate_seed_from_entropy("Entropy256".to_string());
        assert_eq!(mnemonic.split(" ").count(), 24)
    }
}

