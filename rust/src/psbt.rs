// use bdk::bitcoin::consensus::Decodable;
// use bdk::psbt::PsbtUtils;
// use bdk::{Error as BdkError, FeeRate};
// use std::borrow::Borrow;
// use std::io::Cursor;
// use std::ops::Deref;
// use std::str::FromStr;
// use std::sync::{Arc, Mutex};
//
// use crate::types::{TxIn, TxOut};
//
// #[derive(Debug)]
// pub struct PartiallySignedTransaction {
//     pub inner: Mutex<bdk::bitcoin::psbt::PartiallySignedTransaction>,
// }
//
// impl PartiallySignedTransaction {
//     pub(crate) fn new(psbt_base64: String) -> Result<Self, BdkError> {
//         let psbt: bdk::bitcoin::psbt::PartiallySignedTransaction=
//             bdk::bitcoin::psbt::PartiallySignedTransaction::from_str(psbt_base64.borrow())?;
//         Ok(PartiallySignedTransaction {
//             inner: Mutex::new(psbt),
//         })
//     }
//
//     pub(crate) fn serialize(&self) -> String {
//         let psbt = self.inner.lock().unwrap().clone();
//         psbt.to_string()
//     }
//
//     pub(crate) fn txid(&self) -> String {
//         let tx = self.inner.lock().unwrap().clone().extract_tx();
//         let txid = tx.txid();
//         txid.to_hex()
//     }
//
//     /// Return the transaction.
//     pub(crate) fn extract_tx(&self) -> Transaction {
//         let tx = self.inner.lock().unwrap().clone().extract_tx();
//         Transaction { inner: tx }
//     }
//
//     /// Combines this PartiallySignedTransaction with other PSBT as described by BIP 174.
//     ///
//     /// In accordance with BIP 174 this function is commutative i.e., `A.combine(B) == B.combine(A)`
//     pub(crate) fn combine(
//         &self,
//         other: Arc<PartiallySignedTransaction>,
//     ) -> Result<Arc<PartiallySignedTransaction>, BdkError> {
//         let other_psbt = other.inner.lock().unwrap().clone();
//         let mut original_psbt = self.inner.lock().unwrap().clone();
//
//         original_psbt.combine(other_psbt)?;
//         Ok(Arc::new(PartiallySignedTransaction {
//             inner: Mutex::new(original_psbt),
//         }))
//     }
//
//     /// The total transaction fee amount, sum of input amounts minus sum of output amounts, in Sats.
//     /// If the PSBT is missing a TxOut for an input returns None.
//     pub(crate) fn fee_amount(&self) -> Option<u64> {
//         self.inner.lock().unwrap().fee_amount()
//     }
//
//     /// The transaction's fee rate. This value will only be accurate if calculated AFTER the
//     /// `PartiallySignedTransaction` is finalized and all witness/signature data is added to the
//     /// transaction.
//     /// If the PSBT is missing a TxOut for an input returns None.
//     pub(crate) fn fee_rate(&self) -> Option<Arc<FeeRate>> {
//         self.inner.lock().unwrap().fee_rate().map(Arc::new)
//     }
//
//     /// Serialize the PSBT data structure as a String of JSON.
//     pub(crate) fn json_serialize(&self) -> String {
//         let psbt = self.inner.lock().unwrap();
//         serde_json::to_string(psbt.deref()).unwrap()
//     }
// }
//
// #[derive(Debug)]
// pub struct Transaction {
//     pub(crate) inner: bdk::bitcoin::Transaction,
// }
//
// impl From<String> for Transaction {
//     fn from(tx: String) -> Self {
//         let tx_: bdk::bitcoin::Transaction = serde_json::from_str(&tx).expect("Invalid Transaction");
//         Transaction { inner: tx_ }
//     }
// }
// impl From<Transaction> for String {
//     fn from(tx: Transaction) -> Self {
//         match serde_json::to_string(&tx.inner) {
//             Ok(e) => e,
//             Err(e) => panic!("Unable to deserialize the Tranaction {:?}", e),
//         }
//     }
// }
//
// impl Transaction {
//     pub fn new(transaction_bytes: Vec<u8>) -> Result<Self, BdkError> {
//         let mut decoder = Cursor::new(transaction_bytes);
//         let tx: bdk::bitcoin::Transaction = bdk::bitcoin::Transaction::consensus_decode(&mut decoder)?;
//         Ok(Transaction { inner: tx })
//     }
//     pub fn txid(&self) -> String {
//         self.inner.txid().to_string()
//     }
//
//     pub fn weight(&self) -> u64 {
//         self.inner.weight() as u64
//     }
//
//     pub fn size(&self) -> u64 {
//         self.inner.size() as u64
//     }
//
//     pub fn vsize(&self) -> u64 {
//         self.inner.vsize() as u64
//     }
//
//
//
//     pub fn is_coin_base(&self) -> bool {
//         self.inner.is_coin_base()
//     }
//
//     pub fn is_explicitly_rbf(&self) -> bool {
//         self.inner.is_explicitly_rbf()
//     }
//
//     pub fn is_lock_time_enabled(&self) -> bool {
//         self.inner.is_lock_time_enabled()
//     }
//
//     pub fn version(&self) -> i32 {
//         self.inner.version.clone()
//     }
//
//     pub fn lock_time(&self) -> u32 {
//         self.inner.lock_time.0.clone()
//     }
//     pub fn input(&self) -> Vec<TxIn> {
//         self.inner.input.iter().map(|x| x.into()).collect()
//     }
//
//     pub fn output(&self) -> Vec<TxOut> {
//         self.inner.output.iter().map(|x| x.into()).collect()
//     }
// }
