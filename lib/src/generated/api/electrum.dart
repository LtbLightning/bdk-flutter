// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.4.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../lib.dart';
import 'bitcoin.dart';
import 'error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'types.dart';

// Rust type: RustOpaqueNom<bdk_electrum :: BdkElectrumClient < bdk_electrum :: electrum_client :: Client >>
abstract class BdkElectrumClientClient implements RustOpaqueInterface {}

// Rust type: RustOpaqueNom<bdk_wallet :: Update>
abstract class Update implements RustOpaqueInterface {}

// Rust type: RustOpaqueNom<std :: sync :: Mutex < Option < bdk_core :: spk_client :: FullScanRequest < bdk_wallet :: KeychainKind > > >>
abstract class MutexOptionFullScanRequestKeychainKind
    implements RustOpaqueInterface {}

// Rust type: RustOpaqueNom<std :: sync :: Mutex < Option < bdk_core :: spk_client :: SyncRequest < (bdk_wallet :: KeychainKind , u32) > > >>
abstract class MutexOptionSyncRequestKeychainKindU32
    implements RustOpaqueInterface {}

class FfiElectrumClient {
  final BdkElectrumClientClient opaque;

  const FfiElectrumClient({
    required this.opaque,
  });

  static Future<String> broadcast(
          {required FfiElectrumClient opaque,
          required FfiTransaction transaction}) =>
      core.instance.api.crateApiElectrumFfiElectrumClientBroadcast(
          opaque: opaque, transaction: transaction);

  static Future<FfiUpdate> fullScan(
          {required FfiElectrumClient opaque,
          required FfiFullScanRequest request,
          required BigInt stopGap,
          required BigInt batchSize,
          required bool fetchPrevTxouts}) =>
      core.instance.api.crateApiElectrumFfiElectrumClientFullScan(
          opaque: opaque,
          request: request,
          stopGap: stopGap,
          batchSize: batchSize,
          fetchPrevTxouts: fetchPrevTxouts);

  // HINT: Make it `#[frb(sync)]` to let it become the default constructor of Dart class.
  static Future<FfiElectrumClient> newInstance({required String url}) =>
      core.instance.api.crateApiElectrumFfiElectrumClientNew(url: url);

  static Future<FfiUpdate> sync_(
          {required FfiElectrumClient opaque,
          required FfiSyncRequest request,
          required BigInt batchSize,
          required bool fetchPrevTxouts}) =>
      core.instance.api.crateApiElectrumFfiElectrumClientSync(
          opaque: opaque,
          request: request,
          batchSize: batchSize,
          fetchPrevTxouts: fetchPrevTxouts);

  @override
  int get hashCode => opaque.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiElectrumClient &&
          runtimeType == other.runtimeType &&
          opaque == other.opaque;
}
