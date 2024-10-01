use bdk_esplora::esplora_client::Builder;
use bdk_esplora::EsploraExt;
use bdk_wallet::chain::spk_client::FullScanRequest as BdkFullScanRequest;
use bdk_wallet::chain::spk_client::FullScanResult as BdkFullScanResult;
use bdk_wallet::chain::spk_client::SyncRequest as BdkSyncRequest;
use bdk_wallet::chain::spk_client::SyncResult as BdkSyncResult;
use bdk_wallet::KeychainKind;
use bdk_wallet::Update as BdkUpdate;

use std::collections::BTreeMap;

use crate::frb_generated::RustOpaque;

use super::bitcoin::FfiTransaction;
use super::error::EsploraError;
use super::types::{FfiFullScanRequest, FfiSyncRequest, FfiUpdate};

pub struct FfiEsploraClient {
    pub opaque: RustOpaque<bdk_esplora::esplora_client::BlockingClient>,
}

impl FfiEsploraClient {
    pub fn new(url: String) -> Self {
        let client = Builder::new(url.as_str()).build_blocking();
        Self {
            opaque: RustOpaque::new(client),
        }
    }

    pub fn full_scan(
        &self,
        request: FfiFullScanRequest,
        stop_gap: u64,
        parallel_requests: u64,
    ) -> Result<FfiUpdate, EsploraError> {
        // using option and take is not ideal but the only way to take full ownership of the request
        let request: BdkFullScanRequest<KeychainKind> = request
            .0
            .lock()
            .unwrap()
            .take()
            .ok_or(EsploraError::RequestAlreadyConsumed)?;

        let result: BdkFullScanResult<KeychainKind> =
            self.opaque
                .full_scan(request, stop_gap as usize, parallel_requests as usize)?;

        let update = BdkUpdate {
            last_active_indices: result.last_active_indices,
            tx_update: result.tx_update,
            chain: result.chain_update,
        };

        Ok(FfiUpdate(RustOpaque::new(update)))
    }

    pub fn sync(
        &self,
        request: FfiSyncRequest,
        parallel_requests: u64,
    ) -> Result<FfiUpdate, EsploraError> {
        // using option and take is not ideal but the only way to take full ownership of the request
        let request: BdkSyncRequest<(KeychainKind, u32)> = request
            .0
            .lock()
            .unwrap()
            .take()
            .ok_or(EsploraError::RequestAlreadyConsumed)?;

        let result: BdkSyncResult = self.opaque.sync(request, parallel_requests as usize)?;

        let update = BdkUpdate {
            last_active_indices: BTreeMap::default(),
            tx_update: result.tx_update,
            chain: result.chain_update,
        };

        Ok(FfiUpdate(RustOpaque::new(update)))
    }

    pub fn broadcast(&self, transaction: &FfiTransaction) -> Result<(), EsploraError> {
        self.opaque
            .broadcast(&transaction.into())
            .map_err(EsploraError::from)
    }
}
