use bdk::bitcoin::secp256k1::Secp256k1;
use std::collections::HashSet;
//use bdk::bitcoin::secp256k1::rand as bdk_rand;
use crate::types::{DatabaseConfig, ExtendedKeyInfo};
use crate::utils::config_database;
use bdk::bitcoin::hashes::hex::ToHex;
use bdk::bitcoin::util::bip32::DerivationPath as BdkDerivationPath;
use bdk::bitcoin::util::psbt::PartiallySignedTransaction;
use bdk::bitcoin::{Address, Network, OutPoint as BdkOutPoint, Script, Txid};
use bdk::blockchain::any::AnyBlockchain;
use bdk::database::{AnyDatabase, AnyDatabaseConfig, ConfigurableDatabase};
use bdk::descriptor::DescriptorXKey;
use bdk::keys::bip39::{Language, Mnemonic, WordCount};
use bdk::keys::{
    DerivableKey, DescriptorPublicKey as BdkDescriptorPublicKey,
    DescriptorSecretKey as BdkDescriptorSecretKey, ExtendedKey, GeneratableKey, GeneratedKey,
};
use bdk::miniscript::BareCtx;
use bdk::wallet::tx_builder::ChangeSpendPolicy;
use bdk::wallet::AddressIndex as BdkAddressIndex;
use bdk::wallet::AddressInfo as BdkAddressInfo;
use bdk::{
    Balance as BdkBalance, BlockTime, Error, FeeRate, KeychainKind, SignOptions, SyncOptions,
    Wallet as BdkWallet,
};
use serde::{Deserialize, Serialize};
use std::convert::From;
use std::ops::Deref;
use std::str::FromStr;
use std::sync::{Arc, Mutex, MutexGuard};

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

impl From<&bdk::TransactionDetails> for TransactionDetails {
    fn from(x: &bdk::TransactionDetails) -> TransactionDetails {
        TransactionDetails {
            fee: x.clone().fee,
            txid: x.txid.to_string(),
            received: x.clone().received,
            sent: x.clone().sent,
            confirmation_time: Some(set_block_time(x.clone().confirmation_time.unwrap())),
        }
    }
}

fn set_block_time(time: BlockTime) -> BlockConfirmationTime {
    BlockConfirmationTime {
        height: time.height,
        timestamp: time.timestamp,
    }
}
impl From<&bdk::TransactionDetails> for Transaction {
    fn from(x: &bdk::TransactionDetails) -> Transaction {
        match x.confirmation_time.clone() {
            Some(block_time) => Transaction::Confirmed {
                details: TransactionDetails::from(x),
                confirmation: set_block_time(block_time),
            },
            None => Transaction::Unconfirmed {
                details: TransactionDetails::from(x),
            },
        }
    }
}

impl From<&OutPoint> for BdkOutPoint {
    fn from(x: &OutPoint) -> BdkOutPoint {
        BdkOutPoint {
            txid: Txid::from_str(&x.txid).unwrap(),
            vout: x.vout,
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
                txid: x.outpoint.txid.to_string(),
                vout: x.outpoint.vout,
            },
            txout: TxOut {
                value: x.txout.value,
                address: bdk::bitcoin::util::address::Address::from_script(
                    &x.txout.script_pubkey,
                    network,
                )
                .unwrap()
                .to_string(),
            },
            is_spent: x.is_spent,
        }
    }
}

pub struct Wallet {
    pub(crate) wallet_mutex: Mutex<BdkWallet<AnyDatabase>>,
}
impl Wallet {
    pub(crate) fn new(
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
    pub(crate) fn get_wallet(&self) -> MutexGuard<BdkWallet<AnyDatabase>> {
        self.wallet_mutex.lock().expect("wallet")
    }
    pub fn sync(&self, blockchain: &AnyBlockchain) {
        // let bl =   Blockchain{ blockchain_mutex: blockchain.blockchain_mutex };
        self.get_wallet()
            .sync(blockchain, SyncOptions::default())
            .unwrap();
    }
    pub fn get_network(&self) -> Network {
        self.get_wallet().network()
    }

    /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
    /// on the internal database, which first needs to be Wallet.sync manually.
    pub fn get_balance(&self) -> Result<Balance, Error> {
        self.get_wallet().get_balance().map(|b| b.into())
    }
    pub fn get_descriptor_for_keychain(
        &self,
        keychain_kind: KeychainKind,
    ) -> Result<String, Error> {
        Ok(self
            .get_wallet()
            .get_descriptor_for_keychain(keychain_kind)
            .to_string())
    }
    pub fn get_descriptor_checksum(&self, keychain_kind: KeychainKind) -> Result<String, Error> {
        Ok(self.get_wallet().descriptor_checksum(keychain_kind))
    }
    pub fn get_address(&self, address_index: AddressIndex) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_address(address_index.into())
            .map(AddressInfo::from)
    }
    //Return a derived address using the internal (change) descriptor.
    // If the wallet doesn't have an internal descriptor it will use the external descriptor.
    pub fn get_internal_address(
        &self,
        address_index: AddressIndex,
    ) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_internal_address(address_index.into())
            .map(AddressInfo::from)
    }
    pub(crate) fn get_transactions(&self) -> Result<Vec<Transaction>, Error> {
        let transactions = self.get_wallet().list_transactions(true).unwrap();
        Ok(transactions.iter().map(Transaction::from).collect())
    }
    pub(crate) fn get_transaction(
        &self,
        txid_str: String,
    ) -> Result<Option<TransactionDetails>, Error> {
        let txid = Txid::from_str(&*txid_str).unwrap();
        let transaction = self.get_wallet().get_tx(&txid, true);
        Ok(Some(TransactionDetails::from(
            &transaction.unwrap().unwrap(),
        )))
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

impl PartiallySignedBitcoinTransaction {
    pub(crate) fn new(psbt_base64: String) -> Result<Self, Error> {
        let psbt: PartiallySignedTransaction = PartiallySignedTransaction::from_str(&psbt_base64)?;
        Ok(PartiallySignedBitcoinTransaction {
            internal: Mutex::new(psbt),
        })
    }

    pub(crate) fn serialize(&self) -> String {
        let psbt = self.internal.lock().unwrap().clone();
        psbt.to_string()
    }
    pub(crate) fn txid(&self) -> String {
        let tx = self.internal.lock().unwrap().clone().extract_tx();
        let txid = tx.txid();
        txid.to_hex()
    }
}
pub(crate) fn to_script_pubkey(address: &str) -> Result<Script, BdkError> {
    Address::from_str(address)
        .map(|x| x.script_pubkey())
        .map_err(|e| BdkError::Generic(e.to_string()))
}

impl TxBuilder {
    pub(crate) fn new() -> Self {
        TxBuilder {
            recipients: Vec::new(),
            utxos: Vec::new(),
            unspendable: HashSet::new(),
            change_policy: ChangeSpendPolicy::ChangeAllowed,
            manually_selected_only: false,
            fee_rate: None,
            fee_absolute: None,
            drain_wallet: false,
            drain_to: None,
            data: Vec::new(),
        }
    }

    pub(crate) fn add_recipient(&self, recipient: String, amount: u64) -> Arc<Self> {
        let mut recipients = self.recipients.to_vec();
        recipients.append(&mut vec![(recipient, amount)]);
        Arc::new(TxBuilder {
            recipients,
            ..self.clone()
        })
    }
    pub fn set_recipients(&self, recipients: Vec<AddressAmount>) -> Arc<Self> {
        let recipients = recipients
            .iter()
            .map(|address_amount| (address_amount.address.clone(), address_amount.amount))
            .collect();
        Arc::new(TxBuilder {
            recipients,
            ..self.clone()
        })
    }
    /// Add a utxo to the internal list of unspendable utxos. It’s important to note that the "must-be-spent"
    /// utxos added with [TxBuilder.addUtxo] have priority over this. See the Rust docs of the two linked methods for more details.
    // fn add_unspendable(&self, unspendable: OutPoint) -> Arc<Self> {
    //     let mut unspendable_hash_set = self.unspendable.clone();
    //     unspendable_hash_set.insert(unspendable);
    //     Arc::new(TxBuilder {
    //         unspendable: unspendable_hash_set,
    //         ..self.clone()
    //     })
    // }

    /// Spend all the available inputs. This respects filters like TxBuilder.unspendable and the change policy.
    // fn drain_wallet(&self) -> Arc<Self> {
    //     Arc::new(TxBuilder {
    //         drain_wallet: true,
    //         ..self.clone()
    //     })
    // }

    /// Sets the address to drain excess coins to. Usually, when there are excess coins they are sent to a change address
    /// generated by the wallet. This option replaces the usual change address with an arbitrary ScriptPubKey of your choosing.
    /// Just as with a change output, if the drain output is not needed (the excess coins are too small) it will not be included
    /// in the resulting transaction. The only difference is that it is valid to use drain_to without setting any ordinary recipients
    /// with add_recipient (but it is perfectly fine to add recipients as well). If you choose not to set any recipients, you should
    /// either provide the utxos that the transaction should spend via add_utxos, or set drain_wallet to spend all of them.
    /// When bumping the fees of a transaction made with this option, you probably want to use BumpFeeTxBuilder.allow_shrinking
    /// to allow this output to be reduced to pay for the extra fees.
    // fn drain_to(&self, address: String) -> Arc<Self> {
    //     Arc::new(TxBuilder {
    //         drain_to: Some(address),
    //         ..self.clone()
    //     })
    // }
    /// Add an outpoint to the internal list of UTXOs that must be spent. These have priority over the "unspendable"
    /// utxos, meaning that if a utxo is present both in the "utxos" and the "unspendable" list, it will be spent.
    // fn add_utxo(&self, outpoint: OutPoint) -> Arc<Self> {
    //     self.add_utxos(vec![outpoint])
    // }

    /// Add the list of outpoints to the internal list of UTXOs that must be spent. If an error occurs while adding
    /// any of the UTXOs then none of them are added and the error is returned. These have priority over the "unspendable"
    /// utxos, meaning that if a utxo is present both in the "utxos" and the "unspendable" list, it will be spent.
    // fn add_utxos(&self, mut outpoints: Vec<OutPoint>) -> Arc<Self> {
    //     let mut utxos = self.utxos.to_vec();
    //     utxos.append(&mut outpoints);
    //     Arc::new(TxBuilder {
    //         utxos,
    //         ..self.clone()
    //     })
    // }

    /// Do not spend change outputs. This effectively adds all the change outputs to the "unspendable" list. See TxBuilder.unspendable.
    // fn do_not_spend_change(&self) -> Arc<Self> {
    //     Arc::new(TxBuilder {
    //         change_policy: ChangeSpendPolicy::ChangeForbidden,
    //         ..self.clone()
    //     })
    // }
    // /// Only spend change outputs. This effectively adds all the non-change outputs to the "unspendable" list. See TxBuilder.unspendable.
    // fn only_spend_change(&self) -> Arc<Self> {
    //     Arc::new(TxBuilder {
    //         change_policy: ChangeSpendPolicy::OnlyChange,
    //         ..self.clone()
    //     })
    // }

    /// Replace the internal list of unspendable utxos with a new list. It’s important to note that the "must-be-spent" utxos added with
    /// TxBuilder.addUtxo have priority over these. See the Rust docs of the two linked methods for more details.
    // fn unspendable(&self, unspendable: Vec<OutPoint>) -> Arc<Self> {
    //     Arc::new(TxBuilder {
    //         unspendable: unspendable.into_iter().collect(),
    //         ..self.clone()
    //     })
    // }

    /// Set a custom fee rate.
    pub fn fee_rate(&self, sat_per_vb: f32) -> Arc<Self> {
        Arc::new(TxBuilder {
            fee_rate: Some(sat_per_vb),
            ..self.clone()
        })
    }

    //
    // pub(crate) fn enable_rbf(&self) -> Arc<Self> {
    //     Arc::new(TxBuilder {
    //         rbf: Some(RbfValue::Default),
    //         ..self.clone()
    //     })
    // }
    //
    // pub(crate) fn enable_rbf_with_sequence(&self, nsequence: u32) -> Arc<Self> {
    //     Arc::new(TxBuilder {
    //         rbf: Some(RbfValue::Value(nsequence)),
    //         ..self.clone()
    //     })
    // }
    //
    // pub(crate) fn add_data(&self, data: Vec<u8>) -> Arc<Self> {
    //     Arc::new(TxBuilder {
    //         data,
    //         ..self.clone()
    //     })
    // }

    pub(crate) fn finish(
        &self,
        wallet: &Wallet,
    ) -> Result<Arc<PartiallySignedBitcoinTransaction>, Error> {
        let wallet = wallet.get_wallet();
        let mut tx_builder = wallet.build_tx();
        for (address, amount) in &self.recipients {
            tx_builder.add_recipient(to_script_pubkey(address)?, *amount);
        }
        tx_builder.change_policy(self.change_policy);
        if !self.utxos.is_empty() {
            let bdk_utxos: Vec<BdkOutPoint> = self.utxos.iter().map(BdkOutPoint::from).collect();
            let utxos: &[BdkOutPoint] = &bdk_utxos;
            tx_builder.add_utxos(utxos)?;
        }
        if !self.unspendable.is_empty() {
            let bdk_unspendable: Vec<BdkOutPoint> =
                self.unspendable.iter().map(BdkOutPoint::from).collect();
            tx_builder.unspendable(bdk_unspendable);
        }
        if let Some(sat_per_vb) = self.fee_rate {
            tx_builder.fee_rate(FeeRate::from_sat_per_vb(sat_per_vb));
        }
        if let Some(fee_amount) = self.fee_absolute {
            tx_builder.fee_absolute(fee_amount);
        }
        if self.drain_wallet {
            tx_builder.drain_wallet();
        }
        if let Some(address) = &self.drain_to {
            tx_builder.drain_to(to_script_pubkey(address)?);
        }
        tx_builder
            .finish()
            .map(|(psbt, _)| PartiallySignedBitcoinTransaction {
                internal: Mutex::new(psbt),
            })
            .map(Arc::new)
    }
}

pub fn generate_mnemonic_from_entropy(entropy: usize) -> Mnemonic {
    let entropy_rand = gen_big_rand(entropy);
    let mnemonic: Mnemonic =
        Mnemonic::from_entropy_in(Language::English, entropy_rand.as_slice()).unwrap();
    mnemonic
}
pub fn generate_mnemonic_from_word_count(word_count: WordCount) -> Mnemonic {
    let mnemonic_gen: GeneratedKey<_, BareCtx> =
        Mnemonic::generate((word_count, Language::English)).unwrap();
    let mnemonic = mnemonic_gen.clone().into_key();
    mnemonic
}

impl DerivationPath {
    pub(crate) fn new(path: String) -> Result<Self, BdkError> {
        BdkDerivationPath::from_str(&path)
            .map(|x| DerivationPath {
                derivation_path_mutex: Mutex::new(x),
            })
            .map_err(|e| BdkError::Generic(e.to_string()))
    }
}
// pub fn restore_extended_key(
//     network: Network,
//     mnemonic: String,
//     password: Option<String>,
// ) -> Result<ExtendedKeyInfo, Error> {
//   let xkey = create_extended_key(mnemonic.clone(), password);
//     let xprv =  xkey.into_xprv(network).unwrap();
//     let fingerprint = xprv.fingerprint(&Secp256k1::new());
//     Ok(ExtendedKeyInfo {
//         xprv: xprv.to_string(),
//         fingerprint: fingerprint.to_string(),
//     })
// }
fn create_extended_key(mnemonic: String, password: Option<String>) -> ExtendedKey {
    let mnemonic = Mnemonic::parse_in(Language::English, mnemonic).unwrap();
    let xkey: ExtendedKey = (mnemonic.clone(), password).into_extended_key().unwrap();
    xkey
}

pub fn get_extended_key_info(
    network: Network,
    mnemonic: String,
    password: Option<String>,
) -> ExtendedKeyInfo {
    let xprv = DescriptorSecretKey::new(network, mnemonic, password).unwrap();
    let xpub = xprv.as_public();
    ExtendedKeyInfo {
        xprv: xprv.as_string(),
        xpub: xpub.as_string(),
    }
}


impl DescriptorSecretKey {
    pub(crate) fn new(
        network: Network,
        mnemonic: String,
        password: Option<String>,
    ) -> Result<Self, BdkError> {
        let xkey = create_extended_key(mnemonic, password);
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

    pub(crate) fn derive(&self, path: Arc<DerivationPath>) -> Result<Arc<Self>, BdkError> {
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

    pub(crate) fn as_public(&self) -> Arc<DescriptorPublicKey> {
        let secp = Secp256k1::new();
        let descriptor_public_key = self
            .descriptor_secret_key_mutex
            .lock()
            .unwrap()
            .as_public(&secp)
            .unwrap();
        Arc::new(DescriptorPublicKey {
            descriptor_public_key_mutex: Mutex::new(descriptor_public_key),
        })
    }

    pub fn as_string(&self) -> String {
        self.descriptor_secret_key_mutex.lock().unwrap().to_string()
    }
}
impl DescriptorPublicKey {
    pub(crate) fn as_string(&self) -> String {
        self.descriptor_public_key_mutex.lock().unwrap().to_string()
    }
}

pub fn gen_big_rand(bit_size: usize) -> Vec<u8> {
    let mut rng = rand::thread_rng();
    let mut entropy = vec![0u8; bit_size];
    rand::RngCore::fill_bytes(&mut rng, &mut entropy);
    entropy
}

pub enum AddressIndex {
    New,
    LastUnused,
}
#[repr(C)]
pub struct AddressInfo {
    pub index: u32,
    pub address: String,
}
#[derive(Clone, Serialize, Deserialize)]
pub struct AddressAmount {
    pub address: String,
    pub amount: u64,
}
#[derive(Clone, Serialize, Deserialize)]
#[repr(C)]
#[derive(Debug, PartialEq, Eq)]
pub struct TransactionDetails {
    pub fee: Option<u64>,
    pub received: u64,
    pub sent: u64,
    pub txid: String,
    pub confirmation_time: Option<BlockConfirmationTime>,
}
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[repr(C)]
pub enum Transaction {
    Unconfirmed {
        details: TransactionDetails,
    },
    Confirmed {
        details: TransactionDetails,
        confirmation: BlockConfirmationTime,
    },
}
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct BlockConfirmationTime {
    pub height: u32,
    pub timestamp: u64,
}
/// A reference to a transaction output.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub struct OutPoint {
    /// The referenced transaction's txid.
    pub(crate) txid: String,
    /// The index of the referenced output in its transaction's vout.
    pub(crate) vout: u32,
}
#[derive(Serialize, Deserialize)]
pub struct Balance {
    // All coinbase outputs not yet matured
    pub immature: u64,
    /// Unconfirmed UTXOs generated by a wallet tx
    pub trusted_pending: u64,
    /// Unconfirmed UTXOs received from an external wallet
    pub untrusted_pending: u64,
    /// Confirmed and immediately spendable balance
    pub confirmed: u64,
    /// Get sum of trusted_pending and confirmed coins
    pub spendable: u64,
    /// Get the whole balance visible to the wallet
    pub total: u64,
}
/// A transaction output, which defines new coins to be created from old ones.
pub struct TxOut {
    /// The value of the output, in satoshis.
    pub(crate) value: u64,
    /// The address of the output.
    pub(crate) address: String,
}
pub struct LocalUtxo {
    pub(crate) outpoint: OutPoint,
    pub(crate) txout: TxOut,
    // keychain: KeychainKind,
    pub(crate) is_spent: bool,
}

pub struct PartiallySignedBitcoinTransaction {
    pub(crate) internal: Mutex<PartiallySignedTransaction>,
}
#[allow(dead_code)]
#[derive(Clone, Debug)]
pub struct TxBuilder {
    pub(crate) recipients: Vec<(String, u64)>,
    pub(crate) utxos: Vec<OutPoint>,
    pub(crate) unspendable: HashSet<OutPoint>,
    pub(crate) change_policy: ChangeSpendPolicy,
    pub(crate) manually_selected_only: bool,
    pub(crate) fee_rate: Option<f32>,
    pub(crate) fee_absolute: Option<u64>,
    pub(crate) drain_wallet: bool,
    pub(crate) drain_to: Option<String>,
    // rbf: Option<RbfValue>,
    pub(crate) data: Vec<u8>,
}
pub struct DerivationPath {
    pub(crate) derivation_path_mutex: Mutex<BdkDerivationPath>,
}
pub struct DescriptorSecretKey {
    pub(crate) descriptor_secret_key_mutex: Mutex<BdkDescriptorSecretKey>,
}
pub struct DescriptorPublicKey {
    pub(crate) descriptor_public_key_mutex: Mutex<BdkDescriptorPublicKey>,
}
