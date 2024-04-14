use crate::api::descriptor::BdkDescriptor;
use crate::api::types::{
    AddressIndex, Balance, BdkAddress, BdkScriptBuf, ChangeSpendPolicy,
    DatabaseConfig, Input, KeychainKind, LocalUtxo, Network, OutPoint, PsbtSigHashType, RbfValue,
    ScriptAmount, SignOptions, TransactionDetails,
};
use std::ops::Deref;
use std::str::FromStr;

use crate::api::blockchain::BdkBlockchain;
use crate::api::error::BdkError;
use crate::api::psbt::BdkPsbt;
use crate::frb_generated::RustOpaque;
use bdk::bitcoin::script::PushBytesBuf;
use bdk::bitcoin::{Sequence, Txid};
pub use bdk::database::any::AnyDatabase;
use bdk::database::ConfigurableDatabase;
pub use std::sync::Mutex;
use std::sync::MutexGuard;

#[derive(Debug)]
pub struct BdkWallet {
    pub ptr: RustOpaque<Mutex<bdk::Wallet<AnyDatabase>>>,
}
impl BdkWallet {
    pub fn new(
        descriptor: BdkDescriptor,
        change_descriptor: Option<BdkDescriptor>,
        network: Network,
        database_config: DatabaseConfig,
    ) -> Result<Self, BdkError> {
        let database = AnyDatabase::from_config(&database_config.into())?;
        let descriptor: String = descriptor.as_string_private();
        let change_descriptor: Option<String> = change_descriptor.map(|d| d.as_string_private());

        let wallet = bdk::Wallet::new(
            &descriptor,
            change_descriptor.as_ref(),
            network.into(),
            database,
        )?;
        Ok(BdkWallet {
            ptr: RustOpaque::new(Mutex::new(wallet)),
        })
    }
    fn get_wallet(&self) -> MutexGuard<bdk::Wallet<AnyDatabase>> {
        self.ptr.lock().expect("")
    }

    /// Get the Bitcoin network the wallet is using.
    pub fn network(&self) -> Network {
        self.get_wallet().network().into()
    }
    /// Return whether or not a script is part of this wallet (either internal or external).
    pub fn is_mine(&self, script: BdkScriptBuf) -> Result<bool, BdkError> {
        self.get_wallet()
            .is_mine(<BdkScriptBuf as Into<bdk::bitcoin::ScriptBuf>>::into(script).as_script())
            .map_err(|e| e.into())
    }
    /// Return a derived address using the external descriptor, see AddressIndex for available address index selection
    /// strategies. If none of the keys in the descriptor are derivable (i.e. the descriptor does not end with a * character)
    /// then the same address will always be returned for any AddressIndex.
    pub fn get_address( ptr: BdkWallet, address_index: AddressIndex) -> Result<(BdkAddress, u32), BdkError> {
        ptr.get_wallet()
            .get_address(address_index.into())
            .map(|e|  (e.address.into(), e.index))
            .map_err(|e| e.into())
    }

    /// Return a derived address using the internal (change) descriptor.
    ///
    /// If the wallet doesn't have an internal descriptor it will use the external descriptor.
    ///
    /// see [AddressIndex] for available address index selection strategies. If none of the keys
    /// in the descriptor are derivable (i.e. does not end with /*) then the same address will always
    /// be returned for any [AddressIndex].
    pub fn get_internal_address(
        ptr: BdkWallet,
        address_index: AddressIndex,
    ) -> Result<(BdkAddress, u32), BdkError> {
        ptr.get_wallet()
            .get_internal_address(address_index.into())
            .map(|e|  (e.address.into(), e.index))
            .map_err(|e| e.into())
    }

    /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
    /// on the internal database, which first needs to be Wallet.sync manually.
    pub fn get_balance(&self) -> Result<Balance, BdkError> {
        self.get_wallet()
            .get_balance()
            .map(|b| b.into())
            .map_err(|e| e.into())
    }
    /// Return the list of transactions made and received by the wallet. Note that this method only operate on the internal database, which first needs to be [Wallet.sync] manually.
    pub fn list_transactions(
        &self,
        include_raw: bool,
    ) -> Result<Vec<TransactionDetails>, BdkError> {
        let mut transaction_details = vec![];
        for e in self
            .get_wallet()
            .list_transactions(include_raw)?
            .into_iter()
        {
            transaction_details.push(e.try_into()?)
        }
        Ok(transaction_details)
    }

    /// Return the list of unspent outputs of this wallet. Note that this method only operates on the internal database,
    /// which first needs to be Wallet.sync manually.
    pub fn list_unspent(&self) -> Result<Vec<LocalUtxo>, BdkError> {
        let unspent: Vec<bdk::LocalUtxo> = self.get_wallet().list_unspent()?;
        Ok(unspent.into_iter().map(LocalUtxo::from).collect())
    }

    /// Sign a transaction with all the wallet's signers. This function returns an encapsulated bool that
    /// has the value true if the PSBT was finalized, or false otherwise.
    ///
    /// The [SignOptions] can be used to tweak the behavior of the software signers, and the way
    /// the transaction is finalized at the end. Note that it can't be guaranteed that *every*
    /// signers will follow the options, but the "software signers" (WIF keys and `xprv`) defined
    /// in this library will.
    pub fn sign(
        ptr: BdkWallet,
        psbt: BdkPsbt,
        sign_options: Option<SignOptions>,
    ) -> Result<bool, BdkError> {
        let mut psbt = psbt.ptr.lock().unwrap();
        ptr.get_wallet()
            .sign(
                &mut psbt,
                sign_options.map(SignOptions::into).unwrap_or_default(),
            )
            .map_err(|e| e.into())
    }
    /// Sync the internal database with the blockchain.
    pub fn sync(ptr: BdkWallet, blockchain: BdkBlockchain) -> Result<(), BdkError> {
        let blockchain = blockchain.get_blockchain();
        ptr.get_wallet()
            .sync(blockchain.deref(), bdk::SyncOptions::default())
            .map_err(|e| e.into())
    }
    ///get the corresponding PSBT Input for a LocalUtxo
    pub fn get_psbt_input(
        &self,
        utxo: LocalUtxo,
        only_witness_utxo: bool,
        sighash_type: Option<PsbtSigHashType>,
    ) -> anyhow::Result<Input, BdkError> {
        let input = self.get_wallet().get_psbt_input(
            utxo.try_into()?,
            sighash_type.map(|e| e.into()),
            only_witness_utxo,
        )?;
        input.try_into()
    }
    ///Returns the descriptor used to create addresses for a particular keychain.
    pub fn get_descriptor_for_keychain(
        ptr: BdkWallet,
        keychain: KeychainKind,
    ) -> anyhow::Result<BdkDescriptor, BdkError> {
        let wallet = ptr.get_wallet();
        let extended_descriptor = wallet.get_descriptor_for_keychain(keychain.into());
        BdkDescriptor::new(extended_descriptor.to_string(), wallet.network().into())
    }
}

pub fn finish_bump_fee_tx_builder(
    txid: String,
    fee_rate: f32,
    allow_shrinking: Option<BdkAddress>,
    wallet: BdkWallet,
    enable_rbf: bool,
    n_sequence: Option<u32>,
) -> anyhow::Result<(BdkPsbt, TransactionDetails), BdkError> {
    let txid = Txid::from_str(txid.as_str()).unwrap();
    let bdk_wallet = wallet.get_wallet();

    let mut tx_builder = bdk_wallet.build_fee_bump(txid)?;
    tx_builder.fee_rate(bdk::FeeRate::from_sat_per_vb(fee_rate));
    if let Some(allow_shrinking) = &allow_shrinking {
        let address = allow_shrinking.ptr.clone();
        let script = address.script_pubkey();
        tx_builder.allow_shrinking(script).unwrap();
    }
    if let Some(n_sequence) = n_sequence {
        tx_builder.enable_rbf_with_sequence(Sequence(n_sequence));
    }
    if enable_rbf {
        tx_builder.enable_rbf();
    }
    return match tx_builder.finish() {
        Ok(e) => Ok((e.0.into(), TransactionDetails::try_from(e.1)?)),
        Err(e) => Err(e.into()),
    };
}

pub fn tx_builder_finish(
    wallet: BdkWallet,
    recipients: Vec<ScriptAmount>,
    utxos: Vec<OutPoint>,
    foreign_utxo: Option<(OutPoint, Input, usize)>,
    un_spendable: Vec<OutPoint>,
    change_policy: ChangeSpendPolicy,
    manually_selected_only: bool,
    fee_rate: Option<f32>,
    fee_absolute: Option<u64>,
    drain_wallet: bool,
    drain_to: Option<BdkScriptBuf>,
    rbf: Option<RbfValue>,
    data: Vec<u8>,
) -> anyhow::Result<(BdkPsbt, TransactionDetails), BdkError> {
    let binding = wallet.get_wallet();

    let mut tx_builder = binding.build_tx();

    for e in recipients {
        tx_builder.add_recipient(e.script.into(), e.amount);
    }
    tx_builder.change_policy(change_policy.into());

    if !utxos.is_empty() {
        let bdk_utxos = utxos
            .iter()
            .map(|e| bdk::bitcoin::OutPoint::try_from(e))
            .collect::<Result<Vec<bdk::bitcoin::OutPoint>, BdkError>>()?;
        tx_builder
            .add_utxos(bdk_utxos.as_slice())
            .map_err(|e| <bdk::Error as Into<BdkError>>::into(e))?;
    }
    if !un_spendable.is_empty() {
        let bdk_unspendable = un_spendable
            .iter()
            .map(|e| bdk::bitcoin::OutPoint::try_from(e))
            .collect::<Result<Vec<bdk::bitcoin::OutPoint>, BdkError>>()?;
        tx_builder.unspendable(bdk_unspendable);
    }
    if manually_selected_only {
        tx_builder.manually_selected_only();
    }
    if let Some(sat_per_vb) = fee_rate {
        tx_builder.fee_rate(bdk::FeeRate::from_sat_per_vb(sat_per_vb));
    }
    if let Some(fee_amount) = fee_absolute {
        tx_builder.fee_absolute(fee_amount);
    }
    if drain_wallet {
        tx_builder.drain_wallet();
    }
    if let Some(script_) = drain_to {
        tx_builder.drain_to(script_.into());
    }
    if let Some(utxo) = foreign_utxo {
        let foreign_utxo: bdk::bitcoin::psbt::Input = utxo.1.try_into()?;
        tx_builder.add_foreign_utxo((&utxo.0).try_into()?, foreign_utxo, utxo.2)?;
    }
    if let Some(rbf) = &rbf {
        match rbf {
            RbfValue::RbfDefault => {
                tx_builder.enable_rbf();
            }
            RbfValue::Value(nsequence) => {
                tx_builder.enable_rbf_with_sequence(Sequence(nsequence.to_owned()));
            }
        }
    }
    if !data.is_empty() {
        let push_bytes = PushBytesBuf::try_from(data.clone())
            .map_err(|_| BdkError::Generic("Failed to convert data to PushBytes".to_string()))?;
        tx_builder.add_data(&push_bytes);
    }

    return match tx_builder.finish() {
        Ok(e) => Ok((e.0.into(), TransactionDetails::try_from(&e.1)?)),
        Err(e) => Err(e.into()),
    };
}