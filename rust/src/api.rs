#![allow(unused_variables)]
use crate::ffi::{
    create_change_descriptor, create_descriptor, generate_extended_key, restore_extended_key,
    AddressIndex, BlockchainConfig, DatabaseConfig, ElectrumConfig, EsploraConfig, Transaction,
    Wallet,
};
use bdk::bitcoin::Network;
use bdk::blockchain::ElectrumBlockchain;
use bdk::database::MemoryDatabase;
use bdk::electrum_client::Client;
use ffi::ResponseWallet;
use std::fs::OpenOptions;
use std::io::Write;
use bdk::descriptor;

extern crate chrono;
use crate::ffi;
use chrono::{DateTime, Local};
use serde::{Deserialize, Serialize};

fn config_network(network: &str) -> Network {
    return match network {
        "SIGNET" => Network::Signet,
        "TESTNET" => Network::Testnet,
        "REGTEST" => Network::Regtest,
        "BITCOIN" => Network::Bitcoin,
        _ => Network::Testnet,
    };
}

fn config_blockchain(blockchain: &str, url: String, socks5: Option<String>) -> BlockchainConfig {
    return match blockchain {
        "ELECTRUM" => BlockchainConfig::Electrum {
            config: ElectrumConfig {
                url,
                socks5,
                retry: 0,
                timeout: None,
                stop_gap: 0,
            },
        },
        "ESPLORA" => BlockchainConfig::Esplora {
            config: EsploraConfig {
                concurrency: None,
                stop_gap: 10,
                timeout: None,
                base_url: url,
                proxy: None,
            },
        },
        _ => BlockchainConfig::Electrum {
            config: ElectrumConfig {
                url,
                socks5,
                retry: 0,
                timeout: None,
                stop_gap: 0,
            },
        },
    };
}

#[derive(Serialize, Deserialize, PartialEq, Debug)]
pub struct BridgeResult {
    result: String,
    data: Vec<String>,
}

impl Default for BridgeResult {
    fn default() -> BridgeResult {
        BridgeResult {
            result: "".to_string(),
            data: vec!["".to_string()],
        }
    }
}

impl BridgeResult {
    fn err<E: std::fmt::Debug>(desc: &'static str, err: E) -> BridgeResult {
        //this should write a log of every error
        let mut file = OpenOptions::new()
            .write(true)
            .append(true)
            .create(true)
            .open("log.txt")
            .expect("failed to open log");
        let local: DateTime<Local> = Local::now();
        file.write(format!("{} ///{}: {:?}\n", local.date(), desc, err).as_bytes())
            .expect("failed to write log");
        BridgeResult {
            result: "Err()".to_string(),
            data: vec![format!("{}: {:?}", desc, err)],
        }
    }

    fn ok<D: std::string::ToString>(data: D) -> BridgeResult {
        BridgeResult {
            result: "Ok()".to_string(),
            data: vec![data.to_string()],
        }
    }
}
fn generate_mnemonic(data: &String, wallet_obj: Wallet) -> BridgeResult {
    #[derive(Deserialize)]
    struct Arguments {
        network: String,
    }
    let arguments: Arguments = match serde_json::from_str(&data) {
        Ok(data) => data,
        Err(err) => return BridgeResult::err("failed to parse arguments\n, {}", err),
    };
    let node_network = self::config_network(arguments.network.as_str());
    let response = generate_extended_key(node_network);
    let response_str = serde_json::to_string(&response.mnemonic.clone().to_string()).unwrap();
    return BridgeResult::ok(response_str);
}
fn create_or_restore_wallet(
    data: &String,
    mut wallet_obj: Wallet,
    blockchain_obj: ElectrumBlockchain,
) -> BridgeResult {
    #[derive(Deserialize)]
    struct Arguments {
        network: String,
        mnemonic: String,
        url: String,
    }
    let arguments: Arguments = match serde_json::from_str(&data) {
        Ok(data) => data,
        Err(err) => return BridgeResult::err("failed to parse arguments\n, {}", err),
    };
    let node_network = self::config_network(arguments.network.as_str());
    let key = restore_extended_key(node_network, arguments.mnemonic);
    let wallet_descriptor= create_descriptor(key.xprv.clone());
    let change_descriptor= create_change_descriptor(key.xprv.clone());
    wallet_obj = Wallet::new(
        wallet_descriptor,
        Some(change_descriptor),
        node_network,
        DatabaseConfig::Memory,
    )
    .unwrap();
    //  let socket5_url = if arguments.socket5.is_empty() || arguments.socket5=="" {  None} else { Some(arguments.socket5)};
    let response = ResponseWallet {
        balance: wallet_obj.get_balance().unwrap().clone().to_string(),
        address: wallet_obj
            .get_address(AddressIndex::New)
            .unwrap()
            .address
            .clone(),
        mnemonic: key.mnemonic.clone(),
    };
    self::sync_wallet(wallet_obj, blockchain_obj);
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response).unwrap();
    return BridgeResult::ok(response_str);
}
fn blockchain_init() -> ElectrumBlockchain {
    let blockchain =
        ElectrumBlockchain::from(Client::new("ssl://electrum.blockstream.info:60002").unwrap());
    return blockchain;
}
fn get_balance(wallet_obj: Wallet) -> BridgeResult {
    let response = wallet_obj.get_balance().unwrap();
    println!("wallet print{}", response.to_string());
    let response_str = serde_json::to_string(&response).unwrap();
    return BridgeResult::ok(response_str);
}
fn get_wallet(wallet_obj: Wallet) -> BridgeResult {
    let response = ResponseWallet {
        balance: wallet_obj.get_balance().unwrap().clone().to_string(),
        address: wallet_obj
            .get_address(AddressIndex::New)
            .unwrap()
            .address
            .clone(),
        mnemonic: "hidden".to_string(),
    };
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response).unwrap();
    return BridgeResult::ok(response_str);
}
fn get_new_address(wallet_obj: Wallet) -> BridgeResult {
    let response = wallet_obj.get_address(AddressIndex::New);
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response.unwrap().address).unwrap();
    return BridgeResult::ok(response_str);
}
fn get_network(wallet_obj: Wallet) -> BridgeResult {
    let response = wallet_obj.get_network();
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response.to_string()).unwrap();
    return BridgeResult::ok(response_str);
}
fn get_transactions(wallet_obj: Wallet) -> BridgeResult {
    let response: Vec<Transaction> = wallet_obj.get_transactions().unwrap();
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response.to_owned()).unwrap();
    return BridgeResult::ok(response_str);
}
fn sync_wallet(wallet_obj: Wallet, blockchain_obj: ElectrumBlockchain) -> BridgeResult {
    return match wallet_obj.sync(blockchain_obj) {
        Ok(()) => BridgeResult::ok(""),
        Err(err) => return BridgeResult::err("failed to parse arguments\n, {}", err),
    };
}

/*
==============  C HEADER FUNCTIONS==========
*/
fn handle_functions(function: String, arguments: String) -> String {
    let wallet: Wallet = Wallet::default().unwrap();
    let blockchain: ElectrumBlockchain = blockchain_init();
    //return error for bad function here, return error for bad args in each function after deserialization
    let result = match function.as_str() {
        "generate_seed" => generate_mnemonic(&arguments, wallet),
        "create_or_restore" => create_or_restore_wallet(&arguments, wallet, blockchain),
        "get_balance" => get_balance(wallet),
        "get_wallet" => get_wallet(wallet),
        "get_network" => get_network(wallet),
        "get_new_address" => get_new_address(wallet),
        "get_transactions" => get_transactions(wallet),
        "sync" => sync_wallet(wallet, blockchain),
        _ => BridgeResult::err("cannot find rust function branch matching {}", function),
    };
    let output = match serde_json::to_string(&result) {
        Ok(output) => output,
        Err(_) => "{'result' : 'Err()', 'data': 'failed exit encoding!!!'}".to_string(),
    };
    output
}

pub fn handle_rust(function: String, arguments: String) -> String {
    let output = handle_functions(function, arguments);
    return output;
}
#[cfg(test)]
mod tests {
    use crate::api::{blockchain_init, get_wallet, sync_wallet, Wallet};
    use bdk::bitcoin::Network::Testnet;
    use bdk::blockchain::ElectrumBlockchain;

    #[test]
    fn test_sync() {
        let wallet: Wallet = Wallet::default().unwrap();
        let blockchain: ElectrumBlockchain = blockchain_init();
        // let res = get_wallet(wallet).data;
        // println!("{}", wallet.get_balance().unwrap().to_string());
        let res = wallet.get_balance().unwrap().to_string().clone();
        println!("test wallet{}", wallet.get_balance().unwrap().to_string());
        assert_eq!(res, "0");
    }
}
