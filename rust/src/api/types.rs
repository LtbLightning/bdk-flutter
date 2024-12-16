use crate::api::error::{BdkError, HexError};
use crate::frb_generated::RustOpaque;
use bdk::bitcoin::consensus::{serialize, Decodable};
use bdk::bitcoin::hashes::hex::Error;
use bdk::database::AnyDatabaseConfig;
use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::io::Cursor;
use std::str::FromStr;

/// A reference to a transaction output.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub struct OutPoint {
    /// The referenced transaction's txid.
    pub(crate) txid: String,
    /// The index of the referenced output in its transaction's vout.
    pub(crate) vout: u32,
}
impl TryFrom<&OutPoint> for bdk::bitcoin::OutPoint {
    type Error = BdkError;

    fn try_from(x: &OutPoint) -> Result<Self, Self::Error> {
        Ok(bdk::bitcoin::OutPoint {
            txid: bdk::bitcoin::Txid::from_str(x.txid.as_str()).map_err(|e| match e {
                Error::InvalidChar(e) => BdkError::Hex(HexError::InvalidChar(e)),
                Error::OddLengthString(e) => BdkError::Hex(HexError::OddLengthString(e)),
                Error::InvalidLength(e, f) => BdkError::Hex(HexError::InvalidLength(e, f)),
            })?,
            vout: x.clone().vout,
        })
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
pub struct BdkTxIn {
    pub previous_output: OutPoint,
    pub script_sig: Option<BdkScriptBuf>,
    pub sequence: u32,
    pub witness: Vec<Vec<u8>>,
}
impl TryFrom<&BdkTxIn> for bdk::bitcoin::TxIn {
    type Error = BdkError;

    fn try_from(x: &BdkTxIn) -> Result<Self, Self::Error> {
        Ok(bdk::bitcoin::TxIn {
            previous_output: (&x.previous_output).try_into()?,
            script_sig: x
                .script_sig
                .as_ref()
                .map_or_else(|| BdkScriptBuf::empty().into(), |e| e.clone().into()),
            sequence: bdk::bitcoin::blockdata::transaction::Sequence::from_consensus(
                x.sequence.clone(),
            ),
            witness: bdk::bitcoin::blockdata::witness::Witness::from_slice(
                x.clone().witness.as_slice(),
            ),
        })
    }
}
impl From<&bdk::bitcoin::TxIn> for BdkTxIn {
    fn from(x: &bdk::bitcoin::TxIn) -> Self {
        BdkTxIn {
            previous_output: x.previous_output.into(),
            script_sig: (!x.script_sig.is_empty())
                .then(|| Some(x.script_sig.clone().into()))
                .unwrap_or_else(|| None),
            sequence: x.clone().sequence.0,
            witness: x.witness.to_vec(),
        }
    }
}
///A transaction output, which defines new coins to be created from old ones.
pub struct BdkTxOut {
    /// The value of the output, in satoshis.
    pub value: u64,
    /// The address of the output.
    pub script_pubkey: BdkScriptBuf,
}
impl From<BdkTxOut> for bdk::bitcoin::TxOut {
    fn from(value: BdkTxOut) -> Self {
        Self {
            value: value.value,
            script_pubkey: value.script_pubkey.into(),
        }
    }
}
impl From<&bdk::bitcoin::TxOut> for BdkTxOut {
    fn from(x: &bdk::bitcoin::TxOut) -> Self {
        BdkTxOut {
            value: x.clone().value,
            script_pubkey: x.clone().script_pubkey.into(),
        }
    }
}
impl From<&BdkTxOut> for bdk::bitcoin::TxOut {
    fn from(x: &BdkTxOut) -> Self {
        Self {
            value: x.value,
            script_pubkey: x.script_pubkey.clone().into(),
        }
    }
}
#[derive(Clone, Debug)]
pub struct BdkScriptBuf {
    pub bytes: Vec<u8>,
}
impl From<bdk::bitcoin::ScriptBuf> for BdkScriptBuf {
    fn from(value: bdk::bitcoin::ScriptBuf) -> Self {
        Self {
            bytes: value.as_bytes().to_vec(),
        }
    }
}
impl From<BdkScriptBuf> for bdk::bitcoin::ScriptBuf {
    fn from(value: BdkScriptBuf) -> Self {
        bdk::bitcoin::ScriptBuf::from_bytes(value.bytes)
    }
}
impl BdkScriptBuf {
    #[frb(sync)]
    ///Creates a new empty script.
    pub fn empty() -> BdkScriptBuf {
        bdk::bitcoin::ScriptBuf::new().into()
    }
    #[frb(sync)]
    ///Creates a new empty script with pre-allocated capacity.
    pub fn with_capacity(capacity: usize) -> BdkScriptBuf {
        bdk::bitcoin::ScriptBuf::with_capacity(capacity).into()
    }
    #[frb(sync)]
    pub fn from_hex(s: String) -> Result<BdkScriptBuf, BdkError> {
        bdk::bitcoin::ScriptBuf::from_hex(s.as_str())
            .map(|e| e.into())
            .map_err(|e| match e {
                Error::InvalidChar(e) => BdkError::Hex(HexError::InvalidChar(e)),
                Error::OddLengthString(e) => BdkError::Hex(HexError::OddLengthString(e)),
                Error::InvalidLength(e, f) => BdkError::Hex(HexError::InvalidLength(e, f)),
            })
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        let script: bdk::bitcoin::ScriptBuf = self.to_owned().into();
        script.to_string()
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
#[derive(Deserialize, Debug)]
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
#[derive(Debug, Clone, PartialEq, Eq)]
///A wallet transaction
pub struct BdkTransactionDetails {
    pub transaction: Option<BdkTransaction>,
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
impl TryFrom<&bdk::TransactionDetails> for BdkTransactionDetails {
    type Error = BdkError;

    fn try_from(x: &bdk::TransactionDetails) -> Result<Self, Self::Error> {
        let transaction: Option<BdkTransaction> = if let Some(tx) = x.transaction.clone() {
            Some(tx.try_into()?)
        } else {
            None
        };
        Ok(BdkTransactionDetails {
            transaction,
            fee: x.clone().fee,
            txid: x.clone().txid.to_string(),
            received: x.clone().received,
            sent: x.clone().sent,
            confirmation_time: x.confirmation_time.clone().map(|e| e.into()),
        })
    }
}
impl TryFrom<bdk::TransactionDetails> for BdkTransactionDetails {
    type Error = BdkError;

    fn try_from(x: bdk::TransactionDetails) -> Result<Self, Self::Error> {
        let transaction: Option<BdkTransaction> = if let Some(tx) = x.transaction {
            Some(tx.try_into()?)
        } else {
            None
        };
        Ok(BdkTransactionDetails {
            transaction,
            fee: x.fee,
            txid: x.txid.to_string(),
            received: x.received,
            sent: x.sent,
            confirmation_time: x.confirmation_time.map(|e| e.into()),
        })
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
    pub script: BdkScriptBuf,
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
pub struct BdkAddress {
    pub ptr: RustOpaque<bdk::bitcoin::Address>,
}
impl From<bdk::bitcoin::Address> for BdkAddress {
    fn from(value: bdk::bitcoin::Address) -> Self {
        Self {
            ptr: RustOpaque::new(value),
        }
    }
}
impl From<&BdkAddress> for bdk::bitcoin::Address {
    fn from(value: &BdkAddress) -> Self {
        (*value.ptr).clone()
    }
}
impl BdkAddress {
    #[frb(sync)]
    pub fn from_string(address: String, network: Network) -> Result<Self, BdkError> {
        match bdk::bitcoin::Address::from_str(address.as_str()) {
            Ok(e) => match e.require_network(network.into()) {
                Ok(e) => Ok(e.into()),
                Err(e) => Err(e.into()),
            },
            Err(e) => Err(e.into()),
        }
    }
    #[frb(sync)]
    pub fn from_script(script: BdkScriptBuf, network: Network) -> Result<Self, BdkError> {
        bdk::bitcoin::Address::from_script(
            <BdkScriptBuf as Into<bdk::bitcoin::ScriptBuf>>::into(script).as_script(),
            network.into(),
        )
        .map(|a| a.into())
        .map_err(|e| e.into())
    }
    #[frb(sync)]
    pub fn payload(&self) -> Payload {
        match <&BdkAddress as Into<bdk::bitcoin::Address>>::into(self).payload {
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
    #[frb(sync)]
    pub fn to_qr_uri(&self) -> String {
        self.ptr.to_qr_uri()
    }
    #[frb(sync)]
    pub fn network(&self) -> Network {
        self.ptr.network.into()
    }
    #[frb(sync)]
    pub fn script(ptr: BdkAddress) -> BdkScriptBuf {
        ptr.ptr.script_pubkey().into()
    }
    #[frb(sync)]
    pub fn is_valid_for_network(&self, network: Network) -> bool {
        if let Ok(unchecked_address) = self
            .ptr
            .to_string()
            .parse::<bdk::bitcoin::address::Address<bdk::bitcoin::address::NetworkUnchecked>>()
        {
            unchecked_address.is_valid_for_network(network.into())
        } else {
            false
        }
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.ptr.to_string()
    }
}
#[derive(Debug)]
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
#[derive(Debug, Clone)]
pub enum LockTime {
    Blocks(u32),
    Seconds(u32),
}

impl TryFrom<LockTime> for bdk::bitcoin::blockdata::locktime::absolute::LockTime {
    type Error = BdkError;

    fn try_from(value: LockTime) -> Result<Self, Self::Error> {
        match value {
            LockTime::Blocks(e) => Ok(
                bdk::bitcoin::blockdata::locktime::absolute::LockTime::Blocks(
                    bdk::bitcoin::blockdata::locktime::absolute::Height::from_consensus(e)
                        .map_err(|e| BdkError::InvalidLockTime(e.to_string()))?,
                ),
            ),
            LockTime::Seconds(e) => Ok(
                bdk::bitcoin::blockdata::locktime::absolute::LockTime::Seconds(
                    bdk::bitcoin::blockdata::locktime::absolute::Time::from_consensus(e)
                        .map_err(|e| BdkError::InvalidLockTime(e.to_string()))?,
                ),
            ),
        }
    }
}

impl From<bdk::bitcoin::blockdata::locktime::absolute::LockTime> for LockTime {
    fn from(value: bdk::bitcoin::blockdata::locktime::absolute::LockTime) -> Self {
        match value {
            bdk::bitcoin::blockdata::locktime::absolute::LockTime::Blocks(e) => {
                LockTime::Blocks(e.to_consensus_u32())
            }
            bdk::bitcoin::blockdata::locktime::absolute::LockTime::Seconds(e) => {
                LockTime::Seconds(e.to_consensus_u32())
            }
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct BdkTransaction {
    pub s: String,
}
impl BdkTransaction {
    #[frb(sync)]
    pub fn create(
        version: i32,
        lock_time: LockTime,
        input: Vec<BdkTxIn>,
        output: Vec<BdkTxOut>,
    ) -> Result<BdkTransaction, BdkError> {
        let mut inputs: Vec<bdk::bitcoin::blockdata::transaction::TxIn> = vec![];
        for e in input.iter() {
            inputs.push(e.try_into()?);
        }
        let output = output
            .into_iter()
            .map(|e| <&BdkTxOut as Into<bdk::bitcoin::blockdata::transaction::TxOut>>::into(&e))
            .collect();

        (bdk::bitcoin::Transaction {
            version,
            lock_time: lock_time.try_into()?,
            input: inputs,
            output,
        })
        .try_into()
    }
    #[frb(sync)]
    pub fn from_bytes(transaction_bytes: Vec<u8>) -> Result<Self, BdkError> {
        let mut decoder = Cursor::new(transaction_bytes);
        let tx: bdk::bitcoin::transaction::Transaction =
            bdk::bitcoin::transaction::Transaction::consensus_decode(&mut decoder)?;
        tx.try_into()
    }
    #[frb(sync)]
    ///Computes the txid. For non-segwit transactions this will be identical to the output of wtxid(),
    /// but for segwit transactions, this will give the correct txid (not including witnesses) while wtxid will also hash witnesses.
    pub fn txid(&self) -> Result<String, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.txid().to_string())
    }
    #[frb(sync)]
    ///Returns the regular byte-wise consensus-serialized size of this transaction.
    pub fn weight(&self) -> Result<u64, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.weight().to_wu())
    }
    #[frb(sync)]
    ///Returns the regular byte-wise consensus-serialized size of this transaction.
    pub fn size(&self) -> Result<u64, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.size() as u64)
    }
    #[frb(sync)]
    ///Returns the “virtual size” (vsize) of this transaction.
    ///
    // Will be ceil(weight / 4.0). Note this implements the virtual size as per BIP141, which is different to what is implemented in Bitcoin Core.
    // The computation should be the same for any remotely sane transaction, and a standardness-rule-correct version is available in the policy module.
    pub fn vsize(&self) -> Result<u64, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.vsize() as u64)
    }
    #[frb(sync)]
    ///Encodes an object into a vector.
    pub fn serialize(&self) -> Result<Vec<u8>, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| serialize(&e))
    }
    #[frb(sync)]
    ///Is this a coin base transaction?
    pub fn is_coin_base(&self) -> Result<bool, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.is_coin_base())
    }
    #[frb(sync)]
    ///Returns true if the transaction itself opted in to be BIP-125-replaceable (RBF).
    /// This does not cover the case where a transaction becomes replaceable due to ancestors being RBF.
    pub fn is_explicitly_rbf(&self) -> Result<bool, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.is_explicitly_rbf())
    }
    #[frb(sync)]
    ///Returns true if this transactions nLockTime is enabled (BIP-65 ).
    pub fn is_lock_time_enabled(&self) -> Result<bool, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.is_lock_time_enabled())
    }
    #[frb(sync)]
    ///The protocol version, is currently expected to be 1 or 2 (BIP 68).
    pub fn version(&self) -> Result<i32, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.version)
    }
    #[frb(sync)]
    ///Block height or timestamp. Transaction cannot be included in a block until this height/time.
    pub fn lock_time(&self) -> Result<LockTime, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.lock_time.into())
    }
    #[frb(sync)]
    ///List of transaction inputs.
    pub fn input(&self) -> Result<Vec<BdkTxIn>, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.input.iter().map(|x| x.into()).collect())
    }

    #[frb(sync)]
    ///List of transaction outputs.
    pub fn output(&self) -> Result<Vec<BdkTxOut>, BdkError> {
        self.try_into()
            .map(|e: bdk::bitcoin::Transaction| e.output.iter().map(|x| x.into()).collect())
    }
}
impl TryFrom<bdk::bitcoin::Transaction> for BdkTransaction {
    type Error = BdkError;
    fn try_from(tx: bdk::bitcoin::Transaction) -> Result<Self, Self::Error> {
        Ok(BdkTransaction {
            s: serde_json::to_string(&tx)
                .map_err(|e| BdkError::InvalidTransaction(e.to_string()))?,
        })
    }
}
impl TryFrom<&BdkTransaction> for bdk::bitcoin::Transaction {
    type Error = BdkError;
    fn try_from(tx: &BdkTransaction) -> Result<Self, Self::Error> {
        serde_json::from_str(&tx.s).map_err(|e| BdkError::InvalidTransaction(e.to_string()))
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
    pub txout: BdkTxOut,
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
            txout: BdkTxOut {
                value: local_utxo.txout.value,
                script_pubkey: BdkScriptBuf {
                    bytes: local_utxo.txout.script_pubkey.into_bytes(),
                },
            },
            keychain: local_utxo.keychain.into(),
            is_spent: local_utxo.is_spent,
        }
    }
}
impl TryFrom<LocalUtxo> for bdk::LocalUtxo {
    type Error = BdkError;

    fn try_from(value: LocalUtxo) -> Result<Self, Self::Error> {
        Ok(Self {
            outpoint: (&value.outpoint).try_into()?,
            txout: value.txout.into(),
            keychain: value.keychain.into(),
            is_spent: value.is_spent,
        })
    }
}
/// Options for a software signer
///
/// Adjust the behavior of our software signers and the way a transaction is finalized
#[derive(Debug, Clone, Default)]
pub struct SignOptions {
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

/// A key-value map for an input of the corresponding index in the unsigned
pub struct Input {
    pub s: String,
}
impl TryFrom<Input> for bdk::bitcoin::psbt::Input {
    type Error = BdkError;
    fn try_from(value: Input) -> Result<Self, Self::Error> {
        serde_json::from_str(value.s.as_str()).map_err(|e| BdkError::InvalidInput(e.to_string()))
    }
}
impl TryFrom<bdk::bitcoin::psbt::Input> for Input {
    type Error = BdkError;

    fn try_from(value: bdk::bitcoin::psbt::Input) -> Result<Self, Self::Error> {
        Ok(Input {
            s: serde_json::to_string(&value).map_err(|e| BdkError::InvalidInput(e.to_string()))?,
        })
    }
}
#[derive(Debug, Clone)]
pub struct BdkPolicy {
    pub ptr: RustOpaque<bdk::descriptor::Policy>,
}
impl BdkPolicy {
    #[frb(sync)]
    pub fn id(&self) -> String {
        self.ptr.id.clone()
    }
    #[frb(sync)]
    pub fn as_string(&self) -> Result<String, BdkError> {
        serde_json::to_string(&*self.ptr).map_err(|e| BdkError::Generic(e.to_string()))
    }
    #[frb(sync)]
    pub fn requires_path(&self) -> bool {
        self.ptr.requires_path()
    }
    #[frb(sync)]
    pub fn item(&self) -> SatisfiableItem {
        self.ptr.item.clone().into()
    }
    #[frb(sync)]
    pub fn satisfaction(&self) -> Satisfaction {
        self.ptr.satisfaction.clone().into()
    }
    #[frb(sync)]
    pub fn contribution(&self) -> Satisfaction {
        self.ptr.contribution.clone().into()
    }
}
impl From<bdk::descriptor::Policy> for BdkPolicy {
    fn from(value: bdk::descriptor::Policy) -> Self {
        BdkPolicy {
            ptr: RustOpaque::new(value),
        }
    }
}

#[derive(Debug, Clone)]
pub enum SatisfiableItem {
    EcdsaSignature {
        key: PkOrF,
    },
    SchnorrSignature {
        key: PkOrF,
    },
    Sha256Preimage {
        hash: String,
    },
    Hash256Preimage {
        hash: String,
    },
    Ripemd160Preimage {
        hash: String,
    },
    Hash160Preimage {
        hash: String,
    },
    AbsoluteTimelock {
        value: LockTime,
    },
    RelativeTimelock {
        value: u32,
    },

    Multisig {
        keys: Vec<PkOrF>,

        threshold: u64,
    },

    Thresh {
        items: Vec<BdkPolicy>,

        threshold: u64,
    },
}
impl From<bdk::descriptor::policy::SatisfiableItem> for SatisfiableItem {
    fn from(value: bdk::descriptor::policy::SatisfiableItem) -> Self {
        match value {
            bdk::descriptor::policy::SatisfiableItem::EcdsaSignature(pk_or_f) => {
                SatisfiableItem::EcdsaSignature {
                    key: pk_or_f.into(),
                }
            }
            bdk::descriptor::policy::SatisfiableItem::SchnorrSignature(pk_or_f) => {
                SatisfiableItem::SchnorrSignature {
                    key: pk_or_f.into(),
                }
            }
            bdk::descriptor::policy::SatisfiableItem::Sha256Preimage { hash } => {
                SatisfiableItem::Sha256Preimage {
                    hash: hash.to_string(),
                }
            }
            bdk::descriptor::policy::SatisfiableItem::Hash256Preimage { hash } => {
                SatisfiableItem::Hash256Preimage {
                    hash: hash.to_string(),
                }
            }
            bdk::descriptor::policy::SatisfiableItem::Ripemd160Preimage { hash } => {
                SatisfiableItem::Ripemd160Preimage {
                    hash: hash.to_string(),
                }
            }
            bdk::descriptor::policy::SatisfiableItem::Hash160Preimage { hash } => {
                SatisfiableItem::Hash160Preimage {
                    hash: hash.to_string(),
                }
            }
            bdk::descriptor::policy::SatisfiableItem::AbsoluteTimelock { value } => {
                SatisfiableItem::AbsoluteTimelock {
                    value: value.into(),
                }
            }
            bdk::descriptor::policy::SatisfiableItem::RelativeTimelock { value } => {
                SatisfiableItem::RelativeTimelock {
                    value: value.to_consensus_u32(),
                }
            }
            bdk::descriptor::policy::SatisfiableItem::Multisig { keys, threshold } => {
                SatisfiableItem::Multisig {
                    keys: keys.iter().map(|e| e.to_owned().into()).collect(),
                    threshold: threshold as u64,
                }
            }
            bdk::descriptor::policy::SatisfiableItem::Thresh { items, threshold } => {
                SatisfiableItem::Thresh {
                    items: items.iter().map(|e| e.to_owned().into()).collect(),
                    threshold: threshold as u64,
                }
            }
        }
    }
}

#[derive(Debug, Clone)]
pub enum PkOrF {
    Pubkey { value: String },
    XOnlyPubkey { value: String },
    Fingerprint { value: String },
}
impl From<bdk::descriptor::policy::PkOrF> for PkOrF {
    fn from(value: bdk::descriptor::policy::PkOrF) -> Self {
        match value {
            bdk::descriptor::policy::PkOrF::Pubkey(public_key) => PkOrF::Pubkey {
                value: public_key.to_string(),
            },
            bdk::descriptor::policy::PkOrF::XOnlyPubkey(xonly_public_key) => PkOrF::XOnlyPubkey {
                value: xonly_public_key.to_string(),
            },
            bdk::descriptor::policy::PkOrF::Fingerprint(fingerprint) => PkOrF::Fingerprint {
                value: fingerprint.to_string(),
            },
        }
    }
}

#[derive(Debug, Clone)]
pub enum Satisfaction {
    Partial {
        n: u64,
        m: u64,
        items: Vec<u64>,
        sorted: Option<bool>,
        conditions: HashMap<u32, Vec<Condition>>,
    },
    PartialComplete {
        n: u64,
        m: u64,
        items: Vec<u64>,
        sorted: Option<bool>,
        conditions: HashMap<Vec<u32>, Vec<Condition>>,
    },
    Complete {
        condition: Condition,
    },

    None {
        msg: String,
    },
}
impl From<bdk::descriptor::policy::Satisfaction> for Satisfaction {
    fn from(value: bdk::descriptor::policy::Satisfaction) -> Self {
        match value {
            bdk::descriptor::policy::Satisfaction::Partial {
                n,
                m,
                items,
                sorted,
                conditions,
            } => Satisfaction::Partial {
                n: n as u64,
                m: m as u64,
                items: items.iter().map(|e| e.to_owned() as u64).collect(),
                sorted,
                conditions: conditions
                    .into_iter()
                    .map(|(index, conditions)| {
                        (
                            index as u32,
                            conditions.into_iter().map(|e| e.into()).collect(),
                        )
                    })
                    .collect(),
            },
            bdk::descriptor::policy::Satisfaction::PartialComplete {
                n,
                m,
                items,
                sorted,
                conditions,
            } => Satisfaction::PartialComplete {
                n: n as u64,
                m: m as u64,
                items: items.iter().map(|e| e.to_owned() as u64).collect(),
                sorted,
                conditions: conditions
                    .into_iter()
                    .map(|(index, conditions)| {
                        (
                            index.iter().map(|e| e.to_owned() as u32).collect(),
                            conditions.into_iter().map(|e| e.into()).collect(), // Convert each `Condition` to `YourType`
                        )
                    })
                    .collect(),
            },
            bdk::descriptor::policy::Satisfaction::Complete { condition } => {
                Satisfaction::Complete {
                    condition: condition.into(),
                }
            }
            bdk::descriptor::policy::Satisfaction::None => Satisfaction::None {
                msg: "Cannot satisfy or contribute to the policy item".to_string(),
            },
        }
    }
}

#[derive(Debug, Clone)]
pub struct Condition {
    pub csv: Option<u32>,
    pub timelock: Option<LockTime>,
}
impl From<bdk::descriptor::policy::Condition> for Condition {
    fn from(value: bdk::descriptor::policy::Condition) -> Self {
        Condition {
            csv: value.csv.map(|e| e.to_consensus_u32()),
            timelock: value.timelock.map(|e| e.into()),
        }
    }
}
