use crate::api::error::{BdkError, HexError};
use bdk::bitcoin::consensus::{serialize, Decodable};
use bdk::bitcoin::hashes::hex::Error;
use bdk::database::AnyDatabaseConfig;
use serde::{Deserialize, Serialize};
use std::io::Cursor;
use std::str::FromStr;
use crate::frb_generated::RustOpaque;

/// A reference to a transaction output.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub struct OutPoint {
    /// The referenced transaction's txid.
    pub(crate) txid: String,
    /// The index of the referenced output in its transaction's vout.
    pub(crate) vout: u32,
}
impl From<&OutPoint> for bdk::bitcoin::OutPoint {
    fn from(x: &OutPoint) -> bdk::bitcoin::OutPoint {
        bdk::bitcoin::OutPoint {
            txid: bdk::bitcoin::Txid::from_str(x.txid.as_str()).expect("invalid txid"),
            vout: x.clone().vout,
        }
    }
}
impl From<bdk::bitcoin::OutPoint> for OutPoint {
    fn from(x: bdk::bitcoin::OutPoint) -> OutPoint {
        OutPoint {
            txid: x.txid.to_string(),
            vout: x.clone().vout,
        }
    }
}
#[derive(Debug, Clone)]
pub struct TxIn {
    pub previous_output: OutPoint,
    pub script_sig: ScriptBufBase,
    pub sequence: u32,
    pub witness: Vec<Vec<u8>>,
}

impl From<&bdk::bitcoin::TxIn> for TxIn {
    fn from(x: &bdk::bitcoin::TxIn) -> Self {
        TxIn {
            previous_output: x.previous_output.into(),
            script_sig: x.clone().script_sig.into(),
            sequence: x.clone().sequence.0,
            witness: x.witness.to_vec(),
        }
    }
}
///A transaction output, which defines new coins to be created from old ones.
pub struct TxOut {
    /// The value of the output, in satoshis.
    pub value: u64,
    /// The address of the output.
    pub script_pubkey: ScriptBufBase,
}
impl From<TxOut> for bdk::bitcoin::TxOut {
    fn from(value: TxOut) -> Self {
        Self {
            value: value.value,
            script_pubkey: value.script_pubkey.into(),
        }
    }
}
impl From<&bdk::bitcoin::TxOut> for TxOut {
    fn from(x: &bdk::bitcoin::TxOut) -> Self {
        TxOut {
            value: x.clone().value,
            script_pubkey: x.clone().script_pubkey.into(),
        }
    }
}
#[derive(Clone, Debug)]
pub struct ScriptBufBase {
    pub bytes: Vec<u8>,
}
impl From<bdk::bitcoin::ScriptBuf> for ScriptBufBase {
    fn from(value: bdk::bitcoin::ScriptBuf) -> Self {
        Self {
            bytes: value.as_bytes().to_vec(),
        }
    }
}
impl From<ScriptBufBase> for bdk::bitcoin::ScriptBuf {
    fn from(value: ScriptBufBase) -> Self {
        bdk::bitcoin::ScriptBuf::from_bytes(value.bytes)
    }
}
impl ScriptBufBase {
    ///Creates a new empty script.
    pub fn empty() -> ScriptBufBase {
        bdk::bitcoin::ScriptBuf::new().into()
    }
    ///Creates a new empty script with pre-allocated capacity.
    pub fn with_capacity(capacity: usize) -> ScriptBufBase {
        bdk::bitcoin::ScriptBuf::with_capacity(capacity).into()
    }

    pub fn from_hex(s: String) -> Result<ScriptBufBase, BdkError> {
        bdk::bitcoin::ScriptBuf::from_hex(s.as_str())
            .map(|e| e.into())
            .map_err(|e| match e {
                Error::InvalidChar(e) => BdkError::Hex(HexError::InvalidChar(e)),
                Error::OddLengthString(e) => BdkError::Hex(HexError::OddLengthString(e)),
                Error::InvalidLength(e, f) => BdkError::Hex(HexError::InvalidLength(e, f)),
            })
    }
}
pub struct PsbtSigHashType {
    pub inner: u32,
}
impl From<PsbtSigHashType> for bdk::bitcoin::psbt::PsbtSighashType {
    fn from(value: PsbtSigHashType) -> Self {
        bdk::bitcoin::psbt::PsbtSighashType::from_u32(value.inner)
    }
}
/// Local Wallet's Balance
#[derive(Deserialize)]
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
impl From<bdk::Balance> for Balance {
    fn from(value: bdk::Balance) -> Self {
        Balance {
            immature: value.immature,
            trusted_pending: value.trusted_pending,
            untrusted_pending: value.untrusted_pending,
            confirmed: value.confirmed,
            spendable: value.get_spendable(),
            total: value.get_total(),
        }
    }
}
/// The address index selection strategy to use to derived an address from the wallet's external
/// descriptor.
pub enum AddressIndex {
    ///Return a new address after incrementing the current descriptor index.
    Increase,
    ///Return the address for the current descriptor index if it has not been used in a received transaction. Otherwise return a new address as with AddressIndex.New.
    ///Use with caution, if the wallet has not yet detected an address has been used it could return an already used address. This function is primarily meant for situations where the caller is untrusted; for example when deriving donation addresses on-demand for a public web page.
    LastUnused,
    /// Return the address for a specific descriptor index. Does not change the current descriptor
    /// index used by `AddressIndex` and `AddressIndex.LastUsed`.
    /// Use with caution, if an index is given that is less than the current descriptor index
    /// then the returned address may have already been used.
    Peek { index: u32 },
    /// Return the address for a specific descriptor index and reset the current descriptor index
    /// used by `AddressIndex` and `AddressIndex.LastUsed` to this value.
    /// Use with caution, if an index is given that is less than the current descriptor index
    /// then the returned address and subsequent addresses returned by calls to `AddressIndex`
    /// and `AddressIndex.LastUsed` may have already been used. Also if the index is reset to a
    /// value earlier than the Blockchain stopGap (default is 20) then a
    /// larger stopGap should be used to monitor for all possibly used addresses.
    Reset { index: u32 },
}
impl From<AddressIndex> for bdk::wallet::AddressIndex {
    fn from(x: AddressIndex) -> bdk::wallet::AddressIndex {
        match x {
            AddressIndex::Increase => bdk::wallet::AddressIndex::New,
            AddressIndex::LastUnused => bdk::wallet::AddressIndex::LastUnused,
            AddressIndex::Peek { index } => bdk::wallet::AddressIndex::Peek(index),
            AddressIndex::Reset { index } => bdk::wallet::AddressIndex::Reset(index),
        }
    }
}
///A derived address and the index it was found at For convenience this automatically derefs to Address
pub struct AddressInfo {
    ///Child index of this address
    pub index: u32,
    /// Address
    pub address: String,
}
impl From<bdk::wallet::AddressInfo> for AddressInfo {
    fn from(x: bdk::wallet::AddressInfo) -> AddressInfo {
        AddressInfo {
            index: x.index,
            address: x.address.to_string(),
        }
    }
}
#[derive(Debug, Clone, PartialEq, Eq)]
///A wallet transaction
pub struct TransactionDetails {
    pub transaction: Option<TransactionBase>,
    /// Transaction id.
    pub txid: String,
    /// Received value (sats)
    /// Sum of owned outputs of this transaction.
    pub received: u64,
    /// Sent value (sats)
    /// Sum of owned inputs of this transaction.
    pub sent: u64,
    /// Fee value (sats) if confirmed.
    /// The availability of the fee depends on the backend. It's never None with an Electrum
    /// Server backend, but it could be None with a Bitcoin RPC node without txindex that receive
    /// funds while offline.
    pub fee: Option<u64>,
    /// If the transaction is confirmed, contains height and timestamp of the block containing the
    /// transaction, unconfirmed transaction contains `None`.
    pub confirmation_time: Option<BlockTime>,
}
/// A wallet transaction
impl From<&bdk::TransactionDetails> for TransactionDetails {
    fn from(x: &bdk::TransactionDetails) -> TransactionDetails {
        TransactionDetails {
            transaction: x.clone().transaction.map(|e| e.into()),
            fee: x.clone().fee,
            txid: x.clone().txid.to_string(),
            received: x.clone().received,
            sent: x.clone().sent,
            confirmation_time: x.confirmation_time.clone().map(|e| e.into()),
        }
    }
}
impl From<bdk::TransactionDetails> for TransactionDetails {
    fn from(x: bdk::TransactionDetails) -> TransactionDetails {
        TransactionDetails {
            transaction: x.transaction.map(|e| e.into()),
            fee: x.fee,
            txid: x.txid.to_string(),
            received: x.received,
            sent: x.sent,
            confirmation_time: x.confirmation_time.map(|e| e.into()),
        }
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
///Block height and timestamp of a block
pub struct BlockTime {
    ///Confirmation block height
    pub height: u32,
    ///Confirmation block timestamp
    pub timestamp: u64,
}
impl From<bdk::BlockTime> for BlockTime {
    fn from(value: bdk::BlockTime) -> Self {
        Self {
            height: value.height,
            timestamp: value.timestamp,
        }
    }
}
/// A output script and an amount of satoshis.
pub struct ScriptAmount {
    pub script: ScriptBufBase,
    pub amount: u64,
}
#[allow(dead_code)]
#[derive(Clone, Debug)]
pub enum RbfValue {
    RbfDefault,
    Value(u32),
}
#[derive(Debug, Clone)]
///The cryptocurrency to act on
pub enum Network {
    ///Bitcoin’s testnet
    Testnet,
    ///Bitcoin’s regtest
    Regtest,
    ///Classic Bitcoin
    Bitcoin,
    ///Bitcoin’s signet
    Signet,
}
impl Default for Network {
    fn default() -> Self {
        Network::Testnet
    }
}
impl From<Network> for bdk::bitcoin::Network {
    fn from(network: Network) -> Self {
        match network {
            Network::Signet => bdk::bitcoin::Network::Signet,
            Network::Testnet => bdk::bitcoin::Network::Testnet,
            Network::Regtest => bdk::bitcoin::Network::Regtest,
            Network::Bitcoin => bdk::bitcoin::Network::Bitcoin,
        }
    }
}
impl From<bdk::bitcoin::Network> for Network {
    fn from(network: bdk::bitcoin::Network) -> Self {
        match network {
            bdk::bitcoin::Network::Signet => Network::Signet,
            bdk::bitcoin::Network::Testnet => Network::Testnet,
            bdk::bitcoin::Network::Regtest => Network::Regtest,
            bdk::bitcoin::Network::Bitcoin => Network::Bitcoin,
            _ => unreachable!(),
        }
    }
}
///Type describing entropy length (aka word count) in the mnemonic
pub enum WordCount {
    ///12 words mnemonic (128 bits entropy)
    Words12,
    ///18 words mnemonic (192 bits entropy)
    Words18,
    ///24 words mnemonic (256 bits entropy)
    Words24,
}
impl From<WordCount> for bdk::keys::bip39::WordCount {
    fn from(word_count: WordCount) -> Self {
        match word_count {
            WordCount::Words12 => bdk::keys::bip39::WordCount::Words12,
            WordCount::Words18 => bdk::keys::bip39::WordCount::Words18,
            WordCount::Words24 => bdk::keys::bip39::WordCount::Words24,
        }
    }
}
/// The method used to produce an address.
#[derive(Debug)]
pub enum Payload {
    /// P2PKH address.
    PubkeyHash { pubkey_hash: String },
    /// P2SH address.
    ScriptHash { script_hash: String },
    /// Segwit address.
    WitnessProgram {
        /// The witness program version.
        version: WitnessVersion,
        /// The witness program.
        program: Vec<u8>,
    },
}
#[derive(Debug, Clone)]
pub enum WitnessVersion {
    /// Initial version of witness program. Used for P2WPKH and P2WPK outputs
    V0 = 0,
    /// Version of witness program used for Taproot P2TR outputs.
    V1 = 1,
    /// Future (unsupported) version of witness program.
    V2 = 2,
    /// Future (unsupported) version of witness program.
    V3 = 3,
    /// Future (unsupported) version of witness program.
    V4 = 4,
    /// Future (unsupported) version of witness program.
    V5 = 5,
    /// Future (unsupported) version of witness program.
    V6 = 6,
    /// Future (unsupported) version of witness program.
    V7 = 7,
    /// Future (unsupported) version of witness program.
    V8 = 8,
    /// Future (unsupported) version of witness program.
    V9 = 9,
    /// Future (unsupported) version of witness program.
    V10 = 10,
    /// Future (unsupported) version of witness program.
    V11 = 11,
    /// Future (unsupported) version of witness program.
    V12 = 12,
    /// Future (unsupported) version of witness program.
    V13 = 13,
    /// Future (unsupported) version of witness program.
    V14 = 14,
    /// Future (unsupported) version of witness program.
    V15 = 15,
    /// Future (unsupported) version of witness program.
    V16 = 16,
}
impl From<bdk::bitcoin::address::WitnessVersion> for WitnessVersion {
    fn from(value: bdk::bitcoin::address::WitnessVersion) -> Self {
        match value {
            bdk::bitcoin::address::WitnessVersion::V0 => WitnessVersion::V0,
            bdk::bitcoin::address::WitnessVersion::V1 => WitnessVersion::V1,
            bdk::bitcoin::address::WitnessVersion::V2 => WitnessVersion::V2,
            bdk::bitcoin::address::WitnessVersion::V3 => WitnessVersion::V3,
            bdk::bitcoin::address::WitnessVersion::V4 => WitnessVersion::V4,
            bdk::bitcoin::address::WitnessVersion::V5 => WitnessVersion::V5,
            bdk::bitcoin::address::WitnessVersion::V6 => WitnessVersion::V6,
            bdk::bitcoin::address::WitnessVersion::V7 => WitnessVersion::V7,
            bdk::bitcoin::address::WitnessVersion::V8 => WitnessVersion::V8,
            bdk::bitcoin::address::WitnessVersion::V9 => WitnessVersion::V9,
            bdk::bitcoin::address::WitnessVersion::V10 => WitnessVersion::V10,
            bdk::bitcoin::address::WitnessVersion::V11 => WitnessVersion::V11,
            bdk::bitcoin::address::WitnessVersion::V12 => WitnessVersion::V12,
            bdk::bitcoin::address::WitnessVersion::V13 => WitnessVersion::V13,
            bdk::bitcoin::address::WitnessVersion::V14 => WitnessVersion::V14,
            bdk::bitcoin::address::WitnessVersion::V15 => WitnessVersion::V15,
            bdk::bitcoin::address::WitnessVersion::V16 => WitnessVersion::V16,
        }
    }
}
pub enum ChangeSpendPolicy {
    ChangeAllowed,
    OnlyChange,
    ChangeForbidden,
}
impl From<ChangeSpendPolicy> for bdk::wallet::tx_builder::ChangeSpendPolicy {
    fn from(value: ChangeSpendPolicy) -> Self {
        match value {
            ChangeSpendPolicy::ChangeAllowed => {
                bdk::wallet::tx_builder::ChangeSpendPolicy::ChangeAllowed
            }
            ChangeSpendPolicy::OnlyChange => bdk::wallet::tx_builder::ChangeSpendPolicy::OnlyChange,
            ChangeSpendPolicy::ChangeForbidden => {
                bdk::wallet::tx_builder::ChangeSpendPolicy::ChangeForbidden
            }
        }
    }
}
pub struct AddressBase {
    pub ptr: RustOpaque<bdk::bitcoin::Address>,
}
impl From<bdk::bitcoin::Address> for AddressBase {
    fn from(value: bdk::bitcoin::Address) -> Self {
        Self { ptr: RustOpaque::new(value) }
    }
}
impl From<&AddressBase> for bdk::bitcoin::Address {
    fn from(value: &AddressBase) -> Self {
        (*value.ptr).clone()
    }
}
impl AddressBase {
    pub fn from_string(address: String, network: Network) -> Result<Self, BdkError> {
        match bdk::bitcoin::Address::from_str(address.as_str()) {
            Ok(e) => match e.require_network(network.into()) {
                Ok(e) => Ok(e.into()),
                Err(e) => Err(e.into()),
            },
            Err(e) => Err(e.into()),
        }
    }

    pub fn from_script(script: ScriptBufBase, network: Network) -> Result<Self, BdkError> {
        bdk::bitcoin::Address::from_script(
            <ScriptBufBase as Into<bdk::bitcoin::ScriptBuf>>::into(script).as_script(),
            network.into(),
        )
        .map(|a| a.into())
        .map_err(|e| e.into())
    }
    pub fn payload(&self) -> Payload {
        match <&AddressBase as Into<bdk::bitcoin::Address>>::into(self).payload {
            bdk::bitcoin::address::Payload::PubkeyHash(pubkey_hash) => Payload::PubkeyHash {
                pubkey_hash: pubkey_hash.to_string(),
            },
            bdk::bitcoin::address::Payload::ScriptHash(script_hash) => Payload::ScriptHash {
                script_hash: script_hash.to_string(),
            },
            bdk::bitcoin::address::Payload::WitnessProgram(e) => Payload::WitnessProgram {
                version: e.version().into(),
                program: e.program().as_bytes().to_vec(),
            },
            _ => unreachable!(),
        }
    }

    ///Creates a URI string bitcoin:address optimized to be encoded in QR codes.
    // If the address is bech32, both the schema and the address become uppercase. If the address is base58, the schema is lowercase and the address is left mixed case.
    // Quoting BIP 173 "inside QR codes uppercase SHOULD be used, as those permit the use of alphanumeric mode, which is 45% more compact than the normal byte mode."
    // Note however that despite BIP21 explicitly stating that the bitcoin: prefix should be parsed as case-insensitive many wallets got this wrong and don't parse correctly. See compatibility table.
    // If you want to avoid allocation you can use alternate display instead:
    // write!(writer, "{:#}", address)?;
    pub fn to_qr_uri(&self) -> String {
        self.ptr.to_qr_uri()
    }
    ///The network on which this address is usable.
    pub fn network(&self) -> Network {
        self.ptr.network.into()
    }

    pub fn script(ptr: AddressBase) -> ScriptBufBase {
        ptr.ptr.script_pubkey().into()
    }

    pub fn is_valid_for_network(&self, network: Network) -> bool {
        let address_str = self.ptr.to_string();
        if let Ok(unchecked_address) = address_str
            .parse::<bdk::bitcoin::address::Address<bdk::bitcoin::address::NetworkUnchecked>>()
        {
            unchecked_address.is_valid_for_network(network.into())
        } else {
            false
        }
    }

    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}
pub enum Variant {
    Bech32,
    Bech32m,
}
impl From<bdk::bitcoin::bech32::Variant> for Variant {
    fn from(value: bdk::bitcoin::bech32::Variant) -> Self {
        match value {
            bdk::bitcoin::bech32::Variant::Bech32 => Variant::Bech32,
            bdk::bitcoin::bech32::Variant::Bech32m => Variant::Bech32m,
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct TransactionBase {
    pub inner: String,
}
impl TransactionBase {
    pub fn new(transaction_bytes: Vec<u8>) -> Result<Self, BdkError> {
        let mut decoder = Cursor::new(transaction_bytes);
        let tx: bdk::bitcoin::transaction::Transaction =
            bdk::bitcoin::transaction::Transaction::consensus_decode(&mut decoder)?;
        Ok(tx.into())
    }
    ///Computes the txid. For non-segwit transactions this will be identical to the output of wtxid(),
    /// but for segwit transactions, this will give the correct txid (not including witnesses) while wtxid will also hash witnesses.
    pub fn txid(&self) -> String {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self)
            .txid()
            .to_string()
    }
    ///Returns the regular byte-wise consensus-serialized size of this transaction.
    pub fn weight(&self) -> u64 {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self)
            .weight()
            .to_wu()
    }
    ///Returns the regular byte-wise consensus-serialized size of this transaction.
    pub fn size(&self) -> u64 {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self).size() as u64
    }
    ///Returns the “virtual size” (vsize) of this transaction.
    ///
    // Will be ceil(weight / 4.0). Note this implements the virtual size as per BIP141, which is different to what is implemented in Bitcoin Core.
    // The computation should be the same for any remotely sane transaction, and a standardness-rule-correct version is available in the policy module.
    pub fn vsize(&self) -> u64 {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self).vsize() as u64
    }
    ///Encodes an object into a vector.
    pub fn serialize(&self) -> Vec<u8> {
        serialize(&<&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self))
    }
    ///Is this a coin base transaction?
    pub fn is_coin_base(&self) -> bool {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self).is_coin_base()
    }
    ///Returns true if the transaction itself opted in to be BIP-125-replaceable (RBF).
    /// This does not cover the case where a transaction becomes replaceable due to ancestors being RBF.
    pub fn is_explicitly_rbf(&self) -> bool {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self).is_explicitly_rbf()
    }
    ///Returns true if this transactions nLockTime is enabled (BIP-65 ).
    pub fn is_lock_time_enabled(&self) -> bool {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self).is_lock_time_enabled()
    }
    ///The protocol version, is currently expected to be 1 or 2 (BIP 68).
    pub fn version(&self) -> i32 {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self).version
    }
    ///Block height or timestamp. Transaction cannot be included in a block until this height/time.
    pub fn lock_time(&self) -> u32 {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self)
            .lock_time
            .to_consensus_u32()
    }
    ///List of transaction inputs.
    pub fn input(&self) -> Vec<TxIn> {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self)
            .input
            .iter()
            .map(|x| x.into())
            .collect()
    }
    ///List of transaction outputs.
    pub fn output(&self) -> Vec<TxOut> {
        <&TransactionBase as Into<bdk::bitcoin::Transaction>>::into(self)
            .output
            .iter()
            .map(|x| (&x.clone()).into())
            .collect()
    }
}
impl From<bdk::bitcoin::Transaction> for TransactionBase {
    fn from(tx: bdk::bitcoin::Transaction) -> Self {
        TransactionBase {
            inner: serde_json::to_string(&tx).expect("invalid tx"),
        }
    }
}
impl From<&TransactionBase> for bdk::bitcoin::Transaction {
    fn from(tx: &TransactionBase) -> Self {
        let tx: bdk::bitcoin::Transaction = serde_json::from_str(&tx.inner).expect("invalid tx");
        tx
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

#[derive(Debug, Clone)]
///Types of keychains
pub enum KeychainKind {
    ExternalChain,
    ///Internal, usually used for change outputs
    InternalChain,
}
impl From<bdk::KeychainKind> for KeychainKind {
    fn from(e: bdk::KeychainKind) -> Self {
        match e {
            bdk::KeychainKind::External => KeychainKind::ExternalChain,
            bdk::KeychainKind::Internal => KeychainKind::InternalChain,
        }
    }
}
impl From<KeychainKind> for bdk::KeychainKind {
    fn from(kind: KeychainKind) -> Self {
        match kind {
            KeychainKind::ExternalChain => bdk::KeychainKind::External,
            KeychainKind::InternalChain => bdk::KeychainKind::Internal,
        }
    }
}
///Unspent outputs of this wallet
pub struct LocalUtxo {
    pub outpoint: OutPoint,
    pub txout: TxOut,
    pub keychain: KeychainKind,
    pub is_spent: bool,
}
impl From<bdk::LocalUtxo> for LocalUtxo {
    fn from(local_utxo: bdk::LocalUtxo) -> Self {
        LocalUtxo {
            outpoint: OutPoint {
                txid: local_utxo.outpoint.txid.to_string(),
                vout: local_utxo.outpoint.vout,
            },
            txout: TxOut {
                value: local_utxo.txout.value,
                script_pubkey: ScriptBufBase {
                    bytes: local_utxo.txout.script_pubkey.into_bytes(),
                },
            },
            keychain: local_utxo.keychain.into(),
            is_spent: local_utxo.is_spent,
        }
    }
}
impl From<LocalUtxo> for bdk::LocalUtxo {
    fn from(value: LocalUtxo) -> Self {
        Self {
            outpoint: (&value.outpoint).into(),
            txout: value.txout.into(),
            keychain: value.keychain.into(),
            is_spent: value.is_spent,
        }
    }
}
/// Options for a software signer
///
/// Adjust the behavior of our software signers and the way a transaction is finalized
#[derive(Debug, Clone, Default)]
pub struct SignOptions {
    pub multi_sig: bool,
    /// Whether the signer should trust the `witness_utxo`, if the `non_witness_utxo` hasn't been
    /// provided
    ///
    /// Defaults to `false` to mitigate the "SegWit bug" which should trick the wallet into
    /// paying a fee larger than expected.
    ///
    /// Some wallets, especially if relatively old, might not provide the `non_witness_utxo` for
    /// SegWit transactions in the PSBT they generate: in those cases setting this to `true`
    /// should correctly produce a signature, at the expense of an increased trust in the creator
    /// of the PSBT.
    ///
    /// For more details see: <https://blog.trezor.io/details-of-firmware-updates-for-trezor-one-version-1-9-1-and-trezor-model-t-version-2-3-1-1eba8f60f2dd>
    pub trust_witness_utxo: bool,

    /// Whether the wallet should assume a specific height has been reached when trying to finalize
    /// a transaction
    ///
    /// The wallet will only "use" a timelock to satisfy the spending policy of an input if the
    /// timelock height has already been reached. This option allows overriding the "current height" to let the
    /// wallet use timelocks in the future to spend a coin.
    pub assume_height: Option<u32>,

    /// Whether the signer should use the `sighash_type` set in the PSBT when signing, no matter
    /// what its value is
    ///
    /// Defaults to `false` which will only allow signing using `SIGHASH_ALL`.
    pub allow_all_sighashes: bool,

    /// Whether to remove partial signatures from the PSBT inputs while finalizing PSBT.
    ///
    /// Defaults to `true` which will remove partial signatures during finalization.
    pub remove_partial_sigs: bool,

    /// Whether to try finalizing the PSBT after the inputs are signed.
    ///
    /// Defaults to `true` which will try finalizing PSBT after inputs are signed.
    pub try_finalize: bool,

    // Specifies which Taproot script-spend leaves we should sign for. This option is
    // ignored if we're signing a non-taproot PSBT.
    //
    // Defaults to All, i.e., the wallet will sign all the leaves it has a key for.
    // TODO pub tap_leaves_options: TapLeavesOptions,
    /// Whether we should try to sign a taproot transaction with the taproot internal key
    /// or not. This option is ignored if we're signing a non-taproot PSBT.
    ///
    /// Defaults to `true`, i.e., we always try to sign with the taproot internal key.
    pub sign_with_tap_internal_key: bool,

    /// Whether we should grind ECDSA signature to ensure signing with low r
    /// or not.
    /// Defaults to `true`, i.e., we always grind ECDSA signature to sign with low r.
    pub allow_grinding: bool,
}
impl From<SignOptions> for bdk::SignOptions {
    fn from(sign_options: SignOptions) -> Self {
        bdk::SignOptions {
            trust_witness_utxo: sign_options.trust_witness_utxo,
            assume_height: sign_options.assume_height,
            allow_all_sighashes: sign_options.allow_all_sighashes,
            remove_partial_sigs: sign_options.remove_partial_sigs,
            try_finalize: sign_options.try_finalize,
            tap_leaves_options: Default::default(),
            sign_with_tap_internal_key: sign_options.sign_with_tap_internal_key,
            allow_grinding: sign_options.allow_grinding,
        }
    }
}
#[derive(Copy, Clone)]
pub struct FeeRate {
    pub sat_per_vb: f32,
}
impl From<FeeRate> for bdk::FeeRate {
    fn from(value: FeeRate) -> Self {
        bdk::FeeRate::from_sat_per_vb(value.sat_per_vb)
    }
}
impl From<bdk::FeeRate> for FeeRate {
    fn from(value: bdk::FeeRate) -> Self {
        Self {
            sat_per_vb: value.as_sat_per_vb(),
        }
    }
}
// impl FeeRate {
//     /// Constructs `FeeRate` from satoshis per 1000 weight units.
//     pub fn from_sat_per_kwu(sat_per_kwu: f32) -> Self {
//         bdk::FeeRate::from_sat_per_kwu(sat_per_kwu).into()
//     }
//
//     ///Create a new instance of FeeRate given a float fee rate in sats/kvb
//     pub fn from_sat_per_vb(sat_per_kvb: f32) -> Self {
//         bdk::FeeRate::from_sat_per_vb(sat_per_kvb).into()
//     }
//
// }

/// A key-value map for an input of the corresponding index in the unsigned
pub struct Input {
    pub s: String,
}
impl From<Input> for bdk::bitcoin::psbt::Input {
    fn from(value: Input) -> Self {
        serde_json::from_str(value.s.as_str()).expect("input cannot be de-serialized")
    }
}
impl From<bdk::bitcoin::psbt::Input> for Input {
    fn from(value: bdk::bitcoin::psbt::Input) -> Self {
        Input {
            s: serde_json::to_string(&value).expect("input cannot be serialized"),
        }
    }
}