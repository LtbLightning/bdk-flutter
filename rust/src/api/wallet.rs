use crate::api::descriptor::DescriptorBase;
use crate::api::types::{
    AddressIndex, AddressInfo, Balance, DatabaseConfig, LocalUtxo, Network, ScriptBufBase,
    TransactionDetails,
};
use crate::util::error::BdkError;
pub use bdk::database::any::AnyDatabase;
use bdk::database::ConfigurableDatabase;
pub use std::sync::Mutex;
use std::sync::MutexGuard;

/// A Bitcoin wallet.
/// The Wallet acts as a way of coherently interfacing with output descriptors and related transactions. Its main components are:
///     1. Output descriptors from which it can derive addresses.
///     2. A Database where it tracks transactions and utxos related to the descriptors.
///     3. Signers that can contribute signatures to addresses instantiated from the descriptors.
#[derive(Debug)]
pub struct WalletBase {
    pub ptr: Mutex<bdk::Wallet<AnyDatabase>>,
}
impl WalletBase {
    pub fn new(
        descriptor: DescriptorBase,
        change_descriptor: Option<DescriptorBase>,
        network: Network,
        database_config: DatabaseConfig,
    ) -> Result<Self, BdkError> {
        let database = AnyDatabase::from_config(&database_config.into())?;
        let descriptor: String = descriptor.as_string_private();
        let change_descriptor: Option<String> = change_descriptor.map(|d| d.as_string_private());

        let wallet = Mutex::new(bdk::Wallet::new(
            &descriptor,
            change_descriptor.as_ref(),
            network.into(),
            database,
        )?);
        Ok(WalletBase { ptr: wallet })
    }
    pub(crate) fn get_wallet(&self) -> MutexGuard<bdk::Wallet<AnyDatabase>> {
        self.ptr.lock().expect("wallet")
    }

    /// Get the Bitcoin network the wallet is using.
    pub(crate) fn network(&self) -> Network {
        self.get_wallet().network().into()
    }
    /// Return whether or not a script is part of this wallet (either internal or external).
    pub(crate) fn is_mine(&self, script: ScriptBufBase) -> Result<bool, BdkError> {
        self.get_wallet()
            .is_mine(<ScriptBufBase as Into<bdk::bitcoin::ScriptBuf>>::into(script).as_script())
            .map_err(|e| e.into())
    }
    /// Return a derived address using the external descriptor, see AddressIndex for available address index selection
    /// strategies. If none of the keys in the descriptor are derivable (i.e. the descriptor does not end with a * character)
    /// then the same address will always be returned for any AddressIndex.
    pub(crate) fn get_address(&self, address_index: AddressIndex) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_address(address_index.into())
            .map(AddressInfo::from)
            .map_err(|e| e.into())
    }

    /// Return a derived address using the internal (change) descriptor.
    ///
    /// If the wallet doesn't have an internal descriptor it will use the external descriptor.
    ///
    /// see [`AddressIndex`] for available address index selection strategies. If none of the keys
    /// in the descriptor are derivable (i.e. does not end with /*) then the same address will always
    /// be returned for any [`AddressIndex`].
    pub(crate) fn get_internal_address(
        &self,
        address_index: AddressIndex,
    ) -> Result<AddressInfo, BdkError> {
        self.get_wallet()
            .get_internal_address(address_index.into())
            .map(|e| e.into())
            .map_err(|e| e.into())
    }

    /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
    /// on the internal database, which first needs to be Wallet.sync manually.
    pub(crate) fn get_balance(&self) -> Result<Balance, BdkError> {
        self.get_wallet()
            .get_balance()
            .map(|b| b.into())
            .map_err(|e| e.into())
    }
    /// Return the list of transactions made and received by the wallet. Note that this method only operate on the internal database, which first needs to be [Wallet.sync] manually.
    pub(crate) fn list_transactions(
        &self,
        include_raw: bool,
    ) -> Result<Vec<TransactionDetails>, BdkError> {
        let transaction_details = self.get_wallet().list_transactions(include_raw)?;
        Ok(transaction_details
            .into_iter()
            .map(TransactionDetails::from)
            .collect())
    }

    /// Return the list of unspent outputs of this wallet. Note that this method only operates on the internal database,
    /// which first needs to be Wallet.sync manually.
    pub(crate) fn list_unspent(&self) -> Result<Vec<LocalUtxo>, BdkError> {
        let unspents: Vec<bdk::LocalUtxo> = self.get_wallet().list_unspent()?;
        Ok(unspents.into_iter().map(LocalUtxo::from).collect())
    }
}
