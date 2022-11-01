use bdk::bitcoin::secp256k1::Secp256k1;
use crate::types::{DatabaseConfig, BlockTime, TransactionDetails, AddressIndex, AddressInfo, OutPoint, TxOut, LocalUtxo, Balance};
use crate::utils::config_database;
use bdk::bitcoin::hashes::hex::{FromHex, ToHex};
use bdk::bitcoin::util::bip32::DerivationPath as BdkDerivationPath;
use bdk::bitcoin::util::psbt::PartiallySignedTransaction;
use bdk::bitcoin::{Address as BdkAddress,Script as BdkScript, Network, OutPoint as BdkOutPoint, Txid};

use bdk::blockchain::any::AnyBlockchain;
use bdk::database::{AnyDatabase, AnyDatabaseConfig, ConfigurableDatabase};
use bdk::descriptor::{DescriptorXKey, ExtendedDescriptor};
use bdk::keys::bip39::{Language, Mnemonic, WordCount};
use bdk::keys::{DerivableKey, DescriptorPublicKey as BdkDescriptorPublicKey, DescriptorSecretKey as BdkDescriptorSecretKey, ExtendedKey, GeneratableKey, GeneratedKey};
use bdk::miniscript::BareCtx;
use bdk::wallet::AddressIndex as BdkAddressIndex;
use bdk::wallet::AddressInfo as BdkAddressInfo;
use bdk::{Balance as BdkBalance,  BlockTime as BdkBlockTime, Error, KeychainKind, SignOptions, SyncOptions, Wallet as BdkWallet};
use std::ops::Deref;
use std::str::FromStr;
use std::sync::{Arc, Mutex, MutexGuard};
use bdk::bitcoin::psbt::serialize::Serialize;
use bdk::Error as BdkError;

impl From<AddressIndex> for BdkAddressIndex {
    fn from(x: AddressIndex) -> BdkAddressIndex {
        match x {
            AddressIndex::New => BdkAddressIndex::New,
            AddressIndex::LastUnused => BdkAddressIndex::LastUnused,
        }
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
/// A wallet transaction
impl From<&bdk::TransactionDetails> for TransactionDetails {
    fn from(x: &bdk::TransactionDetails) -> TransactionDetails {
        TransactionDetails {
            fee: x.clone().fee,
            txid: x.clone().txid.to_string(),
            received: x.clone().received,
            sent: x.clone().sent,
            confirmation_time: set_block_time(x.confirmation_time.clone()),
        }
    }
}
fn set_block_time(time: Option<BdkBlockTime>) -> Option<BlockTime> {
     if let Some(time) = time{
        Some( BlockTime {
            height: time.height,
            timestamp: time.timestamp,
        })
     } else{
         None
     }
}
/// A transaction output, which defines new coins to be created from old ones.
impl From<&OutPoint> for BdkOutPoint {
    fn from(x: &OutPoint) -> BdkOutPoint {
        BdkOutPoint {
            txid: Txid::from_str(&x.clone().txid).unwrap(),
            vout: x.clone().vout,
        }
    }
}
impl From<BdkBalance> for Balance {
    fn from(bdk_balance: BdkBalance) -> Self {
        Balance {
            immature: bdk_balance.immature,
            trusted_pending: bdk_balance.trusted_pending,
            untrusted_pending: bdk_balance.untrusted_pending,
            confirmed: bdk_balance.confirmed,
            spendable: bdk_balance.get_spendable(),
            total: bdk_balance.get_total(),
        }
    }
}
// This trait is used to convert the bdk TxOut type with field `script_pubkey: Script`
// into the bdk-ffi TxOut type which has a field `address: String` instead
trait NetworkLocalUtxo {
    fn from_utxo(x: &bdk::LocalUtxo, network: Network) -> LocalUtxo;
}
impl NetworkLocalUtxo for LocalUtxo {
    fn from_utxo(x: &bdk::LocalUtxo, network: Network) -> LocalUtxo {
        LocalUtxo {
            outpoint: OutPoint {
                txid: x.clone().outpoint.txid.to_string(),
                vout: x.clone().outpoint.vout,
            },
            txout: TxOut {
                value: x.clone().txout.value,
                address: bdk::bitcoin::util::address::Address::from_script(
                    &x.txout.script_pubkey,
                    network,
                )
                    .unwrap()
                    .to_string(),
            },
            is_spent: x.clone().is_spent,
        }
    }
}
pub struct Wallet {
    pub  wallet_mutex: Mutex<BdkWallet<AnyDatabase>>,
}
impl Wallet {
    pub fn new(
        descriptor: String,
        change_descriptor: Option<String>,
        network: Network,
        database_config: DatabaseConfig,
    ) -> Result<Self, BdkError> {
        let any_database_config: AnyDatabaseConfig = config_database(database_config);
        let database: AnyDatabase = AnyDatabase::from_config(&any_database_config)?;
        let res = Mutex::new(
            BdkWallet::new(&descriptor, change_descriptor.as_ref(), network, database).unwrap(),
        );
        Ok(Wallet { wallet_mutex: res })
    }
    pub fn get_wallet(&self) -> MutexGuard<BdkWallet<AnyDatabase>> {
        self.wallet_mutex.lock().expect("wallet")
    }

    pub fn get_public_descriptor(&self) -> Result<Option<ExtendedDescriptor> ,Error> {
        self.get_wallet().public_descriptor(KeychainKind::External)
    }

    pub fn sync(&self, blockchain: &AnyBlockchain) {
        self.get_wallet()
            .sync(blockchain, SyncOptions::default())
            .unwrap();
    }
    /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
    /// on the internal database, which first needs to be Wallet.sync manually.
    pub fn get_balance(&self) -> Result<Balance, Error> {
        self.get_wallet().get_balance().map(|b| b.into())
    }
    pub fn get_address(&self, address_index: AddressIndex) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_address(address_index.into())
            .map(AddressInfo::from)
    }


    /// Return the list of transactions made and received by the wallet. Note that this method only operate on the internal database, which first needs to be [Wallet.sync] manually.
    pub fn list_transactions(&self) -> Result<Vec<TransactionDetails>, Error> {
        let transaction_details = self.get_wallet().list_transactions(true).unwrap();
        Ok(transaction_details
            .iter()
            .map(TransactionDetails::from)
            .collect())

    }
    // Return the list of unspent outputs of this wallet. Note that this method only operates on the internal database,
    // which first needs to be Wallet.sync manually.
    pub fn list_unspent(&self) -> Result<Vec<LocalUtxo>, Error> {
        let unspents = self.get_wallet().list_unspent()?;
        Ok(unspents
            .iter()
            .map(|u| LocalUtxo::from_utxo(u, self.get_wallet().network()))
            .collect())
    }
    pub fn sign(&self, psbt: &PartiallySignedBitcoinTransaction) -> Result<bool, Error> {
        let mut psbt = psbt.internal.lock().unwrap();
        self.get_wallet().sign(&mut psbt, SignOptions::default())
    }
}
#[derive(Debug)]
pub struct PartiallySignedBitcoinTransaction {
   pub internal: Mutex<PartiallySignedTransaction>,
}
impl PartiallySignedBitcoinTransaction {
   pub fn new(psbt_base64: String) -> Result<Self, BdkError> {
        let psbt: PartiallySignedTransaction = PartiallySignedTransaction::from_str(&psbt_base64)?;
        Ok(PartiallySignedBitcoinTransaction {
            internal: Mutex::new(psbt),
        })
    }

   pub fn serialize(&self) -> String {
        let psbt = self.internal.lock().unwrap().clone();
        psbt.to_string()
    }

   pub fn txid(&self) -> String {
        let tx = self.internal.lock().unwrap().clone().extract_tx();
        let txid = tx.txid();
        txid.to_hex()
    }

    /// Return the transaction as bytes.
   pub fn extract_tx(&self) -> Vec<u8> {
        self.internal
            .lock()
            .unwrap()
            .clone()
            .extract_tx().serialize()
    }

    /// Combines this PartiallySignedTransaction with other PSBT as described by BIP 174.
    ///
    /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
   pub fn combine(
        &self,
        other: Arc<PartiallySignedBitcoinTransaction>,
    ) -> Result<Arc<PartiallySignedBitcoinTransaction>, BdkError> {
        let other_psbt = other.internal.lock().unwrap().clone();
        let mut original_psbt = self.internal.lock().unwrap().clone();

        original_psbt.combine(other_psbt)?;
        Ok(Arc::new(PartiallySignedBitcoinTransaction {
            internal: Mutex::new(original_psbt),
        }))
    }
}
pub fn to_script_pubkey(address: &str) -> Result<BdkScript, BdkError> {
    BdkAddress::from_str(address)
        .map(|x| x.script_pubkey())
        .map_err(|e| BdkError::Generic(e.to_string()))
}
pub fn generate_mnemonic_from_word_count(word_count: WordCount) -> Mnemonic {
    let mnemonic_gen: GeneratedKey<_, BareCtx> =
        Mnemonic::generate((word_count, Language::English)).unwrap();
    let mnemonic = mnemonic_gen.clone().into_key();
    mnemonic
}
pub struct DerivationPath {
    pub derivation_path_mutex: Mutex<BdkDerivationPath>,
}
impl DerivationPath {
    pub fn new(path: String) -> Result<Self, BdkError> {
        BdkDerivationPath::from_str(&path)
            .map(|x| DerivationPath {
                derivation_path_mutex: Mutex::new(x),
            })
            .map_err(|e| BdkError::Generic(e.to_string()))
    }
    pub fn as_string(&self) -> String {
        self.derivation_path_mutex.lock().unwrap().to_string()
    }
}
pub struct DescriptorSecretKey {
    pub descriptor_secret_key_mutex: Mutex<BdkDescriptorSecretKey>,
}
/// A Bitcoin address.
pub struct Address {
   pub address: BdkAddress,
}

impl Address {
  pub  fn new(address: String) -> Result<Self, BdkError> {
        BdkAddress::from_str(address.as_str())
            .map(|a| Address { address: a })
            .map_err(|e| BdkError::Generic(e.to_string()))
    }

   pub fn script_pubkey(&self) -> Arc<Script> {
        Arc::new(Script {
            script: self.address.script_pubkey(),
        })
    }
}
impl DescriptorSecretKey {
    pub fn new(network: Network, mnemonic: String, password: Option<String>) -> Result<Self, BdkError> {
        let mnemonic = Mnemonic::parse_in(Language::English, mnemonic)
            .map_err(|e| BdkError::Generic(e.to_string()))?;
        let xkey: ExtendedKey = (mnemonic, password).into_extended_key()?;
        let descriptor_secret_key = BdkDescriptorSecretKey::XPrv(DescriptorXKey {
            origin: None,
            xkey: xkey.into_xprv(network).unwrap(),
            derivation_path: BdkDerivationPath::master(),
            wildcard: bdk::descriptor::Wildcard::Unhardened,
        });
        Ok(Self {
            descriptor_secret_key_mutex: Mutex::new(descriptor_secret_key),
        })
    }

    pub fn derive(&self, path: Arc<DerivationPath>) -> Result<Arc<Self>, BdkError> {
        let secp = Secp256k1::new();
        let descriptor_secret_key = self.descriptor_secret_key_mutex.lock().unwrap();
        let path = path.derivation_path_mutex.lock().unwrap().deref().clone();
        match descriptor_secret_key.deref() {
            BdkDescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derived_xprv = descriptor_x_key.xkey.derive_priv(&secp, &path)?;
                let key_source = match descriptor_x_key.origin.clone() {
                    Some((fingerprint, origin_path)) => (fingerprint, origin_path.extend(path)),
                    None => (descriptor_x_key.xkey.fingerprint(&secp), path),
                };
                let derived_descriptor_secret_key = BdkDescriptorSecretKey::XPrv(DescriptorXKey {
                    origin: Some(key_source),
                    xkey: derived_xprv,
                    derivation_path: BdkDerivationPath::default(),
                    wildcard: descriptor_x_key.wildcard,
                });
                Ok(Arc::new(Self {
                    descriptor_secret_key_mutex: Mutex::new(derived_descriptor_secret_key),
                }))
            }
            BdkDescriptorSecretKey::SinglePriv(_) => {
                unreachable!()
            }
        }
    }

    pub fn extend(&self, path: Arc<DerivationPath>) -> Result<Arc<Self>, BdkError> {
        let descriptor_secret_key = self.descriptor_secret_key_mutex.lock().unwrap();
        let path = path.derivation_path_mutex.lock().unwrap().deref().clone();
        match descriptor_secret_key.deref() {
            BdkDescriptorSecretKey::XPrv(descriptor_x_key) => {
                let extended_path = descriptor_x_key.derivation_path.extend(path);
                let extended_descriptor_secret_key = BdkDescriptorSecretKey::XPrv(DescriptorXKey {
                    origin: descriptor_x_key.origin.clone(),
                    xkey: descriptor_x_key.xkey,
                    derivation_path: extended_path,
                    wildcard: descriptor_x_key.wildcard,
                });
                Ok(Arc::new(Self {
                    descriptor_secret_key_mutex: Mutex::new(extended_descriptor_secret_key),
                }))
            }
            BdkDescriptorSecretKey::SinglePriv(_) => {
                unreachable!()
            }
        }
    }

    pub fn as_public(&self) -> Result<bdk::descriptor::DescriptorPublicKey, Error> {
        let secp = Secp256k1::new();
        let descriptor_public_key = self
            .descriptor_secret_key_mutex
            .lock()
            .unwrap()
            .as_public(&secp)
            .unwrap();
        Ok(descriptor_public_key)
    }

    /// Get the private key as bytes.
    pub fn secret_bytes(&self) -> Result<Vec<u8>, BdkError> {
        let descriptor_secret_key = self.descriptor_secret_key_mutex.lock().unwrap();
        let secret_bytes: Vec<u8> = match descriptor_secret_key.deref() {
            BdkDescriptorSecretKey::XPrv(descriptor_x_key) => {
                descriptor_x_key.xkey.private_key.secret_bytes().to_vec()
            }
            BdkDescriptorSecretKey::SinglePriv(_) => {
                unreachable!()
            }
        };

        Ok(secret_bytes)
    }
    #[allow(dead_code)]
    pub fn from_string( key_str:String) -> Result<Arc<Self>, BdkError> {
        let key = BdkDescriptorSecretKey::from_str(&*key_str).unwrap();
        Ok(Arc::new(Self {
            descriptor_secret_key_mutex: Mutex::new(key),
        }))
    }
    pub fn as_string(&self) -> String {
        self.descriptor_secret_key_mutex.lock().unwrap().to_string()
    }
}
pub struct DescriptorPublicKey {
    pub descriptor_public_key_mutex: Mutex<BdkDescriptorPublicKey>,
}
impl DescriptorPublicKey {
    pub fn from_string( key:String) -> Result<Arc<Self>, BdkError> {
        let key = BdkDescriptorPublicKey::from_str(&*key).unwrap();
        Ok(Arc::new(Self {
            descriptor_public_key_mutex: Mutex::new(key),
        }))
    }
    pub  fn derive(&self, path: Arc<DerivationPath>) -> Result<Arc<Self>, BdkError> {
        let secp = Secp256k1::new();
        let descriptor_public_key = self.descriptor_public_key_mutex.lock().unwrap();
        let path = path.derivation_path_mutex.lock().unwrap().deref().clone();

        match descriptor_public_key.deref() {
            BdkDescriptorPublicKey::XPub(descriptor_x_key) => {
                let derived_xpub = descriptor_x_key.xkey.derive_pub(&secp, &path)?;
                let key_source = match descriptor_x_key.origin.clone() {
                    Some((fingerprint, origin_path)) => (fingerprint, origin_path.extend(path)),
                    None => (descriptor_x_key.xkey.fingerprint(), path),
                };
                let derived_descriptor_public_key = BdkDescriptorPublicKey::XPub(DescriptorXKey {
                    origin: Some(key_source),
                    xkey: derived_xpub,
                    derivation_path: BdkDerivationPath::default(),
                    wildcard: descriptor_x_key.wildcard,
                });
                Ok(Arc::new(Self {
                    descriptor_public_key_mutex: Mutex::new(derived_descriptor_public_key),
                }))
            }
            BdkDescriptorPublicKey::SinglePub(_) => {
                unreachable!()
            }
        }
    }

    pub  fn extend(&self, path: Arc<DerivationPath>) -> Result<Arc<Self>, BdkError> {
        let descriptor_public_key = self.descriptor_public_key_mutex.lock().unwrap();
        let path = path.derivation_path_mutex.lock().unwrap().deref().clone();
        match descriptor_public_key.deref() {
            BdkDescriptorPublicKey::XPub(descriptor_x_key) => {
                let extended_path = descriptor_x_key.derivation_path.extend(path);
                let extended_descriptor_public_key = BdkDescriptorPublicKey::XPub(DescriptorXKey {
                    origin: descriptor_x_key.origin.clone(),
                    xkey: descriptor_x_key.xkey,
                    derivation_path: extended_path,
                    wildcard: descriptor_x_key.wildcard,
                });
                Ok(Arc::new(Self {
                    descriptor_public_key_mutex: Mutex::new(extended_descriptor_public_key),
                }))
            }
            BdkDescriptorPublicKey::SinglePub(_) => {
                unreachable!()
            }
        }
    }

    pub  fn as_string(&self) -> String {
        self.descriptor_public_key_mutex.lock().unwrap().to_string()
    }
}
/// A Bitcoin script.
#[derive(Clone)]
pub struct Script {
   pub script: BdkScript,
}
impl Script {
    pub fn from_hex (script:String) -> Result<Self, BdkError>{
        let script=  BdkScript::from_hex(script.as_str()).unwrap();
        Ok(Script { script })
    }
  pub fn new(raw_output_script: Vec<u8>)->Result<Self, BdkError>{
      let script = raw_output_script.as_slice().to_hex();
      Script::from_hex(script)
  }
}



