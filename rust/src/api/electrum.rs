use crate::api::bitcoin::FfiTransaction;
use crate::frb_generated::RustOpaque;
use bdk_core::spk_client::SyncRequest as BdkSyncRequest;
use bdk_core::spk_client::SyncResult as BdkSyncResult;
use bdk_wallet::KeychainKind;

use std::collections::BTreeMap;

use super::error::ElectrumError;
use super::types::FfiFullScanRequest;
use super::types::FfiSyncRequest;

// NOTE: We are keeping our naming convention where the alias of the inner type is the Rust type
//       prefixed with `Bdk`. In this case the inner type is `BdkElectrumClient`, so the alias is
//       funnily enough named `BdkBdkElectrumClient`.
pub struct FfiElectrumClient {
    pub opaque: RustOpaque<bdk_electrum::BdkElectrumClient<bdk_electrum::electrum_client::Client>>,
}

impl FfiElectrumClient {
    pub fn new(url: String) -> Result<Self, ElectrumError> {
        let inner_client: bdk_electrum::electrum_client::Client =
            bdk_electrum::electrum_client::Client::new(url.as_str())?;
        let client = bdk_electrum::BdkElectrumClient::new(inner_client);
        Ok(Self {
            opaque: RustOpaque::new(client),
        })
    }

    pub fn full_scan(
        opaque: FfiElectrumClient,
        request: FfiFullScanRequest,
        stop_gap: u64,
        batch_size: u64,
        fetch_prev_txouts: bool,
    ) -> Result<super::types::FfiUpdate, ElectrumError> {
        //todo; resolve unhandled unwrap()s
        // using option and take is not ideal but the only way to take full ownership of the request
        let request = request
            .0
            .lock()
            .unwrap()
            .take()
            .ok_or(ElectrumError::RequestAlreadyConsumed)?;

        let full_scan_result = opaque.opaque.full_scan(
            request,
            stop_gap as usize,
            batch_size as usize,
            fetch_prev_txouts,
        )?;

        let update = bdk_wallet::Update {
            last_active_indices: full_scan_result.last_active_indices,
            tx_update: full_scan_result.tx_update,
            chain: full_scan_result.chain_update,
        };

        Ok(super::types::FfiUpdate(RustOpaque::new(update)))
    }
    pub fn sync(
        opaque: FfiElectrumClient,
        request: FfiSyncRequest,
        batch_size: u64,
        fetch_prev_txouts: bool,
    ) -> Result<super::types::FfiUpdate, ElectrumError> {
        //todo; resolve unhandled unwrap()s
        // using option and take is not ideal but the only way to take full ownership of the request
        let request: BdkSyncRequest<(KeychainKind, u32)> = request
            .0
            .lock()
            .unwrap()
            .take()
            .ok_or(ElectrumError::RequestAlreadyConsumed)?;

        let sync_result: BdkSyncResult =
            opaque
                .opaque
                .sync(request, batch_size as usize, fetch_prev_txouts)?;

        let update = bdk_wallet::Update {
            last_active_indices: BTreeMap::default(),
            tx_update: sync_result.tx_update,
            chain: sync_result.chain_update,
        };

        Ok(super::types::FfiUpdate(RustOpaque::new(update)))
    }

    pub fn broadcast(
        opaque: FfiElectrumClient,
        transaction: &FfiTransaction,
    ) -> Result<String, ElectrumError> {
        opaque
            .opaque
            .transaction_broadcast(&transaction.into())
            .map_err(ElectrumError::from)
            .map(|txid| txid.to_string())
    }
}
