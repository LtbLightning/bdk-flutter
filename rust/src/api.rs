use std::borrow::Borrow;
use std::sync::Arc;
use anyhow::{anyhow, Result};
use bdk::bitcoin::consensus::deserialize;
use bdk::blockchain::{Blockchain, ElectrumBlockchain};
use bdk::electrum_client::Client;
use flutter_rust_bridge::*;
use bdk::bitcoin::{base64, Network};
use bdk::Error;
use bdk::wallet::tx_builder;
use crate::ffi::{AddressIndex, ExtendedKeyInfo, generate_extended_key, PartiallySignedBitcoinTransaction, restore_extended_key, Transaction, TxBuilder, Wallet};

pub struct WalletObj{
    pub  descriptor: String,
    pub   change_descriptor: String,
    pub   network: String
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
pub fn generate_key(node_network:String) -> ExtendedKeyInfo {
    let node_network = config_network(node_network);
    let response = generate_extended_key(node_network);
    return  response
}
pub fn restore_key(node_network:String, mnemonic:String) -> ExtendedKeyInfo {
    let node_network = config_network(node_network);
    let response = restore_extended_key(node_network, mnemonic);
    return  response
}
pub fn  create_transaction(recipient: String, amount: u64, fee_rate: f32, wallet:WalletObj) -> String {
    let wallet_obj = wallet_init(wallet);
    let tx_builder = TxBuilder::new();
    let x =  tx_builder.add_recipient(recipient,amount).fee_rate(fee_rate).finish(&wallet_obj);
   x.unwrap().serialize()
    //  PartiallySignedBitcoinTransaction::new(t).unwrap()
}
pub fn sync_wallet(wallet:WalletObj) {
    wallet_init(wallet);
}
pub fn get_balance(wallet:WalletObj) -> u64 {
    let wallet_obj =  wallet_init(wallet);
    wallet_obj.get_balance().unwrap()
}
pub fn get_new_address(wallet:WalletObj) -> String {
    let wallet_obj =  wallet_init(wallet);
    wallet_obj.get_address(AddressIndex::New).unwrap().address
}
pub fn get_last_unused_address(wallet:WalletObj) -> String {
    let wallet_obj =  wallet_init(wallet);
    wallet_obj.get_address(AddressIndex::New).unwrap().address
}
pub fn get_transactions(wallet:WalletObj) -> Vec<Transaction> {
    let wallet =  wallet_init(wallet);
    let response: Vec<Transaction> = wallet.get_transactions().unwrap();
    return  response;
}
pub fn sign_and_broadcast(wallet:WalletObj, psbt_str:String) -> usize {
    let blockchain = blockchain_init();
    let wallet =  wallet_init(wallet);
    let  psbt = PartiallySignedBitcoinTransaction::new(psbt_str).unwrap();
    wallet.sign(&psbt);
    let tx = psbt.internal.lock().unwrap().clone().extract_tx();
    blockchain.broadcast(&tx).unwrap();
    tx.size()
}

fn wallet_init(wallet:WalletObj) -> Wallet{
    let node_network = config_network(wallet.network.clone());
    let blockchain_obj = blockchain_init();
    let wallet = Wallet::new(
        wallet.descriptor.clone(),
        Some(wallet.change_descriptor.clone()),
        node_network,
    ).unwrap();
    wallet.sync(blockchain_obj);
    return  wallet;
}
fn blockchain_init() -> ElectrumBlockchain {
    let blockchain =
        ElectrumBlockchain::from(Client::new("ssl://electrum.blockstream.info:60002").unwrap());
    return blockchain;
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

// fn generate_mnemonic(data: &String, wallet_obj: Wallet) -> BridgeResult {
//     #[derive(Deserialize)]
//     struct Arguments {
//         network: String,
//     }
//     let arguments: Arguments = match serde_json::from_str(&data) {
//         Ok(data) => data,
//         Err(err) => return BridgeResult::err("failed to parse arguments\n, {}", err),
//     };
//     let node_network = self::config_network(arguments.network.to_string());
//     let response = generate_extended_key(node_network);
//     let response_str = serde_json::to_string(&response.mnemonic.clone().to_string()).unwrap();
//     return BridgeResult::ok(response_str);
// }
// fn config_blockchain(blockchain: &str, url: String, socks5: Option<String>) -> BlockchainConfig {
//     return match blockchain {
//         "ELECTRUM" => BlockchainConfig::Electrum {
//             config: ElectrumConfig {
//                 url,
//                 socks5,
//                 retry: 0,
//                 timeout: None,
//                 stop_gap: 0,
//             },
//         },
//         "ESPLORA" => BlockchainConfig::Esplora {
//             config: EsploraConfig {
//                 concurrency: None,
//                 stop_gap: 10,
//                 timeout: None,
//                 base_url: url,
//                 proxy: None,
//             },
//         },
//         _ => BlockchainConfig::Electrum {
//             config: ElectrumConfig {
//                 url,
//                 socks5,
//                 retry: 0,
//                 timeout: None,
//                 stop_gap: 0,
//             },
//         },
//     };
// }





