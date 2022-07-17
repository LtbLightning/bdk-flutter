use bdk::bitcoin::hashes::hex::ToHex;
use bdk::bitcoin::secp256k1::Secp256k1;
use bdk::bitcoin::util::psbt::PartiallySignedTransaction;
use bdk::bitcoin::{Address, Network, Script, Txid};
use bdk::blockchain::any::AnyBlockchain;
use bdk::blockchain::ElectrumBlockchain;
use bdk::blockchain::Progress as BdkProgress;
use bdk::blockchain::{electrum::ElectrumBlockchainConfig, esplora::EsploraBlockchainConfig};
use bdk::database::any::{AnyDatabase, SledDbConfiguration, SqliteDbConfiguration};
use bdk::database::{AnyDatabaseConfig, ConfigurableDatabase};
use bdk::keys::bip39::{Language, Mnemonic, WordCount};
use bdk::keys::{DerivableKey, ExtendedKey, GeneratableKey, GeneratedKey};
use bdk::miniscript::BareCtx;
use bdk::wallet::AddressIndex as BdkAddressIndex;
use bdk::wallet::AddressInfo as BdkAddressInfo;
use bdk::{
    BlockTime, Error, SignOptions, SyncOptions as BdkSyncOptions, SyncOptions, Wallet as BdkWallet,
};
use serde::{Deserialize, Serialize};
use std::convert::From;
use std::fmt;
use std::os::raw::c_char;
use std::str::FromStr;
use std::sync::{Mutex, MutexGuard};

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
    pub balance: String,
    pub address: String,
    pub mnemonic: String,
}
#[repr(C)]
pub struct ExtendedKeyInfo {
    pub mnemonic: String,
    pub xprv: String,
    pub fingerprint: String,
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
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[repr(C)]
pub struct TransactionDetails {
    pub fee: Option<u64>,
    pub received: u64,
    pub sent: u64,
    pub txid: String,
}
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
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

pub struct Wallet {
    wallet_mutex: Mutex<BdkWallet<AnyDatabase>>,
}

struct Blockchain {
    blockchain_mutex: Mutex<AnyBlockchain>,
}
struct PartiallySignedBitcoinTransaction {
    internal: Mutex<PartiallySignedTransaction>,
}
struct ProgressHolder {
    progress: Box<dyn Progress>,
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

impl Wallet {
    pub(crate) fn default() -> Result<Self, BdkError> {
        let database_config = DatabaseConfig::Memory;
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
    pub(crate) fn new(
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

    pub(crate) fn get_network(&self) -> Network {
        self.get_wallet().network()
    }
    pub(crate) fn sync(&self, blockchain: ElectrumBlockchain) -> Result<(), BdkError> {
        self.get_wallet().sync(&blockchain, SyncOptions::default())
    }

    pub(crate) fn get_address(&self, address_index: AddressIndex) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_address(address_index.into())
            .map(AddressInfo::from)
    }

    pub(crate) fn get_balance(&self) -> Result<u64, Error> {
        self.get_wallet().get_balance()
    }

    fn sign(&self, psbt: &PartiallySignedBitcoinTransaction) -> Result<bool, Error> {
        let mut psbt = psbt.internal.lock().unwrap();
        self.get_wallet().sign(&mut psbt, SignOptions::default())
    }

    pub(crate) fn get_transactions(&self) -> Result<Vec<Transaction>, Error> {
        let transactions = self.get_wallet().list_transactions(true)?;
        Ok(transactions.iter().map(Transaction::from).collect())
    }
}

pub fn generate_extended_key(network: Network) -> ExtendedKeyInfo {
    let mnemonic_gen: GeneratedKey<_, BareCtx> =
        Mnemonic::generate((WordCount::Words12, Language::English)).unwrap();
    let mnemonic = mnemonic_gen.clone().into_key();
    let xkey: ExtendedKey<BareCtx> = mnemonic_gen.into_extended_key().unwrap();
    let xprv = xkey.into_xprv(network).unwrap();
    let fingerprint = xprv.fingerprint(&Secp256k1::new());
    return ExtendedKeyInfo {
        mnemonic: mnemonic.to_string(),
        xprv: xprv.to_string(),
        fingerprint: fingerprint.to_string(),
    };
}

pub fn restore_extended_key(network: Network, mnemonic: String) -> ExtendedKeyInfo {
    let mnemonic_parse = Mnemonic::parse(mnemonic.clone()).unwrap();
    let xkey: ExtendedKey<BareCtx> = mnemonic_parse.into_extended_key().unwrap();
    let xprv = xkey.into_xprv(network).unwrap();
    let fingerprint = xprv.fingerprint(&Secp256k1::new());
    return ExtendedKeyInfo {
        mnemonic: mnemonic.clone(),
        xprv: xprv.to_string(),
        fingerprint: fingerprint.to_string(),
    };
}
pub fn create_descriptor(xprv: String) -> String {
    return "wpkh([c258d2e4/84h/1h/0h]".to_owned() + &*xprv + "/84'/1'/0'/0/*)";
}

pub fn create_change_descriptor(xprv: String) -> String {
    return "wpkh([c258d2e4/84h/1h/0h]".to_owned() + &*xprv + "/84'/1'/0'/1/*)";
}
