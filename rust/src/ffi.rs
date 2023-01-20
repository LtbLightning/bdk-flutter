use bdk::bitcoin::blockdata::script::Script as BdkScript;
use bdk::bitcoin::hashes::hex::{FromHex, ToHex};
use bdk::bitcoin::psbt::serialize::Serialize;
use bdk::bitcoin::secp256k1::Secp256k1;
use bdk::bitcoin::util::bip32::{DerivationPath as BdkDerivationPath, Fingerprint};
use bdk::bitcoin::util::psbt::PartiallySignedTransaction as BdkPartiallySignedTransaction;
use bdk::bitcoin::{Address as BdkAddress, OutPoint as BdkOutPoint, Txid};

use bdk::blockchain::any::AnyBlockchain;
use bdk::blockchain::{
    rpc::RpcConfig as BdkRpcConfig, rpc::RpcSyncParams as BdkRpcSyncParams, AnyBlockchainConfig,
    Blockchain, ConfigurableBlockchain, ElectrumBlockchainConfig, GetBlockHash, GetHeight,
};
use bdk::database::{AnyDatabase, ConfigurableDatabase};
use bdk::descriptor::{DescriptorXKey, ExtendedDescriptor, IntoWalletDescriptor, KeyMap};
use bdk::keys::bip39::{Language, Mnemonic as BdkMnemonic, WordCount};
use bdk::keys::{
    DerivableKey, DescriptorPublicKey as BdkDescriptorPublicKey,
    DescriptorSecretKey as BdkDescriptorSecretKey, ExtendedKey, GeneratableKey, GeneratedKey,
};
use bdk::miniscript::BareCtx;
use bdk::psbt::PsbtUtils;
use bdk::wallet::AddressIndex as BdkAddressIndex;
use bdk::wallet::AddressInfo as BdkAddressInfo;
use std::ops::Deref;
use std::path::PathBuf;
use std::str::FromStr;
use std::sync::{Arc, Mutex, MutexGuard};

use crate::types::{
    AddressIndex, AddressInfo, Balance, BlockTime, BlockchainConfig, DatabaseConfig, LocalUtxo,
    OutPoint, RpcSyncParams, TransactionDetails, TxOut,
};
use bdk::blockchain::esplora::EsploraBlockchainConfig;
use bdk::template::{
    Bip44, Bip44Public, Bip49, Bip49Public, Bip84, Bip84Public, DescriptorTemplate,
};
use bdk::{
    Balance as BdkBalance, BlockTime as BdkBlockTime, Error as BdkError, Error, FeeRate,
    KeychainKind, SignOptions, SyncOptions, Wallet as BdkWallet,
};
use flutter_rust_bridge::RustOpaque;

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
    if let Some(time) = time {
        Some(BlockTime {
            height: time.height,
            timestamp: time.timestamp,
        })
    } else {
        None
    }
}

impl From<RpcSyncParams> for BdkRpcSyncParams {
    fn from(params: RpcSyncParams) -> Self {
        BdkRpcSyncParams {
            start_script_count: params.start_script_count as usize,
            start_time: params.start_time,
            force_start_time: params.force_start_time,
            poll_rate_sec: params.poll_rate_sec,
        }
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
impl From<BdkOutPoint> for OutPoint {
    fn from(x: BdkOutPoint) -> OutPoint {
        OutPoint {
            txid: x.txid.to_string(),
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
    fn from_utxo(x: &bdk::LocalUtxo, network: bdk::bitcoin::Network) -> LocalUtxo;
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

pub struct BlockchainInstance {
    pub blockchain_mutex: Mutex<AnyBlockchain>,
}

impl BlockchainInstance {
    pub fn new(blockchain_config: BlockchainConfig) -> Result<Self, BdkError> {
        let any_blockchain_config = match blockchain_config {
            BlockchainConfig::Electrum { config } => {
                AnyBlockchainConfig::Electrum(ElectrumBlockchainConfig {
                    retry: config.retry,
                    socks5: config.socks5,
                    timeout: config.timeout,
                    url: config.url,
                    stop_gap: usize::try_from(config.stop_gap).unwrap(),
                    validate_domain: config.validate_domain,
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
            BlockchainConfig::Rpc { config } => {
                let rpc_auth = if let Some(file) = config.auth_cookie {
                    bdk::blockchain::rpc::Auth::Cookie {
                        file: PathBuf::from(file),
                    }
                } else if let Some(user_pass) = config.auth_user_pass {
                    bdk::blockchain::rpc::Auth::UserPass {
                        username: user_pass.username,
                        password: user_pass.password,
                    }
                } else {
                    bdk::blockchain::rpc::Auth::None
                };
                AnyBlockchainConfig::Rpc(BdkRpcConfig {
                    url: config.url,
                    // auth: config.auth.into(),
                    auth: rpc_auth,
                    network: config.network.into(),
                    wallet_name: config.wallet_name,
                    sync_params: config.sync_params.map(|p| p.into()),
                })
            }
        };
        let blockchain = AnyBlockchain::from_config(&any_blockchain_config)?;
        Ok(Self {
            blockchain_mutex: Mutex::new(blockchain),
        })
    }

    pub fn get_blockchain(&self) -> MutexGuard<AnyBlockchain> {
        self.blockchain_mutex.lock().expect("blockchain")
    }

    pub(crate) fn broadcast(&self, psbt: &PartiallySignedTransaction) -> Result<String, BdkError> {
        let tx = psbt.internal.lock().unwrap().clone().extract_tx();
        self.get_blockchain()
            .broadcast(&tx.clone())
            .expect("Broadcast Error");
        return Ok(tx.txid().to_string());
    }

    pub fn get_height(&self) -> Result<u32, BdkError> {
        self.get_blockchain().get_height()
    }

    pub fn get_block_hash(&self, height: u32) -> Result<String, BdkError> {
        self.get_blockchain()
            .get_block_hash(u64::from(height))
            .map(|hash| hash.to_string())
    }
}
pub struct WalletInstance {
    pub wallet_mutex: Mutex<BdkWallet<AnyDatabase>>,
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
    pub fn sign(&self, psbt: &PartiallySignedTransaction) -> Result<bool, Error> {
        let mut psbt = psbt.internal.lock().unwrap();
        self.get_wallet().sign(&mut psbt, SignOptions::default())
    }
}

#[derive(Debug)]
pub struct PartiallySignedTransaction {
    pub internal: Mutex<BdkPartiallySignedTransaction>,
}

impl PartiallySignedTransaction {
    pub fn new(psbt_base64: String) -> Result<Self, BdkError> {
        let psbt: BdkPartiallySignedTransaction =
            BdkPartiallySignedTransaction::from_str(&psbt_base64)?;
        Ok(PartiallySignedTransaction {
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
            .extract_tx()
            .serialize()
    }

    /// Combines this BdkPartiallySignedTransaction with other PSBT as described by BIP 174.
    ///
    /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
    pub fn combine(
        &self,
        other: Arc<PartiallySignedTransaction>,
    ) -> Result<Arc<PartiallySignedTransaction>, BdkError> {
        let other_psbt = other.internal.lock().unwrap().clone();
        let mut original_psbt = self.internal.lock().unwrap().clone();

        original_psbt.combine(other_psbt)?;
        Ok(Arc::new(PartiallySignedTransaction {
            internal: Mutex::new(original_psbt),
        }))
    }
    pub(crate) fn fee_amount(&self) -> Option<u64> {
        self.internal.lock().unwrap().fee_amount()
    }
    pub(crate) fn fee_rate(&self) -> Option<FeeRate> {
        self.internal.lock().unwrap().fee_rate()
    }
}

pub fn to_script_pubkey(address: &str) -> Result<BdkScript, BdkError> {
    BdkAddress::from_str(address)
        .map(|x| x.script_pubkey())
        .map_err(|e| BdkError::Generic(e.to_string()))
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
    pub fn new(address: String) -> Result<Self, BdkError> {
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
    pub fn new(
        network: bdk::bitcoin::Network,
        mnemonic: Mnemonic,
        password: Option<String>,
    ) -> Result<Self, BdkError> {
        let mnemonic = mnemonic.internal.clone();
        let xkey: ExtendedKey = (mnemonic, password).into_extended_key().unwrap();
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
            BdkDescriptorSecretKey::Single(_) => {
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
            BdkDescriptorSecretKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn as_public(&self) -> Result<Arc<DescriptorPublicKey>, BdkError> {
        let secp = Secp256k1::new();
        let descriptor_public_key = self
            .descriptor_secret_key_mutex
            .lock()
            .unwrap()
            .to_public(&secp)
            .unwrap();
        Ok(Arc::new(DescriptorPublicKey {
            descriptor_public_key_mutex: Mutex::new(descriptor_public_key),
        }))
    }

    /// Get the private key as bytes.
    pub fn secret_bytes(&self) -> Result<Vec<u8>, BdkError> {
        let descriptor_secret_key = self.descriptor_secret_key_mutex.lock().unwrap();
        let secret_bytes: Vec<u8> = match descriptor_secret_key.deref() {
            BdkDescriptorSecretKey::XPrv(descriptor_x_key) => {
                descriptor_x_key.xkey.private_key.secret_bytes().to_vec()
            }
            BdkDescriptorSecretKey::Single(_) => {
                unreachable!()
            }
        };

        Ok(secret_bytes)
    }
    #[allow(dead_code)]
    pub fn from_string(key_str: String) -> Result<Arc<Self>, BdkError> {
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
    pub fn from_string(key: String) -> Result<Arc<Self>, BdkError> {
        let key = BdkDescriptorPublicKey::from_str(&*key).unwrap();
        Ok(Arc::new(Self {
            descriptor_public_key_mutex: Mutex::new(key),
        }))
    }
    pub fn derive(&self, path: Arc<DerivationPath>) -> Result<Arc<Self>, BdkError> {
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
            BdkDescriptorPublicKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn extend(&self, path: Arc<DerivationPath>) -> Result<Arc<Self>, BdkError> {
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
            BdkDescriptorPublicKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn as_string(&self) -> String {
        self.descriptor_public_key_mutex.lock().unwrap().to_string()
    }
}

pub struct Mnemonic {
    pub internal: BdkMnemonic,
}

impl Mnemonic {
    /// Generates Mnemonic with a random entropy
    pub fn new(word_count: WordCount) -> Self {
        let generated_key: GeneratedKey<_, BareCtx> =
            BdkMnemonic::generate((word_count, Language::English)).unwrap();
        let mnemonic = BdkMnemonic::parse_in(Language::English, generated_key.to_string()).unwrap();
        Mnemonic { internal: mnemonic }
    }

    /// Parse a Mnemonic with given string
    pub fn from_str(mnemonic: String) -> Result<Self, BdkError> {
        BdkMnemonic::from_str(&mnemonic)
            .map(|m| Mnemonic { internal: m })
            .map_err(|e| BdkError::Generic(e.to_string()))
    }

    /// Create a new Mnemonic in the specified language from the given entropy.
    /// Entropy must be a multiple of 32 bits (4 bytes) and 128-256 bits in length.
    pub fn from_entropy(entropy: Vec<u8>) -> Result<Self, BdkError> {
        BdkMnemonic::from_entropy(entropy.as_slice())
            .map(|m| Mnemonic { internal: m })
            .map_err(|e| BdkError::Generic(e.to_string()))
    }

    /// Returns Mnemonic as string
    pub fn as_string(&self) -> String {
        self.internal.to_string()
    }
}
#[derive(Debug)]
pub struct BdkDescriptor {
    pub extended_descriptor: ExtendedDescriptor,
    pub key_map: KeyMap,
}

impl BdkDescriptor {
    pub fn new(descriptor: String, network: bdk::bitcoin::Network) -> Result<Self, BdkError> {
        let secp = Secp256k1::new();
        let (extended_descriptor, key_map) = descriptor.into_wallet_descriptor(&secp, network)?;

        Ok(Self {
            extended_descriptor,
            key_map,
        })
    }

    pub fn new_bip44(
        secret_key: Arc<DescriptorSecretKey>,
        keychain_kind: KeychainKind,
        network: bdk::bitcoin::Network,
    ) -> Self {
        let derivable_key = secret_key.descriptor_secret_key_mutex.lock().unwrap();

        match derivable_key.deref() {
            BdkDescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip44(derivable_key, keychain_kind).build(network).unwrap();
                Self {
                    extended_descriptor,
                    key_map,
                }
            }
            BdkDescriptorSecretKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn new_bip44_public(
        public_key: Arc<DescriptorPublicKey>,
        fingerprint: String,
        keychain_kind: KeychainKind,
        network: bdk::bitcoin::Network,
    ) -> Self {
        let fingerprint = Fingerprint::from_str(fingerprint.as_str()).unwrap();
        let derivable_key = public_key.descriptor_public_key_mutex.lock().unwrap();

        match derivable_key.deref() {
            BdkDescriptorPublicKey::XPub(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip44Public(derivable_key, fingerprint, keychain_kind)
                        .build(network)
                        .unwrap();

                Self {
                    extended_descriptor,
                    key_map,
                }
            }
            BdkDescriptorPublicKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn new_bip49(
        secret_key: Arc<DescriptorSecretKey>,
        keychain_kind: KeychainKind,
        network: bdk::bitcoin::Network,
    ) -> Self {
        let derivable_key = secret_key.descriptor_secret_key_mutex.lock().unwrap();

        match derivable_key.deref() {
            BdkDescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip49(derivable_key, keychain_kind).build(network).unwrap();
                Self {
                    extended_descriptor,
                    key_map,
                }
            }
            BdkDescriptorSecretKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn new_bip49_public(
        public_key: Arc<DescriptorPublicKey>,
        fingerprint: String,
        keychain_kind: KeychainKind,
        network: bdk::bitcoin::Network,
    ) -> Self {
        let fingerprint = Fingerprint::from_str(fingerprint.as_str()).unwrap();
        let derivable_key = public_key.descriptor_public_key_mutex.lock().unwrap();

        match derivable_key.deref() {
            BdkDescriptorPublicKey::XPub(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip49Public(derivable_key, fingerprint, keychain_kind)
                        .build(network)
                        .unwrap();

                Self {
                    extended_descriptor,
                    key_map,
                }
            }
            BdkDescriptorPublicKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn new_bip84(
        secret_key: Arc<DescriptorSecretKey>,
        keychain_kind: KeychainKind,
        network: bdk::bitcoin::Network,
    ) -> Self {
        let derivable_key = secret_key.descriptor_secret_key_mutex.lock().unwrap();

        match derivable_key.deref() {
            BdkDescriptorSecretKey::XPrv(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip84(derivable_key, keychain_kind).build(network).unwrap();
                Self {
                    extended_descriptor,
                    key_map,
                }
            }
            BdkDescriptorSecretKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn new_bip84_public(
        public_key: Arc<DescriptorPublicKey>,
        fingerprint: String,
        keychain_kind: KeychainKind,
        network: bdk::bitcoin::Network,
    ) -> Self {
        let fingerprint = Fingerprint::from_str(fingerprint.as_str()).unwrap();
        let derivable_key = public_key.descriptor_public_key_mutex.lock().unwrap();

        match derivable_key.deref() {
            BdkDescriptorPublicKey::XPub(descriptor_x_key) => {
                let derivable_key = descriptor_x_key.xkey;
                let (extended_descriptor, key_map, _) =
                    Bip84Public(derivable_key, fingerprint, keychain_kind)
                        .build(network)
                        .unwrap();

                Self {
                    extended_descriptor,
                    key_map,
                }
            }
            BdkDescriptorPublicKey::Single(_) => {
                unreachable!()
            }
        }
    }

    pub fn as_string_private(&self) -> String {
        let descriptor = &self.extended_descriptor;
        let key_map = &self.key_map;
        descriptor.to_string_with_secret(key_map)
    }

    pub fn as_string(&self) -> String {
        self.extended_descriptor.to_string()
    }
}
/// A Bitcoin script.
#[derive(Clone)]
pub struct Script {
    pub script: BdkScript,
}

impl Script {
    pub fn from_hex(script: String) -> Result<Self, BdkError> {
        let script = BdkScript::from_hex(script.as_str()).unwrap();
        Ok(Script { script })
    }
    pub fn new(raw_output_script: Vec<u8>) -> Result<Self, BdkError> {
        let script = raw_output_script.as_slice().to_hex();
        Script::from_hex(script)
    }
}
