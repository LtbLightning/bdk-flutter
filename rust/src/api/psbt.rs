use crate::api::error::BdkError;
use crate::api::types::{FeeRate, TransactionBase};
pub use bdk::bitcoin::psbt::PartiallySignedTransaction;
use bdk::psbt::PsbtUtils;
use std::ops::Deref;
use std::str::FromStr;
use std::sync::Mutex;
use crate::frb_generated::RustOpaque;

#[derive(Debug)]
pub struct PsbtBase {
    pub ptr: RustOpaque<Mutex<PartiallySignedTransaction>>,
}

impl From<PartiallySignedTransaction> for PsbtBase {
    fn from(value: PartiallySignedTransaction) -> Self {
        Self {
            ptr: RustOpaque::new(Mutex::new(value)),
        }
    }
}
impl PsbtBase {
    pub fn from_str(psbt_base64: String) -> Result<PsbtBase, BdkError> {
        let psbt: PartiallySignedTransaction = PartiallySignedTransaction::from_str(&psbt_base64)?;
        Ok(psbt.into())
    }

    pub fn serialize(&self) -> String {
        let psbt = self.ptr.lock().unwrap().clone();
        psbt.to_string()
    }

    pub fn txid(&self) -> String {
        let tx = self.ptr.lock().unwrap().clone().extract_tx();
        let txid = tx.txid();
        txid.to_string()
    }

    /// Return the transaction.
    pub fn extract_tx(&self) -> TransactionBase {
        let tx = self.ptr.lock().unwrap().clone().extract_tx();
        tx.into()
    }

    /// Combines this PartiallySignedTransaction with other PSBT as described by BIP 174.
    ///
    /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
    pub fn combine(&self, other: PsbtBase) -> Result<PsbtBase, BdkError> {
        let other_psbt = other.ptr.lock().unwrap().clone();
        let mut original_psbt = self.ptr.lock().unwrap().clone();
        original_psbt.combine(other_psbt)?;
        Ok(original_psbt.into())
    }

    /// The total transaction fee amount, sum of input amounts minus sum of output amounts, in Sats.
    /// If the PSBT is missing a TxOut for an input returns None.
    pub fn fee_amount(&self) -> Option<u64> {
        self.ptr.lock().unwrap().fee_amount()
    }

    /// The transaction's fee rate. This value will only be accurate if calculated AFTER the
    /// `PartiallySignedTransaction` is finalized and all witness/signature data is added to the
    /// transaction.
    /// If the PSBT is missing a TxOut for an input returns None.
    pub fn fee_rate(&self) -> Option<FeeRate> {
        self.ptr.lock().unwrap().fee_rate().map(|e| e.into())
    }

    /// Serialize the PSBT data structure as a String of JSON.
    pub fn json_serialize(&self) -> String {
        let psbt = self.ptr.lock().unwrap();
        serde_json::to_string(psbt.deref()).unwrap()
    }
}
