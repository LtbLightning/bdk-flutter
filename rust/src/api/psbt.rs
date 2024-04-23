use crate::api::error::BdkError;
use crate::api::types::{BdkTransaction, FeeRate};
use crate::frb_generated::RustOpaque;
pub use bdk::bitcoin::psbt::PartiallySignedTransaction;
use bdk::psbt::PsbtUtils;
use std::ops::Deref;
use std::str::FromStr;
use std::sync::Mutex;

#[derive(Debug)]
pub struct BdkPsbt {
    pub ptr: RustOpaque<Mutex<PartiallySignedTransaction>>,
}

impl From<PartiallySignedTransaction> for BdkPsbt {
    fn from(value: PartiallySignedTransaction) -> Self {
        Self {
            ptr: RustOpaque::new(Mutex::new(value)),
        }
    }
}
impl BdkPsbt {
    pub fn from_str(psbt_base64: String) -> Result<BdkPsbt, BdkError> {
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
    pub fn extract_tx(ptr: BdkPsbt) -> Result<BdkTransaction, BdkError> {
        let tx = ptr.ptr.lock().unwrap().clone().extract_tx();
        tx.try_into()
    }

    /// Combines this PartiallySignedTransaction with other PSBT as described by BIP 174.
    ///
    /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
    pub fn combine(ptr: BdkPsbt, other: BdkPsbt) -> Result<BdkPsbt, BdkError> {
        let other_psbt = other.ptr.lock().unwrap().clone();
        let mut original_psbt = ptr.ptr.lock().unwrap().clone();
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