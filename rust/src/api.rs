#![allow(unused_variables)]
use std::ffi::{CString, CStr};
use bdk::bitcoin::hashes::hex::ToHex;
use bdk::bitcoin::secp256k1::Secp256k1;
use bdk::bitcoin::util::psbt::PartiallySignedTransaction;
use bdk::bitcoin::{Address, Network, Script, Txid};
use bdk::blockchain::any::{AnyBlockchain, AnyBlockchainConfig};
use bdk::blockchain::{
    electrum::ElectrumBlockchainConfig, esplora::EsploraBlockchainConfig, ConfigurableBlockchain,
};
use bdk::blockchain::{Blockchain as BdkBlockchain, Progress as BdkProgress};
use bdk::database::any::{AnyDatabase, SledDbConfiguration, SqliteDbConfiguration};
use bdk::database::{AnyDatabaseConfig, ConfigurableDatabase};
use bdk::keys::bip39::{Language, Mnemonic, WordCount};
use bdk::keys::{DerivableKey, ExtendedKey, GeneratableKey, GeneratedKey};
use bdk::miniscript::BareCtx;
use bdk::wallet::AddressIndex as BdkAddressIndex;
use bdk::wallet::AddressInfo as BdkAddressInfo;
use bdk::{BlockTime, descriptor, doctest_wallet, Error, FeeRate, KeychainKind, SignOptions, SyncOptions as BdkSyncOptions, Wallet as BdkWallet};
use std::convert::{From, TryFrom};
use std::fmt;
use std::fs::OpenOptions;
use std::io::Write;
use std::ops::Deref;
use std::os::raw::c_char;
use std::str::FromStr;
use std::sync::{Arc, Mutex, MutexGuard};
use bdk::template::Bip84;

extern crate chrono;
use chrono::{DateTime, Local};
use serde_json::Value;
use serde::{Deserialize, Serialize};

type BdkError = Error;

#[repr(C)]
pub enum AddressIndex {
    New,
    LastUnused,
}
#[repr(C)]
pub enum DatabaseConfig {
    Memory,
    Sled { config: SledDbConfiguration },
    Sqlite { config: SqliteDbConfiguration },
}
#[repr(C)]
pub enum BlockchainConfig {
    Electrum { config: ElectrumConfig },
    Esplora { config: EsploraConfig },
}


#[derive(Serialize, Deserialize)]
pub struct ResponseWallet {
    balance: String,
    address:String,
    mnemonic:String,

}
#[repr(C)]
pub struct ExtendedKeyInfo {
    pub mnemonic: String,
    pub  xprv: String,
    pub  fingerprint: String,
}

struct ProgressHolder {
    progress: Box<dyn Progress>,
}
#[repr(C)]
pub struct AddressInfo {
    pub index: u32,
    pub address: String,
}
#[repr(C)]
pub struct ElectrumConfig {
    pub url: String,
    pub socks5: Option<String>,
    pub retry: u8,
    pub timeout: Option<u8>,
    pub stop_gap: u64,
}
#[repr(C)]
pub struct EsploraConfig {
    pub base_url: String,
    pub proxy: Option<String>,
    pub concurrency: Option<u8>,
    pub stop_gap: u64,
    pub timeout: Option<u64>,
}
#[derive(Debug, Clone, PartialEq, Eq, Default)]
#[repr(C)]
pub struct TransactionDetails {
    pub fee: Option<u64>,
    pub received: u64,
    pub sent: u64,
    pub txid: String,
}
#[derive(Debug, Clone, PartialEq, Eq)]
#[repr(C)]
pub enum Transaction {
    Unconfirmed {
        details: TransactionDetails,
    },
    Confirmed {
        details: TransactionDetails,
        confirmation: BlockTime,
    },
}

struct Wallet {
    wallet_mutex: Mutex<BdkWallet<AnyDatabase>>,
}
struct Blockchain {
    blockchain_mutex: Mutex<AnyBlockchain>,
}
struct PartiallySignedBitcoinTransaction {
    internal: Mutex<PartiallySignedTransaction>,
}

pub trait Progress: Send + Sync + 'static {
    fn update(&self, progress: f32, message: Option<String>);
}

impl BdkProgress for ProgressHolder {
    fn update(&self, progress: f32, message: Option<String>) -> Result<(), Error> {
        self.progress.update(progress, message);
        Ok(())
    }
}
impl fmt::Debug for ProgressHolder {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("ProgressHolder").finish_non_exhaustive()
    }
}

impl From<BdkAddressInfo> for AddressInfo {
    fn from(x: bdk::wallet::AddressInfo) -> AddressInfo {
        AddressInfo {
            index: x.index,
            address: x.address.to_string(),
        }
    }
}

impl From<AddressIndex> for BdkAddressIndex {
    fn from(x: AddressIndex) -> BdkAddressIndex {
        match x {
            AddressIndex::New => BdkAddressIndex::New,
            AddressIndex::LastUnused => BdkAddressIndex::LastUnused,
        }
    }
}

impl From<&bdk::TransactionDetails> for TransactionDetails {
    fn from(x: &bdk::TransactionDetails) -> TransactionDetails {
        TransactionDetails {
            fee: x.fee,
            txid: x.txid.to_string(),
            received: x.received,
            sent: x.sent,
        }
    }
}
impl From<&bdk::TransactionDetails> for Transaction {
    fn from(x: &bdk::TransactionDetails) -> Transaction {
        match x.confirmation_time.clone() {
            Some(block_time) => Transaction::Confirmed {
                details: TransactionDetails::from(x),
                confirmation: block_time,
            },
            None => Transaction::Unconfirmed {
                details: TransactionDetails::from(x),
            },
        }
    }
}

impl Blockchain {
    fn new(blockchain_config: BlockchainConfig) -> Result<Self, BdkError> {
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
        let blockchain = AnyBlockchain::from_config(&any_blockchain_config)?;
        Ok(Self {
            blockchain_mutex: Mutex::new(blockchain),
        })
    }

    fn get_blockchain(&self) -> MutexGuard<AnyBlockchain> {
        self.blockchain_mutex.lock().expect("blockchain")
    }

    fn broadcast(&self, psbt: &PartiallySignedBitcoinTransaction) -> Result<(), Error> {
        let tx = psbt.internal.lock().unwrap().clone().extract_tx();
        self.get_blockchain().broadcast(&tx)
    }
}
impl PartiallySignedBitcoinTransaction {
    fn new(psbt_base64: String) -> Result<Self, Error> {
        let psbt: PartiallySignedTransaction = PartiallySignedTransaction::from_str(&psbt_base64)?;
        Ok(PartiallySignedBitcoinTransaction {
            internal: Mutex::new(psbt),
        })
    }

    fn serialize(&self) -> String {
        let psbt = self.internal.lock().unwrap().clone();
        psbt.to_string()
    }

    fn txid(&self) -> String {
        let tx = self.internal.lock().unwrap().clone().extract_tx();
        let txid = tx.txid();
        txid.to_hex()
    }
}

impl Wallet{
    fn default() -> Result<Self, BdkError>{
        let key = generate_extended_key(Network::Testnet);
        let default_descriptor =create_descriptor(key.mnemonic.clone()).clone();
        let default_change_descriptor = create_change_descriptor(default_descriptor.clone());
        let database_config =DatabaseConfig::Memory;
        let default_database_config = match database_config {
            DatabaseConfig::Memory => AnyDatabaseConfig::Memory(()),
            DatabaseConfig::Sled { config } => AnyDatabaseConfig::Sled(config),
            DatabaseConfig::Sqlite { config } => AnyDatabaseConfig::Sqlite(config),
        };
        let database = AnyDatabase::from_config(&default_database_config).unwrap();
        let wallet_mutex = Mutex::new(BdkWallet::new(
            "wpkh(tprv8ZgxMBicQKsPe73PBRSmNbTfbcsZnwWhz5eVmhHpi31HW29Z7mc9B4cWGRQzopNUzZUT391DeDJxL2PefNunWyLgqCKRMDkU1s2s8bAfoSk/84'/0'/0'/0/*)",
            None,
            Network::Testnet,
            database,
        ).unwrap());
        Ok(Wallet { wallet_mutex })
    }
    fn new(
        descriptor: String,
        change_descriptor: Option<String>,
        network: Network,
        database_config: DatabaseConfig,
    ) -> Result<Self, BdkError> {
        let any_database_config = match database_config {
            DatabaseConfig::Memory => AnyDatabaseConfig::Memory(()),
            DatabaseConfig::Sled { config } => AnyDatabaseConfig::Sled(config),
            DatabaseConfig::Sqlite { config } => AnyDatabaseConfig::Sqlite(config),
        };
        let database = AnyDatabase::from_config(&any_database_config)?;
        let wallet_mutex = Mutex::new(BdkWallet::new(
            &descriptor,
            change_descriptor.as_ref(),
            network,
            database,
        )?);
        Ok(Wallet { wallet_mutex })
    }

    fn get_wallet(&self) -> MutexGuard<BdkWallet<AnyDatabase>> {
        self.wallet_mutex.lock().expect("wallet")
    }

    fn get_network(&self) -> Network {
        self.get_wallet().network()
    }

    fn sync(
        &self,
        blockchain: &Blockchain,
        progress: Option<Box<dyn Progress>>,
    ) -> Result<(), BdkError> {
        let bdk_sync_opts = BdkSyncOptions {
            progress: progress.map(|p| {
                Box::new(ProgressHolder { progress: p })
                    as Box<(dyn bdk::blockchain::Progress + 'static)>
            }),
        };

        let blockchain = blockchain.get_blockchain();
        self.get_wallet().sync(blockchain.deref(), bdk_sync_opts)
    }

    fn get_address(&self, address_index: AddressIndex) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_address(address_index.into())
            .map(AddressInfo::from)
    }

    fn get_balance(&self) -> Result<u64, Error> {
        self.get_wallet().get_balance()
    }

    fn sign(&self, psbt: &PartiallySignedBitcoinTransaction) -> Result<bool, Error> {
        let mut psbt = psbt.internal.lock().unwrap();
        self.get_wallet().sign(&mut psbt, SignOptions::default())
    }

    fn get_transactions(&self) -> Result<Vec<Transaction>, Error> {
        let transactions = self.get_wallet().list_transactions(true)?;
        Ok(transactions.iter().map(Transaction::from).collect())
    }
}

fn generate_extended_key(
    network: Network,
) -> ExtendedKeyInfo {
    let mnemonic_gen: GeneratedKey<_, BareCtx> = Mnemonic::generate((WordCount::Words12, Language::English)).unwrap();
    let mnemonic = mnemonic_gen.clone().into_key();
    let xkey:ExtendedKey<BareCtx> = mnemonic_gen.into_extended_key().unwrap();
    let xprv = xkey.into_xprv(network).unwrap();
    let fingerprint = xprv.fingerprint(&Secp256k1::new());
    return  ExtendedKeyInfo {
        mnemonic: mnemonic.to_string(),
        xprv: xprv.to_string(),
        fingerprint: fingerprint.to_string(),
    }
}

fn restore_extended_key(
    network: Network,
    mnemonic: String,
) -> ExtendedKeyInfo {
    let mnemonic_parse = Mnemonic::parse(mnemonic.clone()).unwrap();
    let xkey:ExtendedKey<BareCtx> = mnemonic_parse.into_extended_key().unwrap();
    let xprv = xkey.into_xprv(network).unwrap();
    let fingerprint = xprv.fingerprint(&Secp256k1::new());
    return   ExtendedKeyInfo {
        mnemonic: mnemonic.clone(),
        xprv: xprv.to_string(),
        fingerprint: fingerprint.to_string(),
    }
}

pub fn create_descriptor(xprv: String) -> String {
    return "wpkh([c258d2e4/84h/1h/0h]".to_owned() + &*xprv + "/84'/1'/0'/0/*)";
}

pub fn create_change_descriptor(xprv: String) -> String {
    return "wpkh([c258d2e4/84h/1h/0h]".to_owned() + &*xprv + "/84'/1'/0'/1/*)";
}

/*
============== UTILS ===================
*/
fn config_network(network: &str) -> Network {
    return match network{
        "SIGNET" => Network::Signet,
        "TESTNET" => Network::Testnet,
        "REGTEST" => Network::Regtest,
        "BITCOIN" => Network::Bitcoin,
        _=> Network::Testnet,
    }
}
fn config_blockchain(url: &str, socks5: String) -> AnyBlockchainConfig {
    return match url{
        "ELECTRUM" =>   AnyBlockchainConfig::Electrum(ElectrumBlockchainConfig {
            retry: 10,
            socks5: Option::from(socks5),
            timeout: None,
            url:String::from(url),
            stop_gap: 10,
        }),
        "ESPLORA" =>AnyBlockchainConfig::Esplora(EsploraBlockchainConfig {
            concurrency: None,
            stop_gap: 10,
            timeout: None,
            base_url:String::from(url),
            proxy: None
        }),
        _ =>   AnyBlockchainConfig::Electrum(ElectrumBlockchainConfig {
            retry:10,
            socks5: Option::from(socks5),
            timeout: None,
            url:String::from(url),
            stop_gap: 10,
        })
    }
}


#[derive(Serialize, Deserialize)]
pub struct BridgeResult {
    result: String,
    data: Vec<String>
}

impl Default for BridgeResult {
    fn default() -> BridgeResult {
        BridgeResult {
            result: "".to_string(),
            data: vec!["".to_string()]

        }
    }
}

impl BridgeResult {
    fn new(result: &'static str, data: String) -> BridgeResult {
        BridgeResult {
            result: result.to_string(),
            data: vec![data.to_string()]
        }
    }

    fn err<E: std::fmt::Debug>(desc: &'static str, err: E) -> BridgeResult {
        //this should write a log of every error
        let mut file = OpenOptions::new()
            .write(true)
            .append(true)
            .create(true)
            .open("log.txt").expect("failed to open log");
        let local: DateTime<Local> = Local::now();
        file.write(format!("{} ///{}: {:?}\n", local.date(), desc, err).as_bytes()).expect("failed to write log");
        BridgeResult {
            result: "Err()".to_string(),
            data: vec![format!("{}: {:?}", desc, err)]
        }
    }

    fn ok<D: std::string::ToString>(data: D) -> BridgeResult {
        BridgeResult {
            result: "Ok()".to_string(),
            data: vec![data.to_string()]
        }
    }
}

fn create_wallet(data: &String, mut wallet_obj: Wallet) -> BridgeResult {
    #[derive(Deserialize)]
    struct Arguments {
        network: String,
        mnemonic:String,
        // arguments for creating the block chain with create wallet
    }
    let  arguments: Arguments = match serde_json::from_str(&data) {
        Ok(data) => data,
        Err(err) => return BridgeResult::err("failed to parse arguments\n, {}", err)
    };
    let node_network = self::config_network(arguments.network.as_str());
    let key = restore_extended_key(node_network, arguments.mnemonic);
    let wallet_descriptor:String = create_descriptor(key.xprv.clone());
    let change_descriptor:String = create_change_descriptor(key.xprv.clone());
    wallet_obj = Wallet::new(
        wallet_descriptor,
        Some(change_descriptor),
        node_network, DatabaseConfig::Memory).unwrap();
    let response = ResponseWallet {
        balance: wallet_obj.get_balance().unwrap().clone().to_string(),
        address: wallet_obj.get_address(AddressIndex::New).unwrap().address.clone(),
        mnemonic: key.mnemonic.clone()
    };
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response).unwrap();
    return  BridgeResult::ok(response_str);
}
fn restore_wallet(data: &String, mut wallet_obj: Wallet) -> BridgeResult {
    #[derive(Deserialize)]
    struct Arguments {
        network: String,
        mnemonic:String,
    }
    let  arguments: Arguments = match serde_json::from_str(&data) {
        Ok(data) => data,
        Err(err) => return BridgeResult::err("failed to parse arguments\n, {}", err)
    };
    let node_network = self::config_network(arguments.network.as_str());
    let key = restore_extended_key(node_network, arguments.mnemonic);
    let wallet_descriptor:String = create_descriptor(key.xprv.clone());
    let change_descriptor:String = create_change_descriptor(key.xprv.clone());
    wallet_obj = Wallet::new(
        wallet_descriptor,
        Some(change_descriptor),
        node_network, DatabaseConfig::Memory).unwrap();
    let response = ResponseWallet {
        balance: wallet_obj.get_balance().unwrap().clone().to_string(),
        address: wallet_obj.get_address(AddressIndex::New).unwrap().address.clone(),
        mnemonic: key.mnemonic.clone()
    };
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response).unwrap();
    return  BridgeResult::ok(response_str);
}
fn  get_balance( wallet_obj: Wallet) -> BridgeResult {
    let response = wallet_obj.get_balance().unwrap();
    let response_str = serde_json::to_string(&response).unwrap();
    return  BridgeResult::ok(response_str);
}

fn  generate_mnemonic(data: &String, mut wallet_obj: Wallet) -> BridgeResult {
    #[derive(Deserialize)]
    struct Arguments {
        network: String,
    }
    let  arguments: Arguments = match serde_json::from_str(&data) {
        Ok(data) => data,
        Err(err) => return BridgeResult::err("failed to parse arguments\n, {}", err)
    };
    let node_network = self::config_network(arguments.network.as_str());
    let response = generate_extended_key(node_network);
    let response_str = serde_json::to_string(&response.mnemonic.clone().to_string()).unwrap();
    return  BridgeResult::ok(response_str);
}
fn  get_wallet(wallet_obj: Wallet) -> BridgeResult {
    let response = ResponseWallet {
        balance: wallet_obj.get_balance().unwrap().clone().to_string(),
        address: wallet_obj.get_address(AddressIndex::New).unwrap().address.clone(),
        mnemonic: "Mnemonic seed is pivate!!!!!!!".parse().unwrap(),
    };
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response).unwrap();
    return  BridgeResult::ok(response_str);
}
fn  get_new_address(wallet_obj: Wallet) -> BridgeResult {
    let response = wallet_obj.get_address(AddressIndex::New);
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response.unwrap().address).unwrap();
    return  BridgeResult::ok(response_str);
}
fn  get_network(wallet_obj: Wallet) -> BridgeResult {
    let response = wallet_obj.get_network();
    // Serialize it to a JSON string.
    let response_str = serde_json::to_string(&response.to_string()).unwrap();
    return  BridgeResult::ok(response_str);
}

/*
==============  C HEADER FUNCTIONS==========
*/
fn handle_functions(function: String, arguments: String) -> String {
    let  wallet:Wallet = Wallet::default().unwrap();
    //return error for bad function here, return error for bad args in each function after deserialization
    let result = match function.as_str() {
        "generate_seed" =>  generate_mnemonic(&arguments, wallet),
        "create" => create_wallet(&arguments, wallet),
        "restore" => restore_wallet(&arguments, wallet),
        "get_balance" => get_balance( wallet),
        "get_wallet" =>get_wallet( wallet),
        "get_network" =>get_network( wallet),
        "get_new_address" =>get_new_address( wallet),

        _ => BridgeResult::err("cannot find rust function branch matching {}", function)
    };
    let output = match serde_json::to_string(&result) {
        Ok(output) => output,
        Err(_) => "{'result' : 'Err()', 'data': 'failed exit encoding!!!'}".to_string()
    };
    output
}


pub fn handle_rust(function: String, arguments:  String) -> String {
    let output = handle_functions(function, arguments);
    return  output;
}
/*
============== TEST ==========
*/






