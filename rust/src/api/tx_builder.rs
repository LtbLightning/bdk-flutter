use std::str::FromStr;

use bdk_core::bitcoin::{script::PushBytesBuf, Amount, Sequence, Txid};

use super::{
    bitcoin::{FeeRate, FfiPsbt, FfiScriptBuf, OutPoint},
    error::{CreateTxError, TxidParseError},
    types::{ChangeSpendPolicy, RbfValue},
    wallet::FfiWallet,
};

pub fn finish_bump_fee_tx_builder(
    txid: String,
    fee_rate: FeeRate,
    wallet: FfiWallet,
    enable_rbf: bool,
    n_sequence: Option<u32>,
) -> anyhow::Result<FfiPsbt, CreateTxError> {
    let txid = Txid::from_str(txid.as_str()).map_err(|e| CreateTxError::Generic {
        error_message: e.to_string(),
    })?;
    //todo; resolve unhandled unwrap()s
    let mut bdk_wallet = wallet.opaque.lock().unwrap();

    let mut tx_builder = bdk_wallet.build_fee_bump(txid)?;
    tx_builder.fee_rate(fee_rate.into());
    if let Some(n_sequence) = n_sequence {
        tx_builder.enable_rbf_with_sequence(Sequence(n_sequence));
    }
    if enable_rbf {
        tx_builder.enable_rbf();
    }
    return match tx_builder.finish() {
        Ok(e) => Ok(e.into()),
        Err(e) => Err(e.into()),
    };
}

pub fn tx_builder_finish(
    wallet: FfiWallet,
    recipients: Vec<(FfiScriptBuf, u64)>,
    utxos: Vec<OutPoint>,
    un_spendable: Vec<OutPoint>,
    change_policy: ChangeSpendPolicy,
    manually_selected_only: bool,
    fee_rate: Option<FeeRate>,
    fee_absolute: Option<u64>,
    drain_wallet: bool,
    drain_to: Option<FfiScriptBuf>,
    rbf: Option<RbfValue>,
    data: Vec<u8>,
) -> anyhow::Result<FfiPsbt, CreateTxError> {
    //todo; resolve unhandled unwrap()s
    let mut binding = wallet.opaque.lock().unwrap();

    let mut tx_builder = binding.build_tx();

    for e in recipients {
        tx_builder.add_recipient(e.0.into(), Amount::from_sat(e.1));
    }
    tx_builder.change_policy(change_policy.into());

    if !utxos.is_empty() {
        let bdk_utxos = utxos
            .iter()
            .map(|e| {
                <&OutPoint as TryInto<bdk_core::bitcoin::OutPoint>>::try_into(e).map_err(
                    |e: TxidParseError| CreateTxError::Generic {
                        error_message: e.to_string(),
                    },
                )
            })
            .filter_map(Result::ok)
            .collect::<Vec<bdk_core::bitcoin::OutPoint>>();
        tx_builder
            .add_utxos(bdk_utxos.as_slice())
            .map_err(CreateTxError::from)?;
    }
    if !un_spendable.is_empty() {
        let bdk_unspendable = utxos
            .iter()
            .map(|e| {
                <&OutPoint as TryInto<bdk_core::bitcoin::OutPoint>>::try_into(e).map_err(
                    |e: TxidParseError| CreateTxError::Generic {
                        error_message: e.to_string(),
                    },
                )
            })
            .filter_map(Result::ok)
            .collect::<Vec<bdk_core::bitcoin::OutPoint>>();
        tx_builder.unspendable(bdk_unspendable);
    }
    if manually_selected_only {
        tx_builder.manually_selected_only();
    }
    if let Some(sat_per_vb) = fee_rate {
        tx_builder.fee_rate(sat_per_vb.into());
    }
    if let Some(fee_amount) = fee_absolute {
        tx_builder.fee_absolute(Amount::from_sat(fee_amount));
    }
    if drain_wallet {
        tx_builder.drain_wallet();
    }
    if let Some(script_) = drain_to {
        tx_builder.drain_to(script_.into());
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
        let push_bytes =
            PushBytesBuf::try_from(data.clone()).map_err(|_| CreateTxError::Generic {
                error_message: "Failed to convert data to PushBytes".to_string(),
            })?;
        tx_builder.add_data(&push_bytes);
    }

    return match tx_builder.finish() {
        Ok(e) => Ok(e.into()),
        Err(e) => Err(e.into()),
    };
}
