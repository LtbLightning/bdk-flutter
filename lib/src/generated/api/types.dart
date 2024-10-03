// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.4.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../lib.dart';
import 'bitcoin.dart';
import 'electrum.dart';
import 'error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'types.freezed.dart';

// These types are ignored because they are not used by any `pub` functions: `AddressIndex`, `SentAndReceivedValues`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `assert_receiver_is_total_eq`, `assert_receiver_is_total_eq`, `clone`, `clone`, `clone`, `clone`, `cmp`, `cmp`, `eq`, `eq`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `hash`, `partial_cmp`, `partial_cmp`

// Rust type: RustOpaqueNom<std :: sync :: Mutex < Option < bdk_core :: spk_client :: FullScanRequestBuilder < bdk_wallet :: KeychainKind > > >>
abstract class MutexOptionFullScanRequestBuilderKeychainKind
    implements RustOpaqueInterface {}

// Rust type: RustOpaqueNom<std :: sync :: Mutex < Option < bdk_core :: spk_client :: SyncRequestBuilder < (bdk_wallet :: KeychainKind , u32) > > >>
abstract class MutexOptionSyncRequestBuilderKeychainKindU32
    implements RustOpaqueInterface {}

class AddressInfo {
  final int index;
  final FfiAddress address;
  final KeychainKind keychain;

  const AddressInfo({
    required this.index,
    required this.address,
    required this.keychain,
  });

  @override
  int get hashCode => index.hashCode ^ address.hashCode ^ keychain.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressInfo &&
          runtimeType == other.runtimeType &&
          index == other.index &&
          address == other.address &&
          keychain == other.keychain;
}

/// Local Wallet's Balance
class Balance {
  final BigInt immature;

  /// Unconfirmed UTXOs generated by a wallet tx
  final BigInt trustedPending;

  /// Unconfirmed UTXOs received from an external wallet
  final BigInt untrustedPending;

  /// Confirmed and immediately spendable balance
  final BigInt confirmed;

  /// Get sum of trusted_pending and confirmed coins
  final BigInt spendable;

  /// Get the whole balance visible to the wallet
  final BigInt total;

  const Balance({
    required this.immature,
    required this.trustedPending,
    required this.untrustedPending,
    required this.confirmed,
    required this.spendable,
    required this.total,
  });

  @override
  int get hashCode =>
      immature.hashCode ^
      trustedPending.hashCode ^
      untrustedPending.hashCode ^
      confirmed.hashCode ^
      spendable.hashCode ^
      total.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Balance &&
          runtimeType == other.runtimeType &&
          immature == other.immature &&
          trustedPending == other.trustedPending &&
          untrustedPending == other.untrustedPending &&
          confirmed == other.confirmed &&
          spendable == other.spendable &&
          total == other.total;
}

class BlockId {
  final int height;
  final String hash;

  const BlockId({
    required this.height,
    required this.hash,
  });

  @override
  int get hashCode => height.hashCode ^ hash.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockId &&
          runtimeType == other.runtimeType &&
          height == other.height &&
          hash == other.hash;
}

class CanonicalTx {
  final FfiTransaction transaction;
  final ChainPosition chainPosition;

  const CanonicalTx({
    required this.transaction,
    required this.chainPosition,
  });

  @override
  int get hashCode => transaction.hashCode ^ chainPosition.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CanonicalTx &&
          runtimeType == other.runtimeType &&
          transaction == other.transaction &&
          chainPosition == other.chainPosition;
}

@freezed
sealed class ChainPosition with _$ChainPosition {
  const ChainPosition._();

  const factory ChainPosition.confirmed({
    required ConfirmationBlockTime confirmationBlockTime,
  }) = ChainPosition_Confirmed;
  const factory ChainPosition.unconfirmed({
    required BigInt timestamp,
  }) = ChainPosition_Unconfirmed;
}

/// Policy regarding the use of change outputs when creating a transaction
enum ChangeSpendPolicy {
  /// Use both change and non-change outputs (default)
  changeAllowed,

  /// Only use change outputs (see [`TxBuilder::only_spend_change`])
  onlyChange,

  /// Only use non-change outputs (see [`TxBuilder::do_not_spend_change`])
  changeForbidden,
  ;

  static Future<ChangeSpendPolicy> default_() =>
      core.instance.api.crateApiTypesChangeSpendPolicyDefault();
}

class ConfirmationBlockTime {
  final BlockId blockId;
  final BigInt confirmationTime;

  const ConfirmationBlockTime({
    required this.blockId,
    required this.confirmationTime,
  });

  @override
  int get hashCode => blockId.hashCode ^ confirmationTime.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfirmationBlockTime &&
          runtimeType == other.runtimeType &&
          blockId == other.blockId &&
          confirmationTime == other.confirmationTime;
}

class FfiFullScanRequest {
  final MutexOptionFullScanRequestKeychainKind field0;

  const FfiFullScanRequest({
    required this.field0,
  });

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiFullScanRequest &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiFullScanRequestBuilder {
  final MutexOptionFullScanRequestBuilderKeychainKind field0;

  const FfiFullScanRequestBuilder({
    required this.field0,
  });

  Future<FfiFullScanRequest> build() =>
      core.instance.api.crateApiTypesFfiFullScanRequestBuilderBuild(
        that: this,
      );

  Future<FfiFullScanRequestBuilder> inspectSpksForAllKeychains(
          {required FutureOr<void> Function(KeychainKind, int, FfiScriptBuf)
              inspector}) =>
      core.instance.api
          .crateApiTypesFfiFullScanRequestBuilderInspectSpksForAllKeychains(
              that: this, inspector: inspector);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiFullScanRequestBuilder &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiSyncRequest {
  final MutexOptionSyncRequestKeychainKindU32 field0;

  const FfiSyncRequest({
    required this.field0,
  });

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiSyncRequest &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiSyncRequestBuilder {
  final MutexOptionSyncRequestBuilderKeychainKindU32 field0;

  const FfiSyncRequestBuilder({
    required this.field0,
  });

  Future<FfiSyncRequest> build() =>
      core.instance.api.crateApiTypesFfiSyncRequestBuilderBuild(
        that: this,
      );

  Future<FfiSyncRequestBuilder> inspectSpks(
          {required FutureOr<void> Function(FfiScriptBuf, BigInt) inspector}) =>
      core.instance.api.crateApiTypesFfiSyncRequestBuilderInspectSpks(
          that: this, inspector: inspector);

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiSyncRequestBuilder &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class FfiUpdate {
  final Update field0;

  const FfiUpdate({
    required this.field0,
  });

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FfiUpdate &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

///Types of keychains
enum KeychainKind {
  externalChain,

  ///Internal, usually used for change outputs
  internalChain,
  ;
}

class LocalOutput {
  final OutPoint outpoint;
  final TxOut txout;
  final KeychainKind keychain;
  final bool isSpent;

  const LocalOutput({
    required this.outpoint,
    required this.txout,
    required this.keychain,
    required this.isSpent,
  });

  @override
  int get hashCode =>
      outpoint.hashCode ^ txout.hashCode ^ keychain.hashCode ^ isSpent.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalOutput &&
          runtimeType == other.runtimeType &&
          outpoint == other.outpoint &&
          txout == other.txout &&
          keychain == other.keychain &&
          isSpent == other.isSpent;
}

@freezed
sealed class LockTime with _$LockTime {
  const LockTime._();

  const factory LockTime.blocks(
    int field0,
  ) = LockTime_Blocks;
  const factory LockTime.seconds(
    int field0,
  ) = LockTime_Seconds;
}

///The cryptocurrency to act on
enum Network {
  ///Bitcoin’s testnet
  testnet,

  ///Bitcoin’s regtest
  regtest,

  ///Classic Bitcoin
  bitcoin,

  ///Bitcoin’s signet
  signet,
  ;

  static Future<Network> default_() =>
      core.instance.api.crateApiTypesNetworkDefault();
}

@freezed
sealed class RbfValue with _$RbfValue {
  const RbfValue._();

  const factory RbfValue.rbfDefault() = RbfValue_RbfDefault;
  const factory RbfValue.value(
    int field0,
  ) = RbfValue_Value;
}

/// Adjust the behavior of our software signers and the way a transaction is finalized
class SignOptions {
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
  final bool trustWitnessUtxo;

  /// Whether the wallet should assume a specific height has been reached when trying to finalize
  /// a transaction
  ///
  /// The wallet will only "use" a timelock to satisfy the spending policy of an input if the
  /// timelock height has already been reached. This option allows overriding the "current height" to let the
  /// wallet use timelocks in the future to spend a coin.
  final int? assumeHeight;

  /// Whether the signer should use the `sighash_type` set in the PSBT when signing, no matter
  /// what its value is
  ///
  /// Defaults to `false` which will only allow signing using `SIGHASH_ALL`.
  final bool allowAllSighashes;

  /// Whether to remove partial signatures from the PSBT inputs while finalizing PSBT.
  ///
  /// Defaults to `true` which will remove partial signatures during finalization.
  final bool removePartialSigs;

  /// Whether to try finalizing the PSBT after the inputs are signed.
  ///
  /// Defaults to `true` which will try finalizing PSBT after inputs are signed.
  final bool tryFinalize;

  /// Whether we should try to sign a taproot transaction with the taproot internal key
  /// or not. This option is ignored if we're signing a non-taproot PSBT.
  ///
  /// Defaults to `true`, i.e., we always try to sign with the taproot internal key.
  final bool signWithTapInternalKey;

  /// Whether we should grind ECDSA signature to ensure signing with low r
  /// or not.
  /// Defaults to `true`, i.e., we always grind ECDSA signature to sign with low r.
  final bool allowGrinding;

  const SignOptions({
    required this.trustWitnessUtxo,
    this.assumeHeight,
    required this.allowAllSighashes,
    required this.removePartialSigs,
    required this.tryFinalize,
    required this.signWithTapInternalKey,
    required this.allowGrinding,
  });

  static Future<SignOptions> default_() =>
      core.instance.api.crateApiTypesSignOptionsDefault();

  @override
  int get hashCode =>
      trustWitnessUtxo.hashCode ^
      assumeHeight.hashCode ^
      allowAllSighashes.hashCode ^
      removePartialSigs.hashCode ^
      tryFinalize.hashCode ^
      signWithTapInternalKey.hashCode ^
      allowGrinding.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignOptions &&
          runtimeType == other.runtimeType &&
          trustWitnessUtxo == other.trustWitnessUtxo &&
          assumeHeight == other.assumeHeight &&
          allowAllSighashes == other.allowAllSighashes &&
          removePartialSigs == other.removePartialSigs &&
          tryFinalize == other.tryFinalize &&
          signWithTapInternalKey == other.signWithTapInternalKey &&
          allowGrinding == other.allowGrinding;
}

///Type describing entropy length (aka word count) in the mnemonic
enum WordCount {
  ///12 words mnemonic (128 bits entropy)
  words12,

  ///18 words mnemonic (192 bits entropy)
  words18,

  ///24 words mnemonic (256 bits entropy)
  words24,
  ;
}
