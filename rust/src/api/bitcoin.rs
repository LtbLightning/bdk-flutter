use bdk_core::bitcoin::{address::FromScriptError, consensus::Decodable, io::Cursor};
use bdk_wallet::psbt::PsbtUtils;
use flutter_rust_bridge::frb;
use std::{ops::Deref, str::FromStr};

use crate::frb_generated::RustOpaque;

use super::{
    error::{
        AddressParseError, ExtractTxError, PsbtError, PsbtParseError, TransactionError,
        TxidParseError,
    },
    types::{LockTime, Network},
};

pub struct FfiAddress(pub RustOpaque<bdk_core::bitcoin::Address>);
impl From<bdk_core::bitcoin::Address> for FfiAddress {
    fn from(value: bdk_core::bitcoin::Address) -> Self {
        Self(RustOpaque::new(value))
    }
}
impl From<&FfiAddress> for bdk_core::bitcoin::Address {
    fn from(value: &FfiAddress) -> Self {
        (*value.0).clone()
    }
}
impl FfiAddress {
    pub fn from_string(address: String, network: Network) -> Result<Self, AddressParseError> {
        match bdk_core::bitcoin::Address::from_str(address.as_str()) {
            Ok(e) => match e.require_network(network.into()) {
                Ok(e) => Ok(e.into()),
                Err(e) => Err(e.into()),
            },
            Err(e) => Err(e.into()),
        }
    }

    pub fn from_script(script: FfiScriptBuf, network: Network) -> Result<Self, FromScriptError> {
        bdk_core::bitcoin::Address::from_script(
            <FfiScriptBuf as Into<bdk_core::bitcoin::ScriptBuf>>::into(script).as_script(),
            bdk_core::bitcoin::params::Params::new(network.into()),
        )
        .map(|a| a.into())
        .map_err(|e| e.into())
    }

    #[frb(sync)]
    pub fn to_qr_uri(&self) -> String {
        self.0.to_qr_uri()
    }

    #[frb(sync)]
    pub fn script(ptr: FfiAddress) -> FfiScriptBuf {
        ptr.0.script_pubkey().into()
    }

    #[frb(sync)]
    pub fn is_valid_for_network(&self, network: Network) -> bool {
        if
            let Ok(unchecked_address) = self.0
                .to_string()
                .parse::<bdk_core::bitcoin::address::Address<bdk_core::bitcoin::address::NetworkUnchecked>>()
        {
            unchecked_address.is_valid_for_network(network.into())
        } else {
            false
        }
    }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.0.to_string()
    }
}

#[derive(Clone, Debug)]
pub struct FfiScriptBuf {
    pub bytes: Vec<u8>,
}
impl From<bdk_core::bitcoin::ScriptBuf> for FfiScriptBuf {
    fn from(value: bdk_core::bitcoin::ScriptBuf) -> Self {
        Self {
            bytes: value.as_bytes().to_vec(),
        }
    }
}
impl From<FfiScriptBuf> for bdk_core::bitcoin::ScriptBuf {
    fn from(value: FfiScriptBuf) -> Self {
        bdk_core::bitcoin::ScriptBuf::from_bytes(value.bytes)
    }
}
impl FfiScriptBuf {
    #[frb(sync)]
    ///Creates a new empty script.
    pub fn empty() -> FfiScriptBuf {
        bdk_core::bitcoin::ScriptBuf::new().into()
    }
    ///Creates a new empty script with pre-allocated capacity.
    pub fn with_capacity(capacity: usize) -> FfiScriptBuf {
        bdk_core::bitcoin::ScriptBuf::with_capacity(capacity).into()
    }

    // pub fn from_hex(s: String) -> Result<FfiScriptBuf, HexToBytesError> {
    //     bdk_core::bitcoin::ScriptBuf
    //         ::from_hex(s.as_str())
    //         .map(|e| e.into())
    //         .map_err(|e| {
    //             match e {
    //                 bdk_core::bitcoin::hex::HexToBytesError::InvalidChar(e) => HexToByteError(e),
    //                 HexToBytesError::OddLengthString(e) =>
    //                     BdkError::Hex(HexError::OddLengthString(e)),
    //             }
    //         })
    // }
    #[frb(sync)]
    pub fn as_string(&self) -> String {
        let script: bdk_core::bitcoin::ScriptBuf = self.to_owned().into();
        script.to_string()
    }
}

pub struct FfiTransaction {
    pub s: String,
}
impl FfiTransaction {
    // pub fn new(
    //     version: i32,
    //     lock_time: LockTime,
    //     input: Vec<TxIn>,
    //     output: Vec<TxOut>
    // ) -> Result<FfiTransaction, TransactionError> {
    //     let mut inputs: Vec<bdk_core::bitcoin::blockdata::transaction::TxIn> = vec![];
    //     for e in input.iter() {
    //         inputs.push(e.try_into()?);
    //     }
    //     let output = output
    //         .into_iter()
    //         .map(|e| <&TxOut as Into<bdk_core::bitcoin::blockdata::transaction::TxOut>>::into(&e))
    //         .collect();
    //     (bdk_core::bitcoin::Transaction {
    //         version,
    //         lock_time: lock_time.try_into()?,
    //         input: inputs,
    //         output,
    //     }).try_into()
    // }

    pub fn from_bytes(transaction_bytes: Vec<u8>) -> Result<Self, TransactionError> {
        let mut decoder = Cursor::new(transaction_bytes);
        let tx: bdk_core::bitcoin::transaction::Transaction =
            bdk_core::bitcoin::transaction::Transaction::consensus_decode(&mut decoder)?;
        tx.try_into()
    }
    /// Computes the [`Txid`].
    ///
    /// Hashes the transaction **excluding** the segwit data (i.e. the marker, flag bytes, and the
    /// witness fields themselves). For non-segwit transactions which do not have any segwit data,
    pub fn compute_txid(&self) -> Result<String, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.compute_txid().to_string())
    }
    ///Returns the regular byte-wise consensus-serialized size of this transaction.
    pub fn weight(&self) -> Result<u64, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.weight().to_wu())
    }
    ///Returns the “virtual size” (vsize) of this transaction.
    ///
    // Will be ceil(weight / 4.0). Note this implements the virtual size as per BIP141, which is different to what is implemented in Bitcoin Core.
    // The computation should be the same for any remotely sane transaction, and a standardness-rule-correct version is available in the policy module.
    pub fn vsize(&self) -> Result<u64, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.vsize() as u64)
    }
    ///Encodes an object into a vector.
    pub fn serialize(&self) -> Result<Vec<u8>, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| bdk_core::bitcoin::consensus::serialize(&e))
    }
    ///Is this a coin base transaction?
    pub fn is_coinbase(&self) -> Result<bool, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.is_coinbase())
    }
    ///Returns true if the transaction itself opted in to be BIP-125-replaceable (RBF).
    /// This does not cover the case where a transaction becomes replaceable due to ancestors being RBF.
    pub fn is_explicitly_rbf(&self) -> Result<bool, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.is_explicitly_rbf())
    }
    ///Returns true if this transactions nLockTime is enabled (BIP-65 ).
    pub fn is_lock_time_enabled(&self) -> Result<bool, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.is_lock_time_enabled())
    }
    ///The protocol version, is currently expected to be 1 or 2 (BIP 68).
    pub fn version(&self) -> Result<i32, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.version.0)
    }
    ///Block height or timestamp. Transaction cannot be included in a block until this height/time.
    pub fn lock_time(&self) -> Result<LockTime, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.lock_time.into())
    }
    ///List of transaction inputs.
    pub fn input(&self) -> Result<Vec<TxIn>, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.input.iter().map(|x| x.into()).collect())
    }
    ///List of transaction outputs.
    pub fn output(&self) -> Result<Vec<TxOut>, TransactionError> {
        self.try_into()
            .map(|e: bdk_core::bitcoin::Transaction| e.output.iter().map(|x| x.into()).collect())
    }
}
impl TryFrom<bdk_core::bitcoin::Transaction> for FfiTransaction {
    type Error = TransactionError;
    fn try_from(tx: bdk_core::bitcoin::Transaction) -> Result<Self, Self::Error> {
        Ok(FfiTransaction {
            s: serde_json::to_string(&tx).map_err(|_| TransactionError::ParseFailed)?,
        })
    }
}

impl TryFrom<&FfiTransaction> for bdk_core::bitcoin::Transaction {
    type Error = TransactionError;
    fn try_from(tx: &FfiTransaction) -> Result<Self, Self::Error> {
        serde_json::from_str(&tx.s).map_err(|_| TransactionError::ParseFailed)
    }
}

#[derive(Debug)]
pub struct FfiPsbt {
    pub ptr: RustOpaque<std::sync::Mutex<bdk_core::bitcoin::psbt::Psbt>>,
}

impl From<bdk_core::bitcoin::psbt::Psbt> for FfiPsbt {
    fn from(value: bdk_core::bitcoin::psbt::Psbt) -> Self {
        Self {
            ptr: RustOpaque::new(std::sync::Mutex::new(value)),
        }
    }
}
impl FfiPsbt {
    pub fn from_str(psbt_base64: String) -> Result<FfiPsbt, PsbtParseError> {
        let psbt: bdk_core::bitcoin::psbt::Psbt =
            bdk_core::bitcoin::psbt::Psbt::from_str(&psbt_base64)?;
        Ok(psbt.into())
    }

    pub fn as_string(&self) -> String {
        self.ptr.lock().unwrap().to_string()
    }

    /// Return the transaction.
    #[frb(sync)]
    pub fn extract_tx(ptr: FfiPsbt) -> Result<FfiTransaction, ExtractTxError> {
        let tx = ptr.ptr.lock().unwrap().clone().extract_tx()?;
        //todo; create a proper otherTransaction error
        tx.try_into().map_err(|_| ExtractTxError::OtherExtractTxErr)
    }

    /// Combines this PartiallySignedTransaction with other PSBT as described by BIP 174.
    ///
    /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
    pub fn combine(ptr: FfiPsbt, other: FfiPsbt) -> Result<FfiPsbt, PsbtError> {
        let other_psbt = other.ptr.lock().unwrap().clone();
        let mut original_psbt = ptr.ptr.lock().unwrap().clone();
        original_psbt.combine(other_psbt)?;
        Ok(original_psbt.into())
    }

    /// The total transaction fee amount, sum of input amounts minus sum of output amounts, in Sats.
    /// If the PSBT is missing a TxOut for an input returns None.
    #[frb(sync)]
    pub fn fee_amount(&self) -> Option<u64> {
        self.ptr.lock().unwrap().fee_amount().map(|e| e.to_sat())
    }

    ///Serialize as raw binary data
    #[frb(sync)]
    pub fn serialize(&self) -> Vec<u8> {
        let psbt = self.ptr.lock().unwrap().clone();
        psbt.serialize()
    }
    /// Serialize the PSBT data structure as a String of JSON.
    #[frb(sync)]
    pub fn json_serialize(&self) -> Result<String, PsbtError> {
        let psbt = self.ptr.lock().unwrap();
        serde_json::to_string(psbt.deref()).map_err(|_| PsbtError::OtherPsbtErr)
    }
}

// A reference to a transaction output.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub struct OutPoint {
    /// The referenced transaction's txid.
    pub(crate) txid: String,
    /// The index of the referenced output in its transaction's vout.
    pub(crate) vout: u32,
}
impl TryFrom<&OutPoint> for bdk_core::bitcoin::OutPoint {
    type Error = TxidParseError;

    fn try_from(x: &OutPoint) -> Result<Self, Self::Error> {
        Ok(bdk_core::bitcoin::OutPoint {
            txid: bdk_core::bitcoin::Txid::from_str(x.txid.as_str()).map_err(|_| {
                TxidParseError::InvalidTxid {
                    txid: x.txid.to_owned(),
                }
            })?,
            vout: x.clone().vout,
        })
    }
}
impl From<bdk_core::bitcoin::OutPoint> for OutPoint {
    fn from(x: bdk_core::bitcoin::OutPoint) -> OutPoint {
        OutPoint {
            txid: x.txid.to_string(),
            vout: x.clone().vout,
        }
    }
}
#[derive(Debug, Clone)]
pub struct TxIn {
    pub previous_output: OutPoint,
    pub script_sig: FfiScriptBuf,
    pub sequence: u32,
    pub witness: Vec<Vec<u8>>,
}
impl TryFrom<&TxIn> for bdk_core::bitcoin::TxIn {
    type Error = TxidParseError;

    fn try_from(x: &TxIn) -> Result<Self, Self::Error> {
        Ok(bdk_core::bitcoin::TxIn {
            previous_output: (&x.previous_output).try_into()?,
            script_sig: x.clone().script_sig.into(),
            sequence: bdk_core::bitcoin::blockdata::transaction::Sequence::from_consensus(
                x.sequence.clone(),
            ),
            witness: bdk_core::bitcoin::blockdata::witness::Witness::from_slice(
                x.clone().witness.as_slice(),
            ),
        })
    }
}
impl From<&bdk_core::bitcoin::TxIn> for TxIn {
    fn from(x: &bdk_core::bitcoin::TxIn) -> Self {
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
    pub script_pubkey: FfiScriptBuf,
}
impl From<TxOut> for bdk_core::bitcoin::TxOut {
    fn from(value: TxOut) -> Self {
        Self {
            value: bdk_core::bitcoin::Amount::from_sat(value.value),
            script_pubkey: value.script_pubkey.into(),
        }
    }
}
impl From<&bdk_core::bitcoin::TxOut> for TxOut {
    fn from(x: &bdk_core::bitcoin::TxOut) -> Self {
        TxOut {
            value: x.clone().value.to_sat(),
            script_pubkey: x.clone().script_pubkey.into(),
        }
    }
}
impl From<&TxOut> for bdk_core::bitcoin::TxOut {
    fn from(value: &TxOut) -> Self {
        Self {
            value: bdk_core::bitcoin::Amount::from_sat(value.value.to_owned()),
            script_pubkey: value.script_pubkey.clone().into(),
        }
    }
}

#[derive(Copy, Clone)]
pub struct FeeRate {
    ///Constructs FeeRate from satoshis per 1000 weight units.
    pub sat_kwu: u64,
}
impl From<FeeRate> for bdk_core::bitcoin::FeeRate {
    fn from(value: FeeRate) -> Self {
        bdk_core::bitcoin::FeeRate::from_sat_per_kwu(value.sat_kwu)
    }
}
impl From<bdk_core::bitcoin::FeeRate> for FeeRate {
    fn from(value: bdk_core::bitcoin::FeeRate) -> Self {
        Self {
            sat_kwu: value.to_sat_per_kwu(),
        }
    }
}

// /// Parameters that influence chain consensus.
// #[derive(Debug, Clone)]
// pub struct Params {
//     /// Network for which parameters are valid.
//     pub network: Network,
//     /// Time when BIP16 becomes active.
//     pub bip16_time: u32,
//     /// Block height at which BIP34 becomes active.
//     pub bip34_height: u32,
//     /// Block height at which BIP65 becomes active.
//     pub bip65_height: u32,
//     /// Block height at which BIP66 becomes active.
//     pub bip66_height: u32,
//     /// Minimum blocks including miner confirmation of the total of 2016 blocks in a retargeting period,
//     /// (nPowTargetTimespan / nPowTargetSpacing) which is also used for BIP9 deployments.
//     /// Examples: 1916 for 95%, 1512 for testchains.
//     pub rule_change_activation_threshold: u32,
//     /// Number of blocks with the same set of rules.
//     pub miner_confirmation_window: u32,
//     /// The maximum **attainable** target value for these params.
//     ///
//     /// Not all target values are attainable because consensus code uses the compact format to
//     /// represent targets (see [`CompactTarget`]).
//     ///
//     /// Note that this value differs from Bitcoin Core's powLimit field in that this value is
//     /// attainable, but Bitcoin Core's is not. Specifically, because targets in Bitcoin are always
//     /// rounded to the nearest float expressible in "compact form", not all targets are attainable.
//     /// Still, this should not affect consensus as the only place where the non-compact form of
//     /// this is used in Bitcoin Core's consensus algorithm is in comparison and there are no
//     /// compact-expressible values between Bitcoin Core's and the limit expressed here.
//     pub max_attainable_target: FfiTarget,
//     /// Expected amount of time to mine one block.
//     pub pow_target_spacing: u64,
//     /// Difficulty recalculation interval.
//     pub pow_target_timespan: u64,
//     /// Determines whether minimal difficulty may be used for blocks or not.
//     pub allow_min_difficulty_blocks: bool,
//     /// Determines whether retargeting is disabled for this network or not.
//     pub no_pow_retargeting: bool,
// }
// impl From<Params> for bdk_core::bitcoin::params::Params {
//     fn from(value: Params) -> Self {

//     }
// }

// ///A 256 bit integer representing target.
// ///The SHA-256 hash of a block's header must be lower than or equal to the current target for the block to be accepted by the network. The lower the target, the more difficult it is to generate a block. (See also Work.)
// ///ref: https://en.bitcoin.it/wiki/Target

// #[derive(Debug, Clone)]
// pub struct FfiTarget(pub u32);
// impl From<FfiTarget> for bdk_core::bitcoin::pow::Target {
//     fn from(value: FfiTarget) -> Self {
//         let c_target = bdk_core::bitcoin::pow::CompactTarget::from_consensus(value.0);
//         bdk_core::bitcoin::pow::Target::from_compact(c_target)
//     }
// }
// impl FfiTarget {
//     ///Creates `` from a prefixed hex string.
//     pub fn from_hex(s: String) -> Result<FfiTarget, PrefixedHexError> {
//         bdk_core::bitcoin::pow::Target
//             ::from_hex(s.as_str())
//             .map(|e| FfiTarget(e.to_compact_lossy().to_consensus()))
//             .map_err(|e| e.into())
//     }
// }
