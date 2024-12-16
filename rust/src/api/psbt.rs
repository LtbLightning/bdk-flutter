use crate::api::error::BdkError;
use crate::api::types::{BdkTransaction, FeeRate};
use crate::frb_generated::RustOpaque;

use bdk::psbt::PsbtUtils;
use std::ops::Deref;
use std::str::FromStr;

use flutter_rust_bridge::frb;

use super::execute_with_lock;

#[derive(Debug)]
pub struct BdkPsbt {
    pub ptr: RustOpaque<std::sync::Mutex<bdk::bitcoin::psbt::PartiallySignedTransaction>>,
}

impl From<bdk::bitcoin::psbt::PartiallySignedTransaction> for BdkPsbt {
    fn from(value: bdk::bitcoin::psbt::PartiallySignedTransaction) -> Self {
        Self {
            ptr: RustOpaque::new(std::sync::Mutex::new(value)),
        }
    }
}
impl BdkPsbt {
    #[frb(sync)]
    pub fn from_str(psbt_base64: String) -> Result<BdkPsbt, BdkError> {
        let psbt: bdk::bitcoin::psbt::PartiallySignedTransaction =
            bdk::bitcoin::psbt::PartiallySignedTransaction::from_str(&psbt_base64)?;
        Ok(psbt.into())
    }
    #[frb(sync)]
    pub fn as_string(&self) -> Result<String, BdkError> {
        execute_with_lock(&self.ptr, |psbt| psbt.to_string())
    }
    ///Computes the `Txid`.
    /// Hashes the transaction excluding the segwit data (i. e. the marker, flag bytes, and the witness fields themselves).
    /// For non-segwit transactions which do not have any segwit data, this will be equal to transaction.wtxid().
    #[frb(sync)]
    pub fn txid(&self) -> Result<String, BdkError> {
        execute_with_lock(&self.ptr, |psbt| {
            psbt.to_owned().extract_tx().txid().to_string()
        })
    }
    /// Return the transaction.
    #[frb(sync)]
    pub fn extract_tx(ptr: BdkPsbt) -> Result<BdkTransaction, BdkError> {
        execute_with_lock(&ptr.ptr, |psbt| {
            let tx = psbt.to_owned().extract_tx();
            tx.try_into()
        })?
    }
    #[frb(sync)]
    /// Combines this PartiallySignedTransaction with other PSBT as described by BIP 174.
    ///
    /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
    pub fn combine(ptr: BdkPsbt, other: BdkPsbt) -> Result<BdkPsbt, BdkError> {
        let other_psbt = other
            .ptr
            .lock()
            .map_err(|_| BdkError::Generic("Poison Error!".to_string()))?
            .clone();
        let mut original_psbt = ptr
            .ptr
            .lock()
            .map_err(|_| BdkError::Generic("Poison Error!".to_string()))?;
        original_psbt.combine(other_psbt)?;
        Ok(original_psbt.to_owned().into())
    }
    /// The total transaction fee amount, sum of input amounts minus sum of output amounts, in Sats.
    /// If the PSBT is missing a TxOut for an input returns None.
    #[frb(sync)]
    pub fn fee_amount(&self) -> Result<Option<u64>, BdkError> {
        execute_with_lock(&self.ptr, |psbt| psbt.fee_amount())
    }
    /// The transaction's fee rate. This value will only be accurate if calculated AFTER the
    /// `PartiallySignedTransaction` is finalized and all witness/signature data is added to the
    /// transaction.
    /// If the PSBT is missing a TxOut for an input returns None.
    #[frb(sync)]
    pub fn fee_rate(&self) -> Result<Option<FeeRate>, BdkError> {
        execute_with_lock(&self.ptr, |psbt| psbt.fee_rate().map(|e| e.into()))
    }
    ///Serialize as raw binary data
    #[frb(sync)]
    pub fn serialize(&self) -> Result<Vec<u8>, BdkError> {
        execute_with_lock(&self.ptr, |psbt| psbt.serialize())
    }
    /// Serialize the PSBT data structure as a String of JSON.
    #[frb(sync)]
    pub fn json_serialize(&self) -> Result<String, BdkError> {
        execute_with_lock(&self.ptr, |psbt| {
            serde_json::to_string(psbt.deref()).map_err(|e| BdkError::Generic(e.to_string()))
        })?
    }
}
