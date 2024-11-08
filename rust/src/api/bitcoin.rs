use bdk_core::bitcoin::{
    absolute::{Height, Time},
    address::FromScriptError,
    consensus::Decodable,
    io::Cursor,
    transaction::Version,
};
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
    pub fn script(opaque: FfiAddress) -> FfiScriptBuf {
        opaque.0.script_pubkey().into()
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
    pub opaque: RustOpaque<bdk_core::bitcoin::Transaction>,
}
impl From<&FfiTransaction> for bdk_core::bitcoin::Transaction {
    fn from(value: &FfiTransaction) -> Self {
        (*value.opaque).clone()
    }
}
impl From<bdk_core::bitcoin::Transaction> for FfiTransaction {
    fn from(value: bdk_core::bitcoin::Transaction) -> Self {
        FfiTransaction {
            opaque: RustOpaque::new(value),
        }
    }
}
impl FfiTransaction {
    pub fn new(
        version: i32,
        lock_time: LockTime,
        input: Vec<TxIn>,
        output: Vec<TxOut>,
    ) -> Result<FfiTransaction, TransactionError> {
        let mut inputs: Vec<bdk_core::bitcoin::blockdata::transaction::TxIn> = vec![];
        for e in input.iter() {
            inputs.push(
                e.try_into()
                    .map_err(|_| TransactionError::OtherTransactionErr)?,
            );
        }
        let output = output
            .into_iter()
            .map(|e| <&TxOut as Into<bdk_core::bitcoin::blockdata::transaction::TxOut>>::into(&e))
            .collect();
        let lock_time = match lock_time {
            LockTime::Blocks(height) => bdk_core::bitcoin::absolute::LockTime::Blocks(
                Height::from_consensus(height)
                    .map_err(|_| TransactionError::OtherTransactionErr)?,
            ),
            LockTime::Seconds(time) => bdk_core::bitcoin::absolute::LockTime::Seconds(
                Time::from_consensus(time).map_err(|_| TransactionError::OtherTransactionErr)?,
            ),
        };
        Ok((bdk_core::bitcoin::Transaction {
            version: Version::non_standard(version),
            lock_time: lock_time,
            input: inputs,
            output,
        })
        .into())
    }

    pub fn from_bytes(transaction_bytes: Vec<u8>) -> Result<Self, TransactionError> {
        let mut decoder = Cursor::new(transaction_bytes);
        let tx: bdk_core::bitcoin::transaction::Transaction =
            bdk_core::bitcoin::transaction::Transaction::consensus_decode(&mut decoder)?;
        Ok(tx.into())
    }
    #[frb(sync)]
    /// Computes the [`Txid`].
    ///
    /// Hashes the transaction **excluding** the segwit data (i.e. the marker, flag bytes, and the
    /// witness fields themselves). For non-segwit transactions which do not have any segwit data,
    pub fn compute_txid(&self) -> String {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self)
            .compute_txid()
            .to_string()
    }
    ///Returns the regular byte-wise consensus-serialized size of this transaction.
    pub fn weight(&self) -> u64 {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self)
            .weight()
            .to_wu()
    }
    #[frb(sync)]
    ///Returns the “virtual size” (vsize) of this transaction.
    ///
    // Will be ceil(weight / 4.0). Note this implements the virtual size as per BIP141, which is different to what is implemented in Bitcoin Core.
    // The computation should be the same for any remotely sane transaction, and a standardness-rule-correct version is available in the policy module.
    pub fn vsize(&self) -> u64 {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self).vsize() as u64
    }
    #[frb(sync)]
    ///Encodes an object into a vector.
    pub fn serialize(&self) -> Vec<u8> {
        let tx = <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self);
        bdk_core::bitcoin::consensus::serialize(&tx)
    }
    #[frb(sync)]
    ///Is this a coin base transaction?
    pub fn is_coinbase(&self) -> bool {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self).is_coinbase()
    }
    #[frb(sync)]
    ///Returns true if the transaction itself opted in to be BIP-125-replaceable (RBF).
    /// This does not cover the case where a transaction becomes replaceable due to ancestors being RBF.
    pub fn is_explicitly_rbf(&self) -> bool {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self).is_explicitly_rbf()
    }
    #[frb(sync)]
    ///Returns true if this transactions nLockTime is enabled (BIP-65 ).
    pub fn is_lock_time_enabled(&self) -> bool {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self).is_lock_time_enabled()
    }
    #[frb(sync)]
    ///The protocol version, is currently expected to be 1 or 2 (BIP 68).
    pub fn version(&self) -> i32 {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self)
            .version
            .0
    }
    #[frb(sync)]
    ///Block height or timestamp. Transaction cannot be included in a block until this height/time.
    pub fn lock_time(&self) -> LockTime {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self)
            .lock_time
            .into()
    }
    #[frb(sync)]
    ///List of transaction inputs.
    pub fn input(&self) -> Vec<TxIn> {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self)
            .input
            .iter()
            .map(|x| x.into())
            .collect()
    }
    #[frb(sync)]
    ///List of transaction outputs.
    pub fn output(&self) -> Vec<TxOut> {
        <&FfiTransaction as Into<bdk_core::bitcoin::Transaction>>::into(self)
            .output
            .iter()
            .map(|x| x.into())
            .collect()
    }
}

#[derive(Debug)]
pub struct FfiPsbt {
    pub opaque: RustOpaque<std::sync::Mutex<bdk_core::bitcoin::psbt::Psbt>>,
}

impl From<bdk_core::bitcoin::psbt::Psbt> for FfiPsbt {
    fn from(value: bdk_core::bitcoin::psbt::Psbt) -> Self {
        Self {
            opaque: RustOpaque::new(std::sync::Mutex::new(value)),
        }
    }
}
impl FfiPsbt {
    //todo; resolve unhandled unwrap()s
    pub fn from_str(psbt_base64: String) -> Result<FfiPsbt, PsbtParseError> {
        let psbt: bdk_core::bitcoin::psbt::Psbt =
            bdk_core::bitcoin::psbt::Psbt::from_str(&psbt_base64)?;
        Ok(psbt.into())
    }

    #[frb(sync)]
    pub fn as_string(&self) -> String {
        self.opaque.lock().unwrap().to_string()
    }

    /// Return the transaction.
    #[frb(sync)]
    pub fn extract_tx(opaque: FfiPsbt) -> Result<FfiTransaction, ExtractTxError> {
        let tx = opaque.opaque.lock().unwrap().clone().extract_tx()?;
        Ok(tx.into())
    }

    /// Combines this PartiallySignedTransaction with other PSBT as described by BIP 174.
    ///
    /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
    pub fn combine(opaque: FfiPsbt, other: FfiPsbt) -> Result<FfiPsbt, PsbtError> {
        let other_psbt = other.opaque.lock().unwrap().clone();
        let mut original_psbt = opaque.opaque.lock().unwrap().clone();
        original_psbt.combine(other_psbt)?;
        Ok(original_psbt.into())
    }

    /// The total transaction fee amount, sum of input amounts minus sum of output amounts, in Sats.
    /// If the PSBT is missing a TxOut for an input returns None.
    #[frb(sync)]
    pub fn fee_amount(&self) -> Option<u64> {
        self.opaque.lock().unwrap().fee_amount().map(|e| e.to_sat())
    }

    ///Serialize as raw binary data
    #[frb(sync)]
    pub fn serialize(&self) -> Vec<u8> {
        let psbt = self.opaque.lock().unwrap().clone();
        psbt.serialize()
    }

    /// Serialize the PSBT data structure as a String of JSON.
    #[frb(sync)]
    pub fn json_serialize(&self) -> Result<String, PsbtError> {
        let psbt = self.opaque.lock().unwrap();
        serde_json::to_string(psbt.deref()).map_err(|_| PsbtError::OtherPsbtErr)
    }
}

// A reference to a transaction output.
#[derive(Clone, Debug, PartialEq, Eq, Hash)]
pub struct OutPoint {
    /// The referenced transaction's txid.
    pub txid: String,
    /// The index of the referenced output in its transaction's vout.
    pub vout: u32,
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
#[cfg(test)]
mod tests {
    use crate::api::{bitcoin::FfiAddress, types::Network};

    #[test]
    fn test_is_valid_for_network() {
        // ====Docs tests====
        // https://docs.rs/bitcoin/0.29.2/src/bitcoin/util/address.rs.html#798-802

        let docs_address_testnet_str = "2N83imGV3gPwBzKJQvWJ7cRUY2SpUyU6A5e";
        let docs_address_testnet =
            FfiAddress::from_string(docs_address_testnet_str.to_string(), Network::Testnet)
                .unwrap();
        assert!(
            docs_address_testnet.is_valid_for_network(Network::Testnet),
            "Address should be valid for Testnet"
        );
        assert!(
            docs_address_testnet.is_valid_for_network(Network::Signet),
            "Address should be valid for Signet"
        );
        assert!(
            docs_address_testnet.is_valid_for_network(Network::Regtest),
            "Address should be valid for Regtest"
        );

        let docs_address_mainnet_str = "32iVBEu4dxkUQk9dJbZUiBiQdmypcEyJRf";
        let docs_address_mainnet =
            FfiAddress::from_string(docs_address_mainnet_str.to_string(), Network::Bitcoin)
                .unwrap();
        assert!(
            docs_address_mainnet.is_valid_for_network(Network::Bitcoin),
            "Address should be valid for Bitcoin"
        );

        // ====Bech32====

        //     | Network         | Prefix  | Address Type |
        //     |-----------------|---------|--------------|
        //     | Bitcoin Mainnet | `bc1`   | Bech32       |
        //     | Bitcoin Testnet | `tb1`   | Bech32       |
        //     | Bitcoin Signet  | `tb1`   | Bech32       |
        //     | Bitcoin Regtest | `bcrt1` | Bech32       |

        // Bech32 - Bitcoin
        // Valid for:
        // - Bitcoin
        // Not valid for:
        // - Testnet
        // - Signet
        // - Regtest
        let bitcoin_mainnet_bech32_address_str = "bc1qxhmdufsvnuaaaer4ynz88fspdsxq2h9e9cetdj";
        let bitcoin_mainnet_bech32_address = FfiAddress::from_string(
            bitcoin_mainnet_bech32_address_str.to_string(),
            Network::Bitcoin,
        )
        .unwrap();
        assert!(
            bitcoin_mainnet_bech32_address.is_valid_for_network(Network::Bitcoin),
            "Address should be valid for Bitcoin"
        );
        assert!(
            !bitcoin_mainnet_bech32_address.is_valid_for_network(Network::Testnet),
            "Address should not be valid for Testnet"
        );
        assert!(
            !bitcoin_mainnet_bech32_address.is_valid_for_network(Network::Signet),
            "Address should not be valid for Signet"
        );
        assert!(
            !bitcoin_mainnet_bech32_address.is_valid_for_network(Network::Regtest),
            "Address should not be valid for Regtest"
        );

        // Bech32 - Testnet
        // Valid for:
        // - Testnet
        // - Regtest
        // Not valid for:
        // - Bitcoin
        // - Regtest
        let bitcoin_testnet_bech32_address_str =
            "tb1p4nel7wkc34raczk8c4jwk5cf9d47u2284rxn98rsjrs4w3p2sheqvjmfdh";
        let bitcoin_testnet_bech32_address = FfiAddress::from_string(
            bitcoin_testnet_bech32_address_str.to_string(),
            Network::Testnet,
        )
        .unwrap();
        assert!(
            !bitcoin_testnet_bech32_address.is_valid_for_network(Network::Bitcoin),
            "Address should not be valid for Bitcoin"
        );
        assert!(
            bitcoin_testnet_bech32_address.is_valid_for_network(Network::Testnet),
            "Address should be valid for Testnet"
        );
        assert!(
            bitcoin_testnet_bech32_address.is_valid_for_network(Network::Signet),
            "Address should be valid for Signet"
        );
        assert!(
            !bitcoin_testnet_bech32_address.is_valid_for_network(Network::Regtest),
            "Address should not not be valid for Regtest"
        );

        // Bech32 - Signet
        // Valid for:
        // - Signet
        // - Testnet
        // Not valid for:
        // - Bitcoin
        // - Regtest
        let bitcoin_signet_bech32_address_str =
            "tb1pwzv7fv35yl7ypwj8w7al2t8apd6yf4568cs772qjwper74xqc99sk8x7tk";
        let bitcoin_signet_bech32_address = FfiAddress::from_string(
            bitcoin_signet_bech32_address_str.to_string(),
            Network::Signet,
        )
        .unwrap();
        assert!(
            !bitcoin_signet_bech32_address.is_valid_for_network(Network::Bitcoin),
            "Address should not be valid for Bitcoin"
        );
        assert!(
            bitcoin_signet_bech32_address.is_valid_for_network(Network::Testnet),
            "Address should be valid for Testnet"
        );
        assert!(
            bitcoin_signet_bech32_address.is_valid_for_network(Network::Signet),
            "Address should be valid for Signet"
        );
        assert!(
            !bitcoin_signet_bech32_address.is_valid_for_network(Network::Regtest),
            "Address should not not be valid for Regtest"
        );

        // Bech32 - Regtest
        // Valid for:
        // - Regtest
        // Not valid for:
        // - Bitcoin
        // - Testnet
        // - Signet
        let bitcoin_regtest_bech32_address_str = "bcrt1q39c0vrwpgfjkhasu5mfke9wnym45nydfwaeems";
        let bitcoin_regtest_bech32_address = FfiAddress::from_string(
            bitcoin_regtest_bech32_address_str.to_string(),
            Network::Regtest,
        )
        .unwrap();
        assert!(
            !bitcoin_regtest_bech32_address.is_valid_for_network(Network::Bitcoin),
            "Address should not be valid for Bitcoin"
        );
        assert!(
            !bitcoin_regtest_bech32_address.is_valid_for_network(Network::Testnet),
            "Address should not be valid for Testnet"
        );
        assert!(
            !bitcoin_regtest_bech32_address.is_valid_for_network(Network::Signet),
            "Address should not be valid for Signet"
        );
        assert!(
            bitcoin_regtest_bech32_address.is_valid_for_network(Network::Regtest),
            "Address should be valid for Regtest"
        );

        // ====P2PKH====

        //     | Network                            | Prefix for P2PKH | Prefix for P2SH |
        //     |------------------------------------|------------------|-----------------|
        //     | Bitcoin Mainnet                    | `1`              | `3`             |
        //     | Bitcoin Testnet, Regtest, Signet   | `m` or `n`       | `2`             |

        // P2PKH - Bitcoin
        // Valid for:
        // - Bitcoin
        // Not valid for:
        // - Testnet
        // - Regtest
        let bitcoin_mainnet_p2pkh_address_str = "1FfmbHfnpaZjKFvyi1okTjJJusN455paPH";
        let bitcoin_mainnet_p2pkh_address = FfiAddress::from_string(
            bitcoin_mainnet_p2pkh_address_str.to_string(),
            Network::Bitcoin,
        )
        .unwrap();
        assert!(
            bitcoin_mainnet_p2pkh_address.is_valid_for_network(Network::Bitcoin),
            "Address should be valid for Bitcoin"
        );
        assert!(
            !bitcoin_mainnet_p2pkh_address.is_valid_for_network(Network::Testnet),
            "Address should not be valid for Testnet"
        );
        assert!(
            !bitcoin_mainnet_p2pkh_address.is_valid_for_network(Network::Regtest),
            "Address should not be valid for Regtest"
        );

        // P2PKH - Testnet
        // Valid for:
        // - Testnet
        // - Regtest
        // Not valid for:
        // - Bitcoin
        let bitcoin_testnet_p2pkh_address_str = "mucFNhKMYoBQYUAEsrFVscQ1YaFQPekBpg";
        let bitcoin_testnet_p2pkh_address = FfiAddress::from_string(
            bitcoin_testnet_p2pkh_address_str.to_string(),
            Network::Testnet,
        )
        .unwrap();
        assert!(
            !bitcoin_testnet_p2pkh_address.is_valid_for_network(Network::Bitcoin),
            "Address should not be valid for Bitcoin"
        );
        assert!(
            bitcoin_testnet_p2pkh_address.is_valid_for_network(Network::Testnet),
            "Address should be valid for Testnet"
        );
        assert!(
            bitcoin_testnet_p2pkh_address.is_valid_for_network(Network::Regtest),
            "Address should be valid for Regtest"
        );

        // P2PKH - Regtest
        // Valid for:
        // - Testnet
        // - Regtest
        // Not valid for:
        // - Bitcoin
        let bitcoin_regtest_p2pkh_address_str = "msiGFK1PjCk8E6FXeoGkQPTscmcpyBdkgS";
        let bitcoin_regtest_p2pkh_address = FfiAddress::from_string(
            bitcoin_regtest_p2pkh_address_str.to_string(),
            Network::Regtest,
        )
        .unwrap();
        assert!(
            !bitcoin_regtest_p2pkh_address.is_valid_for_network(Network::Bitcoin),
            "Address should not be valid for Bitcoin"
        );
        assert!(
            bitcoin_regtest_p2pkh_address.is_valid_for_network(Network::Testnet),
            "Address should be valid for Testnet"
        );
        assert!(
            bitcoin_regtest_p2pkh_address.is_valid_for_network(Network::Regtest),
            "Address should be valid for Regtest"
        );

        // ====P2SH====

        //     | Network                            | Prefix for P2PKH | Prefix for P2SH |
        //     |------------------------------------|------------------|-----------------|
        //     | Bitcoin Mainnet                    | `1`              | `3`             |
        //     | Bitcoin Testnet, Regtest, Signet   | `m` or `n`       | `2`             |

        // P2SH - Bitcoin
        // Valid for:
        // - Bitcoin
        // Not valid for:
        // - Testnet
        // - Regtest
        let bitcoin_mainnet_p2sh_address_str = "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy";
        let bitcoin_mainnet_p2sh_address = FfiAddress::from_string(
            bitcoin_mainnet_p2sh_address_str.to_string(),
            Network::Bitcoin,
        )
        .unwrap();
        assert!(
            bitcoin_mainnet_p2sh_address.is_valid_for_network(Network::Bitcoin),
            "Address should be valid for Bitcoin"
        );
        assert!(
            !bitcoin_mainnet_p2sh_address.is_valid_for_network(Network::Testnet),
            "Address should not be valid for Testnet"
        );
        assert!(
            !bitcoin_mainnet_p2sh_address.is_valid_for_network(Network::Regtest),
            "Address should not be valid for Regtest"
        );

        // P2SH - Testnet
        // Valid for:
        // - Testnet
        // - Regtest
        // Not valid for:
        // - Bitcoin
        let bitcoin_testnet_p2sh_address_str = "2NFUBBRcTJbYc1D4HSCbJhKZp6YCV4PQFpQ";
        let bitcoin_testnet_p2sh_address = FfiAddress::from_string(
            bitcoin_testnet_p2sh_address_str.to_string(),
            Network::Testnet,
        )
        .unwrap();
        assert!(
            !bitcoin_testnet_p2sh_address.is_valid_for_network(Network::Bitcoin),
            "Address should not be valid for Bitcoin"
        );
        assert!(
            bitcoin_testnet_p2sh_address.is_valid_for_network(Network::Testnet),
            "Address should be valid for Testnet"
        );
        assert!(
            bitcoin_testnet_p2sh_address.is_valid_for_network(Network::Regtest),
            "Address should be valid for Regtest"
        );

        // P2SH - Regtest
        // Valid for:
        // - Testnet
        // - Regtest
        // Not valid for:
        // - Bitcoin
        let bitcoin_regtest_p2sh_address_str = "2NEb8N5B9jhPUCBchz16BB7bkJk8VCZQjf3";
        let bitcoin_regtest_p2sh_address = FfiAddress::from_string(
            bitcoin_regtest_p2sh_address_str.to_string(),
            Network::Regtest,
        )
        .unwrap();
        assert!(
            !bitcoin_regtest_p2sh_address.is_valid_for_network(Network::Bitcoin),
            "Address should not be valid for Bitcoin"
        );
        assert!(
            bitcoin_regtest_p2sh_address.is_valid_for_network(Network::Testnet),
            "Address should be valid for Testnet"
        );
        assert!(
            bitcoin_regtest_p2sh_address.is_valid_for_network(Network::Regtest),
            "Address should be valid for Regtest"
        );
    }
}
