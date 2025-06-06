// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.9.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../lib.dart';
import 'error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'types.freezed.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `assert_receiver_is_total_eq`, `assert_receiver_is_total_eq`, `assert_receiver_is_total_eq`, `assert_receiver_is_total_eq`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `clone`, `eq`, `eq`, `eq`, `eq`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `fmt`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `from`, `hash`, `try_from`, `try_from`, `try_from`, `try_from`, `try_from`, `try_from`, `try_from`, `try_from`, `try_from`, `try_from`

@freezed
sealed class AddressIndex with _$AddressIndex {
  const AddressIndex._();

  ///Return a new address after incrementing the current descriptor index.
  const factory AddressIndex.increase() = AddressIndex_Increase;

  ///Return the address for the current descriptor index if it has not been used in a received transaction. Otherwise return a new address as with AddressIndex.New.
  ///Use with caution, if the wallet has not yet detected an address has been used it could return an already used address. This function is primarily meant for situations where the caller is untrusted; for example when deriving donation addresses on-demand for a public web page.
  const factory AddressIndex.lastUnused() = AddressIndex_LastUnused;

  /// Return the address for a specific descriptor index. Does not change the current descriptor
  /// index used by `AddressIndex` and `AddressIndex.LastUsed`.
  /// Use with caution, if an index is given that is less than the current descriptor index
  /// then the returned address may have already been used.
  const factory AddressIndex.peek({required int index}) = AddressIndex_Peek;

  /// Return the address for a specific descriptor index and reset the current descriptor index
  /// used by `AddressIndex` and `AddressIndex.LastUsed` to this value.
  /// Use with caution, if an index is given that is less than the current descriptor index
  /// then the returned address and subsequent addresses returned by calls to `AddressIndex`
  /// and `AddressIndex.LastUsed` may have already been used. Also if the index is reset to a
  /// value earlier than the Blockchain stopGap (default is 20) then a
  /// larger stopGap should be used to monitor for all possibly used addresses.
  const factory AddressIndex.reset({required int index}) = AddressIndex_Reset;
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

class BdkAddress {
  final Address ptr;

  const BdkAddress({required this.ptr});

  String asString() =>
      core.instance.api.crateApiTypesBdkAddressAsString(that: this);

  static BdkAddress fromScript({
    required BdkScriptBuf script,
    required Network network,
  }) => core.instance.api.crateApiTypesBdkAddressFromScript(
    script: script,
    network: network,
  );

  static BdkAddress fromString({
    required String address,
    required Network network,
  }) => core.instance.api.crateApiTypesBdkAddressFromString(
    address: address,
    network: network,
  );

  bool isValidForNetwork({required Network network}) => core.instance.api
      .crateApiTypesBdkAddressIsValidForNetwork(that: this, network: network);

  Network network() =>
      core.instance.api.crateApiTypesBdkAddressNetwork(that: this);

  Payload payload() =>
      core.instance.api.crateApiTypesBdkAddressPayload(that: this);

  static BdkScriptBuf script({required BdkAddress ptr}) =>
      core.instance.api.crateApiTypesBdkAddressScript(ptr: ptr);

  String toQrUri() =>
      core.instance.api.crateApiTypesBdkAddressToQrUri(that: this);

  @override
  int get hashCode => ptr.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BdkAddress &&
          runtimeType == other.runtimeType &&
          ptr == other.ptr;
}

class BdkPolicy {
  final Policy ptr;

  const BdkPolicy({required this.ptr});

  String asString() =>
      core.instance.api.crateApiTypesBdkPolicyAsString(that: this);

  Satisfaction contribution() =>
      core.instance.api.crateApiTypesBdkPolicyContribution(that: this);

  String id() => core.instance.api.crateApiTypesBdkPolicyId(that: this);

  SatisfiableItem item() =>
      core.instance.api.crateApiTypesBdkPolicyItem(that: this);

  bool requiresPath() =>
      core.instance.api.crateApiTypesBdkPolicyRequiresPath(that: this);

  Satisfaction satisfaction() =>
      core.instance.api.crateApiTypesBdkPolicySatisfaction(that: this);

  @override
  int get hashCode => ptr.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BdkPolicy &&
          runtimeType == other.runtimeType &&
          ptr == other.ptr;
}

class BdkScriptBuf {
  final Uint8List bytes;

  const BdkScriptBuf({required this.bytes});

  String asString() =>
      core.instance.api.crateApiTypesBdkScriptBufAsString(that: this);

  ///Creates a new empty script.
  static BdkScriptBuf empty() =>
      core.instance.api.crateApiTypesBdkScriptBufEmpty();

  static BdkScriptBuf fromHex({required String s}) =>
      core.instance.api.crateApiTypesBdkScriptBufFromHex(s: s);

  ///Creates a new empty script with pre-allocated capacity.
  static BdkScriptBuf withCapacity({required BigInt capacity}) => core
      .instance
      .api
      .crateApiTypesBdkScriptBufWithCapacity(capacity: capacity);

  @override
  int get hashCode => bytes.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BdkScriptBuf &&
          runtimeType == other.runtimeType &&
          bytes == other.bytes;
}

class BdkTransaction {
  final String s;

  const BdkTransaction({required this.s});

  static BdkTransaction create({
    required int version,
    required LockTime lockTime,
    required List<BdkTxIn> input,
    required List<BdkTxOut> output,
  }) => core.instance.api.crateApiTypesBdkTransactionCreate(
    version: version,
    lockTime: lockTime,
    input: input,
    output: output,
  );

  static BdkTransaction fromBytes({required List<int> transactionBytes}) => core
      .instance
      .api
      .crateApiTypesBdkTransactionFromBytes(transactionBytes: transactionBytes);

  ///List of transaction inputs.
  List<BdkTxIn> input() =>
      core.instance.api.crateApiTypesBdkTransactionInput(that: this);

  ///Is this a coin base transaction?
  bool isCoinBase() =>
      core.instance.api.crateApiTypesBdkTransactionIsCoinBase(that: this);

  ///Returns true if the transaction itself opted in to be BIP-125-replaceable (RBF).
  /// This does not cover the case where a transaction becomes replaceable due to ancestors being RBF.
  bool isExplicitlyRbf() =>
      core.instance.api.crateApiTypesBdkTransactionIsExplicitlyRbf(that: this);

  ///Returns true if this transactions nLockTime is enabled (BIP-65 ).
  bool isLockTimeEnabled() => core.instance.api
      .crateApiTypesBdkTransactionIsLockTimeEnabled(that: this);

  ///Block height or timestamp. Transaction cannot be included in a block until this height/time.
  LockTime lockTime() =>
      core.instance.api.crateApiTypesBdkTransactionLockTime(that: this);

  ///List of transaction outputs.
  List<BdkTxOut> output() =>
      core.instance.api.crateApiTypesBdkTransactionOutput(that: this);

  ///Encodes an object into a vector.
  Uint8List serialize() =>
      core.instance.api.crateApiTypesBdkTransactionSerialize(that: this);

  ///Returns the regular byte-wise consensus-serialized size of this transaction.
  BigInt size() =>
      core.instance.api.crateApiTypesBdkTransactionSize(that: this);

  ///Computes the txid. For non-segwit transactions this will be identical to the output of wtxid(),
  /// but for segwit transactions, this will give the correct txid (not including witnesses) while wtxid will also hash witnesses.
  String txid() =>
      core.instance.api.crateApiTypesBdkTransactionTxid(that: this);

  ///The protocol version, is currently expected to be 1 or 2 (BIP 68).
  int version() =>
      core.instance.api.crateApiTypesBdkTransactionVersion(that: this);

  ///Returns the “virtual size” (vsize) of this transaction.
  ///
  BigInt vsize() =>
      core.instance.api.crateApiTypesBdkTransactionVsize(that: this);

  ///Returns the regular byte-wise consensus-serialized size of this transaction.
  BigInt weight() =>
      core.instance.api.crateApiTypesBdkTransactionWeight(that: this);

  @override
  int get hashCode => s.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BdkTransaction &&
          runtimeType == other.runtimeType &&
          s == other.s;
}

///A wallet transaction
class BdkTransactionDetails {
  final BdkTransaction? transaction;

  /// Transaction id.
  final String txid;

  /// Received value (sats)
  /// Sum of owned outputs of this transaction.
  final BigInt received;

  /// Sent value (sats)
  /// Sum of owned inputs of this transaction.
  final BigInt sent;

  /// Fee value (sats) if confirmed.
  /// The availability of the fee depends on the backend. It's never None with an Electrum
  /// Server backend, but it could be None with a Bitcoin RPC node without txindex that receive
  /// funds while offline.
  final BigInt? fee;

  /// If the transaction is confirmed, contains height and timestamp of the block containing the
  /// transaction, unconfirmed transaction contains `None`.
  final BlockTime? confirmationTime;

  const BdkTransactionDetails({
    this.transaction,
    required this.txid,
    required this.received,
    required this.sent,
    this.fee,
    this.confirmationTime,
  });

  @override
  int get hashCode =>
      transaction.hashCode ^
      txid.hashCode ^
      received.hashCode ^
      sent.hashCode ^
      fee.hashCode ^
      confirmationTime.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BdkTransactionDetails &&
          runtimeType == other.runtimeType &&
          transaction == other.transaction &&
          txid == other.txid &&
          received == other.received &&
          sent == other.sent &&
          fee == other.fee &&
          confirmationTime == other.confirmationTime;
}

class BdkTxIn {
  final OutPoint previousOutput;
  final BdkScriptBuf? scriptSig;
  final int sequence;
  final List<Uint8List> witness;

  const BdkTxIn({
    required this.previousOutput,
    this.scriptSig,
    required this.sequence,
    required this.witness,
  });

  @override
  int get hashCode =>
      previousOutput.hashCode ^
      scriptSig.hashCode ^
      sequence.hashCode ^
      witness.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BdkTxIn &&
          runtimeType == other.runtimeType &&
          previousOutput == other.previousOutput &&
          scriptSig == other.scriptSig &&
          sequence == other.sequence &&
          witness == other.witness;
}

///A transaction output, which defines new coins to be created from old ones.
class BdkTxOut {
  /// The value of the output, in satoshis.
  final BigInt value;

  /// The address of the output.
  final BdkScriptBuf scriptPubkey;

  const BdkTxOut({required this.value, required this.scriptPubkey});

  @override
  int get hashCode => value.hashCode ^ scriptPubkey.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BdkTxOut &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          scriptPubkey == other.scriptPubkey;
}

///Block height and timestamp of a block
class BlockTime {
  ///Confirmation block height
  final int height;

  ///Confirmation block timestamp
  final BigInt timestamp;

  const BlockTime({required this.height, required this.timestamp});

  @override
  int get hashCode => height.hashCode ^ timestamp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockTime &&
          runtimeType == other.runtimeType &&
          height == other.height &&
          timestamp == other.timestamp;
}

enum ChangeSpendPolicy { changeAllowed, onlyChange, changeForbidden }

class Condition {
  final int? csv;
  final LockTime? timelock;

  const Condition({this.csv, this.timelock});

  @override
  int get hashCode => csv.hashCode ^ timelock.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Condition &&
          runtimeType == other.runtimeType &&
          csv == other.csv &&
          timelock == other.timelock;
}

@freezed
sealed class DatabaseConfig with _$DatabaseConfig {
  const DatabaseConfig._();

  const factory DatabaseConfig.memory() = DatabaseConfig_Memory;

  ///Simple key-value embedded database based on sled
  const factory DatabaseConfig.sqlite({required SqliteDbConfiguration config}) =
      DatabaseConfig_Sqlite;

  ///Sqlite embedded database using rusqlite
  const factory DatabaseConfig.sled({required SledDbConfiguration config}) =
      DatabaseConfig_Sled;
}

class FeeRate {
  final double satPerVb;

  const FeeRate({required this.satPerVb});

  @override
  int get hashCode => satPerVb.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeeRate &&
          runtimeType == other.runtimeType &&
          satPerVb == other.satPerVb;
}

/// A key-value map for an input of the corresponding index in the unsigned
class Input {
  final String s;

  const Input({required this.s});

  @override
  int get hashCode => s.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Input && runtimeType == other.runtimeType && s == other.s;
}

///Types of keychains
enum KeychainKind {
  externalChain,

  ///Internal, usually used for change outputs
  internalChain,
}

///Unspent outputs of this wallet
class LocalUtxo {
  final OutPoint outpoint;
  final BdkTxOut txout;
  final KeychainKind keychain;
  final bool isSpent;

  const LocalUtxo({
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
      other is LocalUtxo &&
          runtimeType == other.runtimeType &&
          outpoint == other.outpoint &&
          txout == other.txout &&
          keychain == other.keychain &&
          isSpent == other.isSpent;
}

@freezed
sealed class LockTime with _$LockTime {
  const LockTime._();

  const factory LockTime.blocks(int field0) = LockTime_Blocks;
  const factory LockTime.seconds(int field0) = LockTime_Seconds;
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
  signet;

  static Future<Network> default_() =>
      core.instance.api.crateApiTypesNetworkDefault();
}

/// A reference to a transaction output.
class OutPoint {
  /// The referenced transaction's txid.
  final String txid;

  /// The index of the referenced output in its transaction's vout.
  final int vout;

  const OutPoint({required this.txid, required this.vout});

  @override
  int get hashCode => txid.hashCode ^ vout.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutPoint &&
          runtimeType == other.runtimeType &&
          txid == other.txid &&
          vout == other.vout;
}

@freezed
sealed class Payload with _$Payload {
  const Payload._();

  /// P2PKH address.
  const factory Payload.pubkeyHash({required String pubkeyHash}) =
      Payload_PubkeyHash;

  /// P2SH address.
  const factory Payload.scriptHash({required String scriptHash}) =
      Payload_ScriptHash;

  /// Segwit address.
  const factory Payload.witnessProgram({
    /// The witness program version.
    required WitnessVersion version,

    /// The witness program.
    required Uint8List program,
  }) = Payload_WitnessProgram;
}

@freezed
sealed class PkOrF with _$PkOrF {
  const PkOrF._();

  const factory PkOrF.pubkey({required String value}) = PkOrF_Pubkey;
  const factory PkOrF.xOnlyPubkey({required String value}) = PkOrF_XOnlyPubkey;
  const factory PkOrF.fingerprint({required String value}) = PkOrF_Fingerprint;
}

class PsbtSigHashType {
  final int inner;

  const PsbtSigHashType({required this.inner});

  @override
  int get hashCode => inner.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PsbtSigHashType &&
          runtimeType == other.runtimeType &&
          inner == other.inner;
}

@freezed
sealed class RbfValue with _$RbfValue {
  const RbfValue._();

  const factory RbfValue.rbfDefault() = RbfValue_RbfDefault;
  const factory RbfValue.value(int field0) = RbfValue_Value;
}

@freezed
sealed class Satisfaction with _$Satisfaction {
  const Satisfaction._();

  const factory Satisfaction.partial({
    required BigInt n,
    required BigInt m,
    required Uint64List items,
    bool? sorted,
    required Map<int, List<Condition>> conditions,
  }) = Satisfaction_Partial;
  const factory Satisfaction.partialComplete({
    required BigInt n,
    required BigInt m,
    required Uint64List items,
    bool? sorted,
    required Map<Uint32List, List<Condition>> conditions,
  }) = Satisfaction_PartialComplete;
  const factory Satisfaction.complete({required Condition condition}) =
      Satisfaction_Complete;
  const factory Satisfaction.none({required String msg}) = Satisfaction_None;
}

@freezed
sealed class SatisfiableItem with _$SatisfiableItem {
  const SatisfiableItem._();

  const factory SatisfiableItem.ecdsaSignature({required PkOrF key}) =
      SatisfiableItem_EcdsaSignature;
  const factory SatisfiableItem.schnorrSignature({required PkOrF key}) =
      SatisfiableItem_SchnorrSignature;
  const factory SatisfiableItem.sha256Preimage({required String hash}) =
      SatisfiableItem_Sha256Preimage;
  const factory SatisfiableItem.hash256Preimage({required String hash}) =
      SatisfiableItem_Hash256Preimage;
  const factory SatisfiableItem.ripemd160Preimage({required String hash}) =
      SatisfiableItem_Ripemd160Preimage;
  const factory SatisfiableItem.hash160Preimage({required String hash}) =
      SatisfiableItem_Hash160Preimage;
  const factory SatisfiableItem.absoluteTimelock({required LockTime value}) =
      SatisfiableItem_AbsoluteTimelock;
  const factory SatisfiableItem.relativeTimelock({required int value}) =
      SatisfiableItem_RelativeTimelock;
  const factory SatisfiableItem.multisig({
    required List<PkOrF> keys,
    required BigInt threshold,
  }) = SatisfiableItem_Multisig;
  const factory SatisfiableItem.thresh({
    required List<BdkPolicy> items,
    required BigInt threshold,
  }) = SatisfiableItem_Thresh;
}

/// A output script and an amount of satoshis.
class ScriptAmount {
  final BdkScriptBuf script;
  final BigInt amount;

  const ScriptAmount({required this.script, required this.amount});

  @override
  int get hashCode => script.hashCode ^ amount.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScriptAmount &&
          runtimeType == other.runtimeType &&
          script == other.script &&
          amount == other.amount;
}

/// Options for a software signer
///
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

///Configuration type for a sled Tree database
class SledDbConfiguration {
  ///Main directory of the db
  final String path;

  ///Name of the database tree, a separated namespace for the data
  final String treeName;

  const SledDbConfiguration({required this.path, required this.treeName});

  @override
  int get hashCode => path.hashCode ^ treeName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SledDbConfiguration &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          treeName == other.treeName;
}

///Configuration type for a SqliteDatabase database
class SqliteDbConfiguration {
  ///Main directory of the db
  final String path;

  const SqliteDbConfiguration({required this.path});

  @override
  int get hashCode => path.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SqliteDbConfiguration &&
          runtimeType == other.runtimeType &&
          path == other.path;
}

enum Variant { bech32, bech32M }

enum WitnessVersion {
  /// Initial version of witness program. Used for P2WPKH and P2WPK outputs
  v0,

  /// Version of witness program used for Taproot P2TR outputs.
  v1,

  /// Future (unsupported) version of witness program.
  v2,

  /// Future (unsupported) version of witness program.
  v3,

  /// Future (unsupported) version of witness program.
  v4,

  /// Future (unsupported) version of witness program.
  v5,

  /// Future (unsupported) version of witness program.
  v6,

  /// Future (unsupported) version of witness program.
  v7,

  /// Future (unsupported) version of witness program.
  v8,

  /// Future (unsupported) version of witness program.
  v9,

  /// Future (unsupported) version of witness program.
  v10,

  /// Future (unsupported) version of witness program.
  v11,

  /// Future (unsupported) version of witness program.
  v12,

  /// Future (unsupported) version of witness program.
  v13,

  /// Future (unsupported) version of witness program.
  v14,

  /// Future (unsupported) version of witness program.
  v15,

  /// Future (unsupported) version of witness program.
  v16,
}

///Type describing entropy length (aka word count) in the mnemonic
enum WordCount {
  ///12 words mnemonic (128 bits entropy)
  words12,

  ///18 words mnemonic (192 bits entropy)
  words18,

  ///24 words mnemonic (256 bits entropy)
  words24,
}
