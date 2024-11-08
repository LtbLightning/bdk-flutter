// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.4.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../lib.dart';
import 'bitcoin.dart';
import 'error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'types.dart';
import 'wallet.dart';

Future<FfiPsbt> finishBumpFeeTxBuilder(
        {required String txid,
        required FeeRate feeRate,
        required FfiWallet wallet,
        required bool enableRbf,
        int? nSequence}) =>
    core.instance.api.crateApiTxBuilderFinishBumpFeeTxBuilder(
        txid: txid,
        feeRate: feeRate,
        wallet: wallet,
        enableRbf: enableRbf,
        nSequence: nSequence);

Future<FfiPsbt> txBuilderFinish(
        {required FfiWallet wallet,
        required List<(FfiScriptBuf, BigInt)> recipients,
        required List<OutPoint> utxos,
        required List<OutPoint> unSpendable,
        required ChangeSpendPolicy changePolicy,
        required bool manuallySelectedOnly,
        FeeRate? feeRate,
        BigInt? feeAbsolute,
        required bool drainWallet,
        (Map<String, Uint64List>, KeychainKind)? policyPath,
        FfiScriptBuf? drainTo,
        RbfValue? rbf,
        required List<int> data}) =>
    core.instance.api.crateApiTxBuilderTxBuilderFinish(
        wallet: wallet,
        recipients: recipients,
        utxos: utxos,
        unSpendable: unSpendable,
        changePolicy: changePolicy,
        manuallySelectedOnly: manuallySelectedOnly,
        feeRate: feeRate,
        feeAbsolute: feeAbsolute,
        drainWallet: drainWallet,
        policyPath: policyPath,
        drainTo: drainTo,
        rbf: rbf,
        data: data);
