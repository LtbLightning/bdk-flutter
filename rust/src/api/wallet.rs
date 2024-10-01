use std::borrow::BorrowMut;
use std::str::FromStr;
use std::sync::{Mutex, MutexGuard};

use bdk_core::bitcoin::Txid;
use bdk_wallet::PersistedWallet;
use flutter_rust_bridge::frb;

use crate::api::descriptor::FfiDescriptor;

use super::bitcoin::{FeeRate, FfiPsbt, FfiScriptBuf, FfiTransaction};
use super::error::{
    CalculateFeeError, CannotConnectError, CreateWithPersistError, LoadWithPersistError,
    SignerError, SqliteError, TxidParseError,
};
use super::store::FfiConnection;
use super::types::{
    AddressInfo, Balance, FfiCanonicalTx, FfiFullScanRequestBuilder, FfiSyncRequestBuilder,
    FfiUpdate, KeychainKind, LocalOutput, Network, SignOptions,
};
use crate::frb_generated::RustOpaque;

#[derive(Debug)]
pub struct FfiWallet {
    pub opaque:
        RustOpaque<std::sync::Mutex<bdk_wallet::PersistedWallet<bdk_wallet::rusqlite::Connection>>>,
}
impl FfiWallet {
    pub fn new(
        descriptor: FfiDescriptor,
        change_descriptor: FfiDescriptor,
        network: Network,
        connection: FfiConnection,
    ) -> Result<Self, CreateWithPersistError> {
        let descriptor = descriptor.to_string_with_secret();
        let change_descriptor = change_descriptor.to_string_with_secret();
        let mut binding = connection.get_store();
        let db: &mut bdk_wallet::rusqlite::Connection = binding.borrow_mut();

        let wallet: bdk_wallet::PersistedWallet<bdk_wallet::rusqlite::Connection> =
            bdk_wallet::Wallet::create(descriptor, change_descriptor)
                .network(network.into())
                .create_wallet(db)?;
        Ok(FfiWallet {
            opaque: RustOpaque::new(std::sync::Mutex::new(wallet)),
        })
    }

    pub fn load(
        descriptor: FfiDescriptor,
        change_descriptor: FfiDescriptor,
        connection: FfiConnection,
    ) -> Result<Self, LoadWithPersistError> {
        let descriptor = descriptor.to_string_with_secret();
        let change_descriptor = change_descriptor.to_string_with_secret();
        let mut binding = connection.get_store();
        let db: &mut bdk_wallet::rusqlite::Connection = binding.borrow_mut();

        let wallet: PersistedWallet<bdk_wallet::rusqlite::Connection> = bdk_wallet::Wallet::load()
            .descriptor(bdk_wallet::KeychainKind::External, Some(descriptor))
            .descriptor(bdk_wallet::KeychainKind::Internal, Some(change_descriptor))
            .extract_keys()
            .load_wallet(db)?
            .ok_or(LoadWithPersistError::CouldNotLoad)?;

        Ok(FfiWallet {
            opaque: RustOpaque::new(std::sync::Mutex::new(wallet)),
        })
    }
    //TODO; crate a macro to handle unwrapping lock
    pub(crate) fn get_wallet(
        &self,
    ) -> MutexGuard<PersistedWallet<bdk_wallet::rusqlite::Connection>> {
        self.opaque.lock().expect("wallet")
    }
    /// Attempt to reveal the next address of the given `keychain`.
    ///
    /// This will increment the keychain's derivation index. If the keychain's descriptor doesn't
    /// contain a wildcard or every address is already revealed up to the maximum derivation
    /// index defined in [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki),
    /// then the last revealed address will be returned.
    #[frb(sync)]
    pub fn reveal_next_address(opaque: FfiWallet, keychain_kind: KeychainKind) -> AddressInfo {
        opaque
            .get_wallet()
            .reveal_next_address(keychain_kind.into())
            .into()
    }

    pub fn apply_update(&self, update: FfiUpdate) -> Result<(), CannotConnectError> {
        self.get_wallet()
            .apply_update(update)
            .map_err(CannotConnectError::from)
    }
    /// Get the Bitcoin network the wallet is using.
    #[frb(sync)]
    pub fn network(&self) -> Network {
        self.get_wallet().network().into()
    }
    /// Return whether or not a script is part of this wallet (either internal or external).
    #[frb(sync)]
    pub fn is_mine(&self, script: FfiScriptBuf) -> bool {
        self.get_wallet()
            .is_mine(<FfiScriptBuf as Into<bdk_core::bitcoin::ScriptBuf>>::into(
                script,
            ))
    }

    /// Return the balance, meaning the sum of this wallet’s unspent outputs’ values. Note that this method only operates
    /// on the internal database, which first needs to be Wallet.sync manually.
    #[frb(sync)]
    pub fn get_balance(&self) -> Balance {
        let bdk_balance = self.get_wallet().balance();
        Balance::from(bdk_balance)
    }

    pub fn sign(&self, psbt: FfiPsbt, sign_options: SignOptions) -> Result<bool, SignerError> {
        let mut psbt = psbt.opaque.lock().unwrap();
        self.get_wallet()
            .sign(&mut psbt, sign_options.into())
            .map_err(SignerError::from)
    }

    ///Iterate over the transactions in the wallet.
    #[frb(sync)]
    pub fn transactions(&self) -> Vec<FfiCanonicalTx> {
        self.get_wallet()
            .transactions()
            .map(|tx| tx.into())
            .collect()
    }

    ///Get a single transaction from the wallet as a WalletTx (if the transaction exists).
    pub fn get_tx(&self, txid: String) -> Result<Option<FfiCanonicalTx>, TxidParseError> {
        let txid =
            Txid::from_str(txid.as_str()).map_err(|_| TxidParseError::InvalidTxid { txid })?;
        Ok(self.get_wallet().get_tx(txid).map(|tx| tx.into()))
    }
    pub fn calculate_fee(&self, tx: FfiTransaction) -> Result<u64, CalculateFeeError> {
        self.get_wallet()
            .calculate_fee(&(&tx).into())
            .map(|e| e.to_sat())
            .map_err(|e| e.into())
    }

    pub fn calculate_fee_rate(&self, tx: FfiTransaction) -> Result<FeeRate, CalculateFeeError> {
        self.get_wallet()
            .calculate_fee_rate(&(&tx).into())
            .map(|bdk_fee_rate| FeeRate {
                sat_kwu: bdk_fee_rate.to_sat_per_kwu(),
            })
            .map_err(|e| e.into())
    }

    /// Return the list of unspent outputs of this wallet.
    #[frb(sync)]
    pub fn list_unspent(&self) -> Vec<LocalOutput> {
        self.get_wallet().list_unspent().map(|o| o.into()).collect()
    }
    ///List all relevant outputs (includes both spent and unspent, confirmed and unconfirmed).
    pub fn list_output(&self) -> Vec<LocalOutput> {
        self.get_wallet().list_output().map(|o| o.into()).collect()
    }
    // /// Sign a transaction with all the wallet's signers. This function returns an encapsulated bool that
    // /// has the value true if the PSBT was finalized, or false otherwise.
    // ///
    // /// The [SignOptions] can be used to tweak the behavior of the software signers, and the way
    // /// the transaction is finalized at the end. Note that it can't be guaranteed that *every*
    // /// signers will follow the options, but the "software signers" (WIF keys and `xprv`) defined
    // /// in this library will.
    // pub fn sign(
    //     opaque: FfiWallet,
    //     psbt: BdkPsbt,
    //     sign_options: Option<SignOptions>
    // ) -> Result<bool, BdkError> {
    //     let mut psbt = psbt.opaque.lock().unwrap();
    //     opaque.get_wallet()
    //         .sign(&mut psbt, sign_options.map(SignOptions::into).unwrap_or_default())
    //         .map_err(|e| e.into())
    // }
    pub fn start_full_scan(&self) -> FfiFullScanRequestBuilder {
        let builder = self.get_wallet().start_full_scan();
        FfiFullScanRequestBuilder(RustOpaque::new(Mutex::new(Some(builder))))
    }

    pub fn start_sync_with_revealed_spks(&self) -> FfiSyncRequestBuilder {
        let builder = self.get_wallet().start_sync_with_revealed_spks();
        FfiSyncRequestBuilder(RustOpaque::new(Mutex::new(Some(builder))))
    }

    // pub fn persist(&self, connection: Connection) -> Result<bool, FfiGenericError> {
    pub fn persist(&self, connection: FfiConnection) -> Result<bool, SqliteError> {
        let mut binding = connection.get_store();
        let db: &mut bdk_wallet::rusqlite::Connection = binding.borrow_mut();
        self.get_wallet()
            .persist(db)
            .map_err(|e| SqliteError::Sqlite {
                rusqlite_error: e.to_string(),
            })
    }
}
