use std::sync::Arc;

use crate::frb_generated::RustOpaque;

use bdk_core::spk_client::SyncItem;

// use bdk_core::spk_client::{
//     FullScanRequest,
//     // SyncItem
// };
use super::{
    bitcoin::{
        FfiAddress,
        FfiScriptBuf,
        FfiTransaction,
        OutPoint,
        TxOut,
        // OutPoint, TxOut
    },
    error::RequestBuilderError,
};
use flutter_rust_bridge::{
    // frb,
    frb,
    DartFnFuture,
};
use serde::Deserialize;
pub struct AddressInfo {
    pub index: u32,
    pub address: FfiAddress,
    pub keychain: KeychainKind,
}

impl From<bdk_wallet::AddressInfo> for AddressInfo {
    fn from(address_info: bdk_wallet::AddressInfo) -> Self {
        AddressInfo {
            index: address_info.index,
            address: address_info.address.into(),
            keychain: address_info.keychain.into(),
        }
    }
}
// pub struct PsbtSigHashType {
//     pub inner: u32,
// }
// impl From<PsbtSigHashType> for bdk::bitcoin::psbt::PsbtSighashType {
//     fn from(value: PsbtSigHashType) -> Self {
//         bdk::bitcoin::psbt::PsbtSighashType::from_u32(value.inner)
//     }
// }
/// Local Wallet's Balance
#[derive(Deserialize, Debug)]
pub struct Balance {
    // All coinbase outputs not yet matured
    pub immature: u64,
    /// Unconfirmed UTXOs generated by a wallet tx
    pub trusted_pending: u64,
    /// Unconfirmed UTXOs received from an external wallet
    pub untrusted_pending: u64,
    /// Confirmed and immediately spendable balance
    pub confirmed: u64,
    /// Get sum of trusted_pending and confirmed coins
    pub spendable: u64,
    /// Get the whole balance visible to the wallet
    pub total: u64,
}
impl From<bdk_wallet::Balance> for Balance {
    fn from(value: bdk_wallet::Balance) -> Self {
        Balance {
            immature: value.immature.to_sat(),
            trusted_pending: value.trusted_pending.to_sat(),
            untrusted_pending: value.untrusted_pending.to_sat(),
            confirmed: value.confirmed.to_sat(),
            spendable: value.trusted_spendable().to_sat(),
            total: value.total().to_sat(),
        }
    }
}
/// The address index selection strategy to use to derived an address from the wallet's external
/// descriptor.
pub enum AddressIndex {
    ///Return a new address after incrementing the current descriptor index.
    Increase,
    ///Return the address for the current descriptor index if it has not been used in a received transaction. Otherwise return a new address as with AddressIndex.New.
    ///Use with caution, if the wallet has not yet detected an address has been used it could return an already used address. This function is primarily meant for situations where the caller is untrusted; for example when deriving donation addresses on-demand for a public web page.
    LastUnused,
    /// Return the address for a specific descriptor index. Does not change the current descriptor
    /// index used by `AddressIndex` and `AddressIndex.LastUsed`.
    /// Use with caution, if an index is given that is less than the current descriptor index
    /// then the returned address may have already been used.
    Peek { index: u32 },
    /// Return the address for a specific descriptor index and reset the current descriptor index
    /// used by `AddressIndex` and `AddressIndex.LastUsed` to this value.
    /// Use with caution, if an index is given that is less than the current descriptor index
    /// then the returned address and subsequent addresses returned by calls to `AddressIndex`
    /// and `AddressIndex.LastUsed` may have already been used. Also if the index is reset to a
    /// value earlier than the Blockchain stopGap (default is 20) then a
    /// larger stopGap should be used to monitor for all possibly used addresses.
    Reset { index: u32 },
}
// impl From<AddressIndex> for bdk_core::bitcoin::address::AddressIndex {
//     fn from(x: AddressIndex) -> bdk_core::bitcoin::AddressIndex {
//         match x {
//             AddressIndex::Increase => bdk_core::bitcoin::AddressIndex::New,
//             AddressIndex::LastUnused => bdk_core::bitcoin::AddressIndex::LastUnused,
//             AddressIndex::Peek { index } => bdk_core::bitcoin::AddressIndex::Peek(index),
//             AddressIndex::Reset { index } => bdk_core::bitcoin::AddressIndex::Reset(index),
//         }
//     }
// }

#[derive(Debug)]
pub enum ChainPosition {
    Confirmed {
        confirmation_block_time: ConfirmationBlockTime,
    },
    Unconfirmed {
        timestamp: u64,
    },
}

#[derive(Debug)]
pub struct ConfirmationBlockTime {
    pub block_id: BlockId,
    pub confirmation_time: u64,
}

#[derive(Debug)]
pub struct BlockId {
    pub height: u32,
    pub hash: String,
}
pub struct FfiCanonicalTx {
    pub transaction: FfiTransaction,
    pub chain_position: ChainPosition,
}
//TODO; Replace From with TryFrom
impl
    From<
        bdk_wallet::chain::tx_graph::CanonicalTx<
            '_,
            Arc<bdk_core::bitcoin::transaction::Transaction>,
            bdk_wallet::chain::ConfirmationBlockTime,
        >,
    > for FfiCanonicalTx
{
    fn from(
        value: bdk_wallet::chain::tx_graph::CanonicalTx<
            '_,
            Arc<bdk_core::bitcoin::transaction::Transaction>,
            bdk_wallet::chain::ConfirmationBlockTime,
        >,
    ) -> Self {
        let chain_position = match value.chain_position {
            bdk_wallet::chain::ChainPosition::Confirmed(anchor) => {
                let block_id = BlockId {
                    height: anchor.block_id.height,
                    hash: anchor.block_id.hash.to_string(),
                };
                ChainPosition::Confirmed {
                    confirmation_block_time: ConfirmationBlockTime {
                        block_id,
                        confirmation_time: anchor.confirmation_time,
                    },
                }
            }
            bdk_wallet::chain::ChainPosition::Unconfirmed(timestamp) => {
                ChainPosition::Unconfirmed { timestamp }
            }
        };
        //todo; resolve unhandled unwrap()s
        FfiCanonicalTx {
            transaction: (*value.tx_node.tx).clone().try_into().unwrap(),
            chain_position,
        }
    }
}
#[allow(dead_code)]
#[derive(Clone, Debug)]
pub enum RbfValue {
    RbfDefault,
    Value(u32),
}
#[derive(Debug, Clone)]
///The cryptocurrency to act on
pub enum Network {
    ///Bitcoin’s testnet
    Testnet,
    ///Bitcoin’s regtest
    Regtest,
    ///Classic Bitcoin
    Bitcoin,
    ///Bitcoin’s signet
    Signet,
}
impl Default for Network {
    fn default() -> Self {
        Network::Testnet
    }
}
impl From<Network> for bdk_core::bitcoin::Network {
    fn from(network: Network) -> Self {
        match network {
            Network::Signet => bdk_core::bitcoin::Network::Signet,
            Network::Testnet => bdk_core::bitcoin::Network::Testnet,
            Network::Regtest => bdk_core::bitcoin::Network::Regtest,
            Network::Bitcoin => bdk_core::bitcoin::Network::Bitcoin,
        }
    }
}

impl From<bdk_core::bitcoin::Network> for Network {
    fn from(network: bdk_core::bitcoin::Network) -> Self {
        match network {
            bdk_core::bitcoin::Network::Signet => Network::Signet,
            bdk_core::bitcoin::Network::Testnet => Network::Testnet,
            bdk_core::bitcoin::Network::Regtest => Network::Regtest,
            bdk_core::bitcoin::Network::Bitcoin => Network::Bitcoin,
            _ => unreachable!(),
        }
    }
}

///Type describing entropy length (aka word count) in the mnemonic
pub enum WordCount {
    ///12 words mnemonic (128 bits entropy)
    Words12,
    ///18 words mnemonic (192 bits entropy)
    Words18,
    ///24 words mnemonic (256 bits entropy)
    Words24,
}
impl From<WordCount> for bdk_wallet::keys::bip39::WordCount {
    fn from(word_count: WordCount) -> Self {
        match word_count {
            WordCount::Words12 => bdk_wallet::keys::bip39::WordCount::Words12,
            WordCount::Words18 => bdk_wallet::keys::bip39::WordCount::Words18,
            WordCount::Words24 => bdk_wallet::keys::bip39::WordCount::Words24,
        }
    }
}

pub enum LockTime {
    Blocks(u32),
    Seconds(u32),
}
impl From<bdk_wallet::bitcoin::absolute::LockTime> for LockTime {
    fn from(value: bdk_wallet::bitcoin::absolute::LockTime) -> Self {
        match value {
            bdk_core::bitcoin::absolute::LockTime::Blocks(height) => {
                LockTime::Blocks(height.to_consensus_u32())
            }
            bdk_core::bitcoin::absolute::LockTime::Seconds(time) => {
                LockTime::Seconds(time.to_consensus_u32())
            }
        }
    }
}

#[derive(Eq, Ord, PartialEq, PartialOrd)]
///Types of keychains
pub enum KeychainKind {
    ExternalChain,
    ///Internal, usually used for change outputs
    InternalChain,
}
impl From<bdk_wallet::KeychainKind> for KeychainKind {
    fn from(e: bdk_wallet::KeychainKind) -> Self {
        match e {
            bdk_wallet::KeychainKind::External => KeychainKind::ExternalChain,
            bdk_wallet::KeychainKind::Internal => KeychainKind::InternalChain,
        }
    }
}
impl From<KeychainKind> for bdk_wallet::KeychainKind {
    fn from(kind: KeychainKind) -> Self {
        match kind {
            KeychainKind::ExternalChain => bdk_wallet::KeychainKind::External,
            KeychainKind::InternalChain => bdk_wallet::KeychainKind::Internal,
        }
    }
}

/// Adjust the behavior of our software signers and the way a transaction is finalized
#[derive(Debug, Clone, Default)]
pub struct SignOptions {
    /// Whether the signer should trust the `witness_utxo`, if the `non_witness_utxo` hasn't been
    /// provided
    ///
    /// Defaults to `false` to mitigate the "SegWit bug" which should trick the wallet into
    /// paying a fee larger than expected.
    ///
    /// Some wallets, especially if relatively old, might not provide the `non_witness_utxo` for
    /// SegWit transactions in the PSBT they generate: in those cases setting this to `true`
    /// should correctly produce a signature, at the expense of an increased trust in the creator
    /// of the PSBT.
    ///
    /// For more details see: <https://blog.trezor.io/details-of-firmware-updates-for-trezor-one-version-1-9-1-and-trezor-model-t-version-2-3-1-1eba8f60f2dd>
    pub trust_witness_utxo: bool,

    /// Whether the wallet should assume a specific height has been reached when trying to finalize
    /// a transaction
    ///
    /// The wallet will only "use" a timelock to satisfy the spending policy of an input if the
    /// timelock height has already been reached. This option allows overriding the "current height" to let the
    /// wallet use timelocks in the future to spend a coin.
    pub assume_height: Option<u32>,

    /// Whether the signer should use the `sighash_type` set in the PSBT when signing, no matter
    /// what its value is
    ///
    /// Defaults to `false` which will only allow signing using `SIGHASH_ALL`.
    pub allow_all_sighashes: bool,

    /// Whether to try finalizing the PSBT after the inputs are signed.
    ///
    /// Defaults to `true` which will try finalizing PSBT after inputs are signed.
    pub try_finalize: bool,
    //TODO; Expose tap_leaves_options.
    // Specifies which Taproot script-spend leaves we should sign for. This option is
    // ignored if we're signing a non-taproot PSBT.
    //
    // Defaults to All, i.e., the wallet will sign all the leaves it has a key for.
    // TODO pub tap_leaves_options: TapLeavesOptions,
    /// Whether we should try to sign a taproot transaction with the taproot internal key
    /// or not. This option is ignored if we're signing a non-taproot PSBT.
    ///
    /// Defaults to `true`, i.e., we always try to sign with the taproot internal key.
    pub sign_with_tap_internal_key: bool,

    /// Whether we should grind ECDSA signature to ensure signing with low r
    /// or not.
    /// Defaults to `true`, i.e., we always grind ECDSA signature to sign with low r.
    pub allow_grinding: bool,
}
impl From<SignOptions> for bdk_wallet::SignOptions {
    fn from(sign_options: SignOptions) -> Self {
        bdk_wallet::SignOptions {
            trust_witness_utxo: sign_options.trust_witness_utxo,
            assume_height: sign_options.assume_height,
            allow_all_sighashes: sign_options.allow_all_sighashes,
            try_finalize: sign_options.try_finalize,
            tap_leaves_options: Default::default(),
            sign_with_tap_internal_key: sign_options.sign_with_tap_internal_key,
            allow_grinding: sign_options.allow_grinding,
        }
    }
}

pub struct FfiFullScanRequestBuilder(
    pub  RustOpaque<
        std::sync::Mutex<
            Option<bdk_core::spk_client::FullScanRequestBuilder<bdk_wallet::KeychainKind>>,
        >,
    >,
);

impl FfiFullScanRequestBuilder {
    pub fn inspect_spks_for_all_keychains(
        &self,
        inspector: impl (Fn(KeychainKind, u32, FfiScriptBuf) -> DartFnFuture<()>)
            + Send
            + 'static
            + std::marker::Sync,
    ) -> Result<Self, RequestBuilderError> {
        let guard = self
            .0
            .lock()
            .unwrap()
            .take()
            .ok_or(RequestBuilderError::RequestAlreadyConsumed)?;

        let runtime = tokio::runtime::Runtime::new().unwrap();

        // Inspect with the async inspector function
        let full_scan_request_builder = guard.inspect(move |keychain, index, script| {
            // Run the async Dart function in a blocking way within the runtime
            runtime.block_on(inspector(keychain.into(), index, script.to_owned().into()))
        });

        Ok(FfiFullScanRequestBuilder(RustOpaque::new(
            std::sync::Mutex::new(Some(full_scan_request_builder)),
        )))
    }
    pub fn build(&self) -> Result<FfiFullScanRequest, RequestBuilderError> {
        //todo; resolve unhandled unwrap()s
        let guard = self
            .0
            .lock()
            .unwrap()
            .take()
            .ok_or(RequestBuilderError::RequestAlreadyConsumed)?;
        Ok(FfiFullScanRequest(RustOpaque::new(std::sync::Mutex::new(
            Some(guard.build()),
        ))))
    }
}
pub struct FfiSyncRequestBuilder(
    pub  RustOpaque<
        std::sync::Mutex<
            Option<bdk_core::spk_client::SyncRequestBuilder<(bdk_wallet::KeychainKind, u32)>>,
        >,
    >,
);

impl FfiSyncRequestBuilder {
    pub fn inspect_spks(
        &self,
        inspector: impl (Fn(FfiScriptBuf, SyncProgress) -> DartFnFuture<()>)
            + Send
            + 'static
            + std::marker::Sync,
    ) -> Result<Self, RequestBuilderError> {
        //todo; resolve unhandled unwrap()s
        let guard = self
            .0
            .lock()
            .unwrap()
            .take()
            .ok_or(RequestBuilderError::RequestAlreadyConsumed)?;
        let runtime = tokio::runtime::Runtime::new().unwrap();

        let sync_request_builder = guard.inspect({
            move |script, progress| {
                if let SyncItem::Spk(_, spk) = script {
                    runtime.block_on(inspector(spk.to_owned().into(), progress.into()));
                }
            }
        });
        Ok(FfiSyncRequestBuilder(RustOpaque::new(
            std::sync::Mutex::new(Some(sync_request_builder)),
        )))
    }

    pub fn build(&self) -> Result<FfiSyncRequest, RequestBuilderError> {
        //todo; resolve unhandled unwrap()s
        let guard = self
            .0
            .lock()
            .unwrap()
            .take()
            .ok_or(RequestBuilderError::RequestAlreadyConsumed)?;
        Ok(FfiSyncRequest(RustOpaque::new(std::sync::Mutex::new(
            Some(guard.build()),
        ))))
    }
}

//Todo; remove cloning the update
pub struct FfiUpdate(pub RustOpaque<bdk_wallet::Update>);
impl From<FfiUpdate> for bdk_wallet::Update {
    fn from(value: FfiUpdate) -> Self {
        (*value.0).clone()
    }
}
pub struct SentAndReceivedValues {
    pub sent: u64,
    pub received: u64,
}
pub struct FfiFullScanRequest(
    pub  RustOpaque<
        std::sync::Mutex<Option<bdk_core::spk_client::FullScanRequest<bdk_wallet::KeychainKind>>>,
    >,
);
pub struct FfiSyncRequest(
    pub  RustOpaque<
        std::sync::Mutex<
            Option<bdk_core::spk_client::SyncRequest<(bdk_wallet::KeychainKind, u32)>>,
        >,
    >,
);
/// Policy regarding the use of change outputs when creating a transaction
#[derive(Default, Debug, Ord, PartialOrd, Eq, PartialEq, Hash, Clone, Copy)]
pub enum ChangeSpendPolicy {
    /// Use both change and non-change outputs (default)
    #[default]
    ChangeAllowed,
    /// Only use change outputs (see [`TxBuilder::only_spend_change`])
    OnlyChange,
    /// Only use non-change outputs (see [`TxBuilder::do_not_spend_change`])
    ChangeForbidden,
}
impl From<ChangeSpendPolicy> for bdk_wallet::ChangeSpendPolicy {
    fn from(value: ChangeSpendPolicy) -> Self {
        match value {
            ChangeSpendPolicy::ChangeAllowed => bdk_wallet::ChangeSpendPolicy::ChangeAllowed,
            ChangeSpendPolicy::OnlyChange => bdk_wallet::ChangeSpendPolicy::OnlyChange,
            ChangeSpendPolicy::ChangeForbidden => bdk_wallet::ChangeSpendPolicy::ChangeForbidden,
        }
    }
}

pub struct LocalOutput {
    pub outpoint: OutPoint,
    pub txout: TxOut,
    pub keychain: KeychainKind,
    pub is_spent: bool,
}

impl From<bdk_wallet::LocalOutput> for LocalOutput {
    fn from(local_utxo: bdk_wallet::LocalOutput) -> Self {
        LocalOutput {
            outpoint: OutPoint {
                txid: local_utxo.outpoint.txid.to_string(),
                vout: local_utxo.outpoint.vout,
            },
            txout: TxOut {
                value: local_utxo.txout.value.to_sat(),
                script_pubkey: FfiScriptBuf {
                    bytes: local_utxo.txout.script_pubkey.to_bytes(),
                },
            },
            keychain: local_utxo.keychain.into(),
            is_spent: local_utxo.is_spent,
        }
    }
}

/// The progress of [`SyncRequest`].
#[derive(Debug, Clone)]
pub struct SyncProgress {
    /// Script pubkeys consumed by the request.
    pub spks_consumed: u64,
    /// Script pubkeys remaining in the request.
    pub spks_remaining: u64,
    /// Txids consumed by the request.
    pub txids_consumed: u64,
    /// Txids remaining in the request.
    pub txids_remaining: u64,
    /// Outpoints consumed by the request.
    pub outpoints_consumed: u64,
    /// Outpoints remaining in the request.
    pub outpoints_remaining: u64,
}
impl From<bdk_core::spk_client::SyncProgress> for SyncProgress {
    fn from(value: bdk_core::spk_client::SyncProgress) -> Self {
        SyncProgress {
            spks_consumed: value.spks_consumed as u64,
            spks_remaining: value.spks_remaining as u64,
            txids_consumed: value.txids_consumed as u64,
            txids_remaining: value.txids_remaining as u64,
            outpoints_consumed: value.outpoints_consumed as u64,
            outpoints_remaining: value.outpoints_remaining as u64,
        }
    }
}
pub struct FfiPolicy {
    pub opaque: RustOpaque<bdk_wallet::descriptor::Policy>,
}
impl FfiPolicy {
    #[frb(sync)]
    pub fn id(&self) -> String {
        self.opaque.id.clone()
    }
}
impl From<bdk_wallet::descriptor::Policy> for FfiPolicy {
    fn from(value: bdk_wallet::descriptor::Policy) -> Self {
        FfiPolicy {
            opaque: RustOpaque::new(value),
        }
    }
}
