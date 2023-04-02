use std::borrow::Borrow;
use crate::blockchain::BlockchainInstance;
use crate::descriptor::BdkDescriptor;
use crate::psbt::PartiallySignedTransaction;
use bdk::database::{AnyDatabase, AnyDatabaseConfig, ConfigurableDatabase};
use bdk::{bitcoin, Error as BdkError, Error, KeychainKind, SyncOptions};
use bdk::{SignOptions, Wallet as BdkWallet};
use flutter_rust_bridge::RustOpaque;
use std::ops::Deref;
use std::str::FromStr;
use std::sync::{Arc, Mutex, MutexGuard};
use bdk::bitcoin::psbt::Input;
use bdk::descriptor::{ KeyMap};

use crate::types::{AddressIndex, AddressInfo, Balance, OutPoint, TransactionDetails, TxOut};

/// A Bitcoin wallet.
/// The Wallet acts as a way of coherently interfacing with output descriptors and related transactions. Its main components are:
///     1. Output descriptors from which it can derive addresses.
///     2. A Database where it tracks transactions and utxos related to the descriptors.
///     3. Signers that can contribute signatures to addresses instantiated from the descriptors.
#[derive(Debug)]
pub struct WalletInstance {
    pub wallet_mutex: Mutex<BdkWallet<AnyDatabase>>,
}
impl From<WalletInstance> for RustOpaque<WalletInstance> {
    fn from(wallet: WalletInstance) -> Self {
        RustOpaque::new(wallet)
    }
}
impl WalletInstance {
    pub fn new(
        descriptor: Arc<RustOpaque<BdkDescriptor>>,
        change_descriptor: Option<Arc<RustOpaque<BdkDescriptor>>>,
        network: bdk::bitcoin::Network,
        database_config: DatabaseConfig,
    ) -> Result<Self, BdkError> {
        let database = AnyDatabase::from_config(&database_config.into()).unwrap();
        let descriptor: String = descriptor.as_string_private();
        let change_descriptor: Option<String> = change_descriptor.map(|d| d.as_string_private());

        let wallet_mutex = Mutex::new(
            BdkWallet::new(&descriptor, change_descriptor.as_ref(), network, database).unwrap(),
        );
        Ok(WalletInstance { wallet_mutex })
    }
    pub fn get_wallet(&self) -> MutexGuard<BdkWallet<AnyDatabase>> {
        self.wallet_mutex.lock().expect("wallet")
    }

    pub fn sync(&self, blockchain: &BlockchainInstance) {
        let blockchain = blockchain.get_blockchain();
        self.get_wallet()
            .sync(blockchain.deref(), SyncOptions::default())
            .unwrap()
    }
    /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
    /// on the internal database, which first needs to be Wallet.sync manually.
    pub fn get_balance(&self) -> Result<Balance, BdkError> {
        self.get_wallet().get_balance().map(|b| b.into())
    }

    // Return a derived address using the internal (change) descriptor.
    ///
    /// If the wallet doesn't have an internal descriptor it will use the external descriptor.
    ///
    /// see [`AddressIndex`] for available address index selection strategies. If none of the keys
    /// in the descriptor are derivable (i.e. does not end with /*) then the same address will always
    /// be returned for any [`AddressIndex`].
    pub(crate) fn get_internal_address(
        &self,
        address_index: AddressIndex,
    ) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_internal_address(address_index.into())
            .map(AddressInfo::from)
    }
    pub fn get_address(&self, address_index: AddressIndex) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_address(address_index.into())
            .map(AddressInfo::from)
    }

    /// Return the list of transactions made and received by the wallet. Note that this method only operate on the internal database, which first needs to be [Wallet.sync] manually.
    pub fn list_transactions(&self) -> Result<Vec<TransactionDetails>, BdkError> {
        let transaction_details = self.get_wallet().list_transactions(true).unwrap();
        Ok(transaction_details
            .iter()
            .map(TransactionDetails::from)
            .collect())
    }
    // Return the list of unspent outputs of this wallet. Note that this method only operates on the internal database,
    // which first needs to be Wallet.sync manually.
    pub fn list_unspent(&self) -> Result<Vec<LocalUtxo>, BdkError> {
        let unspents = self.get_wallet().list_unspent()?;
        Ok(unspents
            .iter()
            .map(|u| LocalUtxo::from_utxo(u, self.get_wallet().network()))
            .collect())
    }
    pub fn sign(&self, psbt: &PartiallySignedTransaction, trust_witness_utxo:bool) -> Result<bool, BdkError> {
        let mut psbt = psbt.internal.lock().unwrap();
        self.get_wallet().sign(&mut psbt, SignOptions {
             trust_witness_utxo,
            ..Default::default()
        })
    }
    /// Returns the descriptor used to create addresses for a particular `keychain`.
    pub fn get_descriptor_for_keychain(&self, keychain: KeychainKind) ->  Result<BdkDescriptor , BdkError>{
        let wallet = self.get_wallet();
        Ok(BdkDescriptor{ extended_descriptor: wallet.get_descriptor_for_keychain(keychain).to_owned(), key_map: KeyMap::new() })
    }
    pub fn  get_psbt_input(&self, utxo: LocalUtxo, only_witness_utxo: bool) -> Result<Input, Error> {
        let wallet = self.get_wallet();
        wallet.get_psbt_input(LocalUtxo::to_utxo(utxo), None, only_witness_utxo)
    }
}
/// Unspent outputs of this wallet
pub struct LocalUtxo {
    /// Reference to a transaction output
    pub outpoint: OutPoint,
    ///Transaction output
    pub txout: TxOut,
    ///Whether this UTXO is spent or not
    pub is_spent: bool,

     pub keychain: crate::types::KeychainKind,
}

// This trait is used to convert the bdk TxOut type with field `script_pubkey: Script`
// into the bdk-ffi TxOut type which has a field `address: String` instead
trait NetworkLocalUtxo {
    fn from_utxo(x: &bdk::LocalUtxo, network: bdk::bitcoin::Network) -> LocalUtxo;
    fn to_utxo(x: LocalUtxo ) -> bdk::LocalUtxo;
}
impl NetworkLocalUtxo for LocalUtxo {
    fn from_utxo(x: &bdk::LocalUtxo, network: bdk::bitcoin::Network) -> LocalUtxo {
        LocalUtxo {
            outpoint: OutPoint {
                txid: x.clone().outpoint.txid.to_string(),
                vout: x.clone().outpoint.vout,
            },
            txout: TxOut {
                value: x.clone().txout.value,
                address: bitcoin::util::address::Address::from_script(
                    &x.txout.script_pubkey,
                    network,
                )
                .unwrap()
                .to_string(),
            },
            is_spent: x.clone().is_spent,
            keychain: x.keychain.into()
        }
    }

    fn to_utxo(x: LocalUtxo) -> bdk::LocalUtxo {
        bdk::LocalUtxo{
            outpoint: x.outpoint.borrow().into(),
            txout: bitcoin::blockdata::transaction::TxOut{ value: x.txout.value,
                script_pubkey: bitcoin::util::address::Address::from_str(&*x.txout.address).unwrap().script_pubkey()},
            keychain: x.keychain.into(),
            is_spent: x.is_spent
        }
    }
}
///Configuration type for a SqliteDatabase database
pub struct SqliteDbConfiguration {
    ///Main directory of the db
    pub path: String,
}
///Configuration type for a sled Tree database
pub struct SledDbConfiguration {
    ///Main directory of the db
    pub path: String,
    ///Name of the database tree, a separated namespace for the data
    pub tree_name: String,
}
/// Type that can contain any of the database configurations defined by the library
/// This allows storing a single configuration that can be loaded into an DatabaseConfig
/// instance. Wallets that plan to offer users the ability to switch blockchain backend at runtime
/// will find this particularly useful.
pub enum DatabaseConfig {
    Memory,
    ///Simple key-value embedded database based on sled
    Sqlite {
        config: SqliteDbConfiguration,
    },
    ///Sqlite embedded database using rusqlite
    Sled {
        config: SledDbConfiguration,
    },
}
impl From<DatabaseConfig> for AnyDatabaseConfig {
    fn from(config: DatabaseConfig) -> Self {
        match config {
            DatabaseConfig::Memory => AnyDatabaseConfig::Memory(()),
            DatabaseConfig::Sqlite { config } => {
                AnyDatabaseConfig::Sqlite(bdk::database::any::SqliteDbConfiguration {
                    path: config.path,
                })
            }
            DatabaseConfig::Sled { config } => {
                AnyDatabaseConfig::Sled(bdk::database::any::SledDbConfiguration {
                    path: config.path,
                    tree_name: config.tree_name,
                })
            }
        }
    }
}

#[cfg(test)]
mod test {

    use crate::wallet::{AddressIndex, DatabaseConfig, WalletInstance};
    use bdk::bitcoin::{Network};
    use std::sync::{Arc};
    use flutter_rust_bridge::RustOpaque;
    use crate::descriptor::BdkDescriptor;

    #[test]
    fn test_peek_reset_address() {
        let test_wpkh = "wpkh(tprv8hwWMmPE4BVNxGdVt3HhEERZhondQvodUY7Ajyseyhudr4WabJqWKWLr4Wi2r26CDaNCQhhxEftEaNzz7dPGhWuKFU4VULesmhEfZYyBXdE/0/*)";
        let descriptor = RustOpaque::new(BdkDescriptor::new(test_wpkh.to_string(), Network::Regtest).unwrap());
        let change_descriptor =   RustOpaque::new(BdkDescriptor::new(
            test_wpkh.to_string().replace("/0/*", "/1/*"),
            Network::Regtest,
        )
            .unwrap());

        let wallet = WalletInstance::new(
            Arc::new(descriptor),
            Some(Arc::new(change_descriptor)),
            Network::Regtest,
            DatabaseConfig::Memory,
        )
            .unwrap();

        assert_eq!(
            wallet
                .get_address(AddressIndex::Peek { index: 2 })
                .unwrap()
                .address,
            "bcrt1q5g0mq6dkmwzvxscqwgc932jhgcxuqqkjv09tkj"
        );

        assert_eq!(
            wallet
                .get_address(AddressIndex::Peek { index: 1 })
                .unwrap()
                .address,
            "bcrt1q0xs7dau8af22rspp4klya4f7lhggcnqfun2y3a"
        );

        // new index still 0
        assert_eq!(
            wallet
                .get_address(AddressIndex::New)
                .unwrap()
                .address,
            "bcrt1qqjn9gky9mkrm3c28e5e87t5akd3twg6xezp0tv"
        );

        // new index now 1
        assert_eq!(
            wallet
                .get_address(AddressIndex::New)
                .unwrap()
                .address,
            "bcrt1q0xs7dau8af22rspp4klya4f7lhggcnqfun2y3a"
        );

        // new index now 2
        assert_eq!(
            wallet
                .get_address(AddressIndex::New)
                .unwrap()
                .address,
            "bcrt1q5g0mq6dkmwzvxscqwgc932jhgcxuqqkjv09tkj"
        );

        // peek index 1
        assert_eq!(
            wallet
                .get_address(AddressIndex::Peek { index: 1 })
                .unwrap()
                .address,
            "bcrt1q0xs7dau8af22rspp4klya4f7lhggcnqfun2y3a"
        );

        // reset to index 0
        assert_eq!(
            wallet
                .get_address(AddressIndex::Reset { index: 0 })
                .unwrap()
                .address,
            "bcrt1qqjn9gky9mkrm3c28e5e87t5akd3twg6xezp0tv"
        );

        // new index 1 again
        assert_eq!(
            wallet.get_address(AddressIndex::New).unwrap().address,
            "bcrt1q0xs7dau8af22rspp4klya4f7lhggcnqfun2y3a"
        );
    }
    #[test]
    fn test_get_address() {
        let test_wpkh = "wpkh(tprv8hwWMmPE4BVNxGdVt3HhEERZhondQvodUY7Ajyseyhudr4WabJqWKWLr4Wi2r26CDaNCQhhxEftEaNzz7dPGhWuKFU4VULesmhEfZYyBXdE/0/*)";
        let descriptor = RustOpaque::new(BdkDescriptor::new(test_wpkh.to_string(), Network::Regtest).unwrap());
        let change_descriptor =   RustOpaque::new(BdkDescriptor::new(
            test_wpkh.to_string().replace("/0/*", "/1/*"),
            Network::Regtest,
        )
            .unwrap());

        let wallet = WalletInstance::new(
            Arc::new(descriptor),
            Some(Arc::new(change_descriptor)),
            Network::Regtest,
            DatabaseConfig::Memory,
        )
            .unwrap();

        assert_eq!(
            wallet
                .get_address(AddressIndex::New)
                .unwrap()
                .address,
            "bcrt1qqjn9gky9mkrm3c28e5e87t5akd3twg6xezp0tv"
        );

        assert_eq!(
            wallet
                .get_address(AddressIndex::New)
                .unwrap()
                .address,
            "bcrt1q0xs7dau8af22rspp4klya4f7lhggcnqfun2y3a"
        );

        assert_eq!(
            wallet
                .get_address(AddressIndex::LastUnused)
                .unwrap()
                .address,
            "bcrt1q0xs7dau8af22rspp4klya4f7lhggcnqfun2y3a"
        );

        assert_eq!(
            wallet
                .get_internal_address(AddressIndex::New)
                .unwrap()
                .address,
            "bcrt1qpmz73cyx00r4a5dea469j40ax6d6kqyd67nnpj"
        );

        assert_eq!(
            wallet
                .get_internal_address(AddressIndex::New)
                .unwrap()
                .address,
            "bcrt1qaux734vuhykww9632v8cmdnk7z2mw5lsf74v6k"
        );

        assert_eq!(
            wallet
                .get_internal_address(AddressIndex::LastUnused)
                .unwrap()
                .address,
            "bcrt1qaux734vuhykww9632v8cmdnk7z2mw5lsf74v6k"
        );
    }
}