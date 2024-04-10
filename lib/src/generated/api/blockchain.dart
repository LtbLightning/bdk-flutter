// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.31.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'error.dart';
import 'package:collection/collection.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
import 'types.dart';
part 'blockchain.freezed.dart';

// Rust type: RustOpaqueNom<AnyBlockchain>
@sealed
class AnyBlockchain extends RustOpaque {
  AnyBlockchain.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  AnyBlockchain.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        BdkCore.instance.api.rust_arc_increment_strong_count_AnyBlockchain,
    rustArcDecrementStrongCount:
        BdkCore.instance.api.rust_arc_decrement_strong_count_AnyBlockchain,
    rustArcDecrementStrongCountPtr:
        BdkCore.instance.api.rust_arc_decrement_strong_count_AnyBlockchainPtr,
  );
}

@freezed
sealed class Auth with _$Auth {
  const Auth._();

  /// No authentication
  const factory Auth.none() = Auth_None;

  /// Authentication with username and password.
  const factory Auth.userPass({
    /// Username
    required String username,

    /// Password
    required String password,
  }) = Auth_UserPass;

  /// Authentication with a cookie file
  const factory Auth.cookie({
    /// Cookie file
    required String file,
  }) = Auth_Cookie;
}

class BdkBlockchain {
  final AnyBlockchain ptr;

  const BdkBlockchain({
    required this.ptr,
  });

  Future<String> broadcast(
          {required BdkTransaction transaction, dynamic hint}) =>
      BdkCore.instance.api.bdkBlockchainBroadcast(
          that: this, transaction: transaction, hint: hint);

  Future<FeeRate> estimateFee({required int target, dynamic hint}) =>
      BdkCore.instance.api
          .bdkBlockchainEstimateFee(that: this, target: target, hint: hint);

  Future<String> getBlockHash({required int height, dynamic hint}) =>
      BdkCore.instance.api
          .bdkBlockchainGetBlockHash(that: this, height: height, hint: hint);

  Future<int> getHeight({dynamic hint}) =>
      BdkCore.instance.api.bdkBlockchainGetHeight(that: this, hint: hint);

  // HINT: Make it `#[frb(sync)]` to let it become the default constructor of Dart class.
  static Future<BdkBlockchain> newInstance(
          {required BlockchainConfig blockchainConfig, dynamic hint}) =>
      BdkCore.instance.api
          .bdkBlockchainNew(blockchainConfig: blockchainConfig, hint: hint);

  @override
  int get hashCode => ptr.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BdkBlockchain &&
          runtimeType == other.runtimeType &&
          ptr == other.ptr;
}

@freezed
sealed class BlockchainConfig with _$BlockchainConfig {
  const BlockchainConfig._();

  /// Electrum client
  const factory BlockchainConfig.electrum({
    required ElectrumConfig config,
  }) = BlockchainConfig_Electrum;

  /// Esplora client
  const factory BlockchainConfig.esplora({
    required EsploraConfig config,
  }) = BlockchainConfig_Esplora;

  /// Bitcoin Core RPC client
  const factory BlockchainConfig.rpc({
    required RpcConfig config,
  }) = BlockchainConfig_Rpc;
}

/// Configuration for an ElectrumBlockchain
class ElectrumConfig {
  /// URL of the Electrum server (such as ElectrumX, Esplora, BWT) may start with ssl:// or tcp:// and include a port
  /// e.g. ssl://electrum.blockstream.info:60002
  final String url;

  /// URL of the socks5 proxy server or a Tor service
  final String? socks5;

  /// Request retry count
  final int retry;

  /// Request timeout (seconds)
  final int? timeout;

  /// Stop searching addresses for transactions after finding an unused gap of this length
  final int stopGap;

  /// Validate the domain when using SSL
  final bool validateDomain;

  const ElectrumConfig({
    required this.url,
    this.socks5,
    required this.retry,
    this.timeout,
    required this.stopGap,
    required this.validateDomain,
  });

  @override
  int get hashCode =>
      url.hashCode ^
      socks5.hashCode ^
      retry.hashCode ^
      timeout.hashCode ^
      stopGap.hashCode ^
      validateDomain.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElectrumConfig &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          socks5 == other.socks5 &&
          retry == other.retry &&
          timeout == other.timeout &&
          stopGap == other.stopGap &&
          validateDomain == other.validateDomain;
}

/// Configuration for an EsploraBlockchain
class EsploraConfig {
  /// Base URL of the esplora service
  /// e.g. https://blockstream.info/api/
  final String baseUrl;

  /// Optional URL of the proxy to use to make requests to the Esplora server
  /// The string should be formatted as: <protocol>://<user>:<password>@host:<port>.
  /// Note that the format of this value and the supported protocols change slightly between the
  /// sync version of esplora (using ureq) and the async version (using reqwest). For more
  /// details check with the documentation of the two crates. Both of them are compiled with
  /// the socks feature enabled.
  /// The proxy is ignored when targeting wasm32.
  final String? proxy;

  /// Number of parallel requests sent to the esplora service (default: 4)
  final int? concurrency;

  /// Stop searching addresses for transactions after finding an unused gap of this length.
  final int stopGap;

  /// Socket timeout.
  final int? timeout;

  const EsploraConfig({
    required this.baseUrl,
    this.proxy,
    this.concurrency,
    required this.stopGap,
    this.timeout,
  });

  @override
  int get hashCode =>
      baseUrl.hashCode ^
      proxy.hashCode ^
      concurrency.hashCode ^
      stopGap.hashCode ^
      timeout.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EsploraConfig &&
          runtimeType == other.runtimeType &&
          baseUrl == other.baseUrl &&
          proxy == other.proxy &&
          concurrency == other.concurrency &&
          stopGap == other.stopGap &&
          timeout == other.timeout;
}

/// RpcBlockchain configuration options
class RpcConfig {
  /// The bitcoin node url
  final String url;

  /// The bitcoin node authentication mechanism
  final Auth auth;

  /// The network we are using (it will be checked the bitcoin node network matches this)
  final Network network;

  /// The wallet name in the bitcoin node.
  final String walletName;

  /// Sync parameters
  final RpcSyncParams? syncParams;

  const RpcConfig({
    required this.url,
    required this.auth,
    required this.network,
    required this.walletName,
    this.syncParams,
  });

  @override
  int get hashCode =>
      url.hashCode ^
      auth.hashCode ^
      network.hashCode ^
      walletName.hashCode ^
      syncParams.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RpcConfig &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          auth == other.auth &&
          network == other.network &&
          walletName == other.walletName &&
          syncParams == other.syncParams;
}

/// Sync parameters for Bitcoin Core RPC.
///
/// In general, BDK tries to sync `scriptPubKey`s cached in `Database` with
/// `scriptPubKey`s imported in the Bitcoin Core Wallet. These parameters are used for determining
/// how the `importdescriptors` RPC calls are to be made.
class RpcSyncParams {
  /// The minimum number of scripts to scan for on initial sync.
  final int startScriptCount;

  /// Time in unix seconds in which initial sync will start scanning from (0 to start from genesis).
  final int startTime;

  /// Forces every sync to use `start_time` as import timestamp.
  final bool forceStartTime;

  /// RPC poll rate (in seconds) to get state updates.
  final int pollRateSec;

  const RpcSyncParams({
    required this.startScriptCount,
    required this.startTime,
    required this.forceStartTime,
    required this.pollRateSec,
  });

  @override
  int get hashCode =>
      startScriptCount.hashCode ^
      startTime.hashCode ^
      forceStartTime.hashCode ^
      pollRateSec.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RpcSyncParams &&
          runtimeType == other.runtimeType &&
          startScriptCount == other.startScriptCount &&
          startTime == other.startTime &&
          forceStartTime == other.forceStartTime &&
          pollRateSec == other.pollRateSec;
}

class U8Array4 extends NonGrowableListView<int> {
  static const arraySize = 4;

  @internal
  Uint8List get inner => _inner;
  final Uint8List _inner;

  U8Array4(this._inner)
      : assert(_inner.length == arraySize),
        super(_inner);

  U8Array4.init() : this(Uint8List(arraySize));
}
