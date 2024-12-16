use crate::api::descriptor::BdkDescriptor;
use crate::api::types::{
    AddressIndex, Balance, BdkAddress, BdkScriptBuf, BdkTransactionDetails, ChangeSpendPolicy,
    DatabaseConfig, Input, KeychainKind, LocalUtxo, Network, OutPoint, PsbtSigHashType, RbfValue,
    ScriptAmount, SignOptions,
};
use std::collections::{BTreeMap, HashMap};
use std::ops::Deref;
use std::str::FromStr;

use crate::api::blockchain::BdkBlockchain;
use crate::api::error::BdkError;
use crate::api::psbt::BdkPsbt;
use crate::frb_generated::RustOpaque;
use bdk::bitcoin::script::PushBytesBuf;
use bdk::bitcoin::{Sequence, Txid};
pub use bdk::blockchain::GetTx;

use bdk::database::ConfigurableDatabase;
use flutter_rust_bridge::frb;

use super::execute_with_lock;
use super::types::BdkPolicy;

#[derive(Debug)]
pub struct BdkWallet {
    pub ptr: RustOpaque<std::sync::Mutex<bdk::Wallet<bdk::database::AnyDatabase>>>,
}
impl BdkWallet {
    pub fn create(
        descriptor: BdkDescriptor,
        change_descriptor: Option<BdkDescriptor>,
        network: Network,
        database_config: DatabaseConfig,
    ) -> Result<Self, BdkError> {
        let database = bdk::database::AnyDatabase::from_config(&database_config.into())?;
        let descriptor: String = descriptor.to_string_private();
        let change_descriptor: Option<String> = change_descriptor.map(|d| d.to_string_private());

        let wallet = bdk::Wallet::new(
            &descriptor,
            change_descriptor.as_ref(),
            network.into(),
            database,
        )?;
        Ok(BdkWallet {
            ptr: RustOpaque::new(std::sync::Mutex::new(wallet)),
        })
    }
    /// Get the Bitcoin network the wallet is using.
    #[frb(sync)]
    pub fn network(&self) -> Result<Network, BdkError> {
        execute_with_lock(&self.ptr, |w| w.network().into())
    }
    #[frb(sync)]
    pub fn is_mine(ptr: BdkWallet, script: BdkScriptBuf) -> Result<bool, BdkError> {
        execute_with_lock(&ptr.ptr, |w| {
            w.is_mine(<BdkScriptBuf as Into<bdk::bitcoin::ScriptBuf>>::into(script).as_script())
                .map_err(|e| e.into())
        })?
    }
    /// Return a derived address using the external descriptor, see AddressIndex for available address index selection
    /// strategies. If none of the keys in the descriptor are derivable (i.e. the descriptor does not end with a * character)
    /// then the same address will always be returned for any AddressIndex.
    #[frb(sync)]
    pub fn get_address(
        ptr: BdkWallet,
        address_index: AddressIndex,
    ) -> Result<(BdkAddress, u32), BdkError> {
        execute_with_lock(&ptr.ptr, |w| {
            w.get_address(address_index.into())
                .map(|e| (e.address.into(), e.index))
                .map_err(|e| e.into())
        })?
    }
    /// Return a derived address using the internal (change) descriptor.
    ///
    /// If the wallet doesn't have an internal descriptor it will use the external descriptor.
    ///
    /// see [AddressIndex] for available address index selection strategies. If none of the keys
    /// in the descriptor are derivable (i.e. does not end with /*) then the same address will always
    /// be returned for any [AddressIndex].
    #[frb(sync)]
    pub fn get_internal_address(
        ptr: BdkWallet,
        address_index: AddressIndex,
    ) -> Result<(BdkAddress, u32), BdkError> {
        execute_with_lock(&ptr.ptr, |w| {
            w.get_internal_address(address_index.into())
                .map(|e| (e.address.into(), e.index))
                .map_err(|e| e.into())
        })?
    }
    /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
    /// on the internal database, which first needs to be Wallet.sync manually.
    #[frb(sync)]
    pub fn get_balance(&self) -> Result<Balance, BdkError> {
        execute_with_lock(&self.ptr, |w| {
            w.get_balance().map(|b| b.into()).map_err(|e| e.into())
        })?
    }
    /// Return the list of transactions made and received by the wallet. Note that this method only operate on the internal database, which first needs to be [Wallet.sync] manually.
    #[frb(sync)]
    pub fn list_transactions(
        &self,
        include_raw: bool,
    ) -> Result<Vec<BdkTransactionDetails>, BdkError> {
        execute_with_lock(&self.ptr, |wallet| {
            let mut transaction_details = vec![];

            // List transactions and convert them using try_into
            for e in wallet.list_transactions(include_raw)?.into_iter() {
                transaction_details.push(e.try_into()?);
            }

            Ok(transaction_details)
        })?
    }
    /// Return the list of unspent outputs of this wallet. Note that this method only operates on the internal database,
    /// which first needs to be Wallet.sync manually.
    #[frb(sync)]
    pub fn list_unspent(&self) -> Result<Vec<LocalUtxo>, BdkError> {
        execute_with_lock(&self.ptr, |w| {
            let unspent: Vec<bdk::LocalUtxo> = w.list_unspent()?;
            Ok(unspent.into_iter().map(LocalUtxo::from).collect())
        })?
    }
    #[frb(sync)]
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
        let mut psbt = psbt
            .ptr
            .lock()
            .map_err(|_| BdkError::Generic("Poison Error!".to_string()))?;
        execute_with_lock(&ptr.ptr, |w| {
            w.sign(
                &mut psbt,
                sign_options.map(SignOptions::into).unwrap_or_default(),
            )
            .map_err(|e| e.into())
        })?
    }
    /// Sync the internal database with the blockchain.
    pub fn sync(ptr: BdkWallet, blockchain: &BdkBlockchain) -> Result<(), BdkError> {
        execute_with_lock(&ptr.ptr, |w| {
            w.sync(blockchain.ptr.deref(), bdk::SyncOptions::default())
                .map_err(|e| e.into())
        })?
    }
    #[frb(sync)]
    ///get the corresponding PSBT Input for a LocalUtxo
    pub fn get_psbt_input(
        &self,
        utxo: LocalUtxo,
        only_witness_utxo: bool,
        sighash_type: Option<PsbtSigHashType>,
    ) -> anyhow::Result<Input, BdkError> {
        execute_with_lock(&self.ptr, |w| {
            let input = w.get_psbt_input(
                utxo.try_into()?,
                sighash_type.map(|e| e.into()),
                only_witness_utxo,
            )?;
            input.try_into()
        })?
    }
    ///Returns the descriptor used to create addresses for a particular keychain.
    #[frb(sync)]
    pub fn get_descriptor_for_keychain(
        ptr: BdkWallet,
        keychain: KeychainKind,
    ) -> anyhow::Result<BdkDescriptor, BdkError> {
        execute_with_lock(&ptr.ptr, |w| {
            let extended_descriptor = w.get_descriptor_for_keychain(keychain.into());
            BdkDescriptor::create(extended_descriptor.to_string(), w.network().into())
        })?
    }
    #[frb(sync)]
    pub fn policies(ptr: BdkWallet, keychain: KeychainKind) -> Result<Option<BdkPolicy>, BdkError> {
        execute_with_lock(&ptr.ptr, |w| {
            w.policies(keychain.into())
                .map_err(|e| e.into())
                .map(|e| e.map(|f| f.into()))
        })?
    }
}

pub fn finish_bump_fee_tx_builder(
    txid: String,
    fee_rate: f32,
    allow_shrinking: Option<BdkAddress>,
    wallet: BdkWallet,
    enable_rbf: bool,
    n_sequence: Option<u32>,
) -> anyhow::Result<(BdkPsbt, BdkTransactionDetails), BdkError> {
    let txid = Txid::from_str(txid.as_str()).map_err(|e| BdkError::PsbtParse(e.to_string()))?;
    execute_with_lock(&wallet.ptr, |w| {
        let mut tx_builder = w.build_fee_bump(txid)?;
        tx_builder.fee_rate(bdk::FeeRate::from_sat_per_vb(fee_rate));
        if let Some(allow_shrinking) = &allow_shrinking {
            let address = allow_shrinking.ptr.clone();
            let script = address.script_pubkey();
            tx_builder.allow_shrinking(script)?;
        }
        if let Some(n_sequence) = n_sequence {
            tx_builder.enable_rbf_with_sequence(Sequence(n_sequence));
        }
        if enable_rbf {
            tx_builder.enable_rbf();
        }
        return match tx_builder.finish() {
            Ok(e) => Ok((e.0.into(), BdkTransactionDetails::try_from(e.1)?)),
            Err(e) => Err(e.into()),
        };
    })?
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
    internal_policy_path: Option<HashMap<String, Vec<u32>>>,
    external_policy_path: Option<HashMap<String, Vec<u32>>>,
    data: Vec<u8>,
) -> anyhow::Result<(BdkPsbt, BdkTransactionDetails), BdkError> {
    execute_with_lock(&wallet.ptr, |w| {
        let mut tx_builder = w.build_tx();
        if let Some(path) = internal_policy_path {
            tx_builder.policy_path(
                path.into_iter()
                    .map(|(key, value)| (key, value.into_iter().map(|x| x as usize).collect()))
                    .collect::<BTreeMap<String, Vec<usize>>>(),
                bdk::KeychainKind::Internal,
            );
        }
        if let Some(path) = external_policy_path {
            tx_builder.policy_path(
                path.into_iter()
                    .map(|(key, value)| (key, value.into_iter().map(|x| x as usize).collect()))
                    .collect::<BTreeMap<String, Vec<usize>>>(),
                bdk::KeychainKind::External,
            );
        }
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
            let push_bytes = PushBytesBuf::try_from(data.clone()).map_err(|_| {
                BdkError::Generic("Failed to convert data to PushBytes".to_string())
            })?;
            tx_builder.add_data(&push_bytes);
        }

        return match tx_builder.finish() {
            Ok(e) => Ok((e.0.into(), BdkTransactionDetails::try_from(&e.1)?)),
            Err(e) => Err(e.into()),
        };
    })?
}
