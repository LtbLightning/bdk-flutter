// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.30.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'blockchain.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
import 'types.dart';
part 'error.freezed.dart';

@freezed
sealed class AddressError with _$AddressError {
  const AddressError._();

  const factory AddressError.base58(
    String field0,
  ) = AddressError_Base58;
  const factory AddressError.bech32(
    String field0,
  ) = AddressError_Bech32;
  const factory AddressError.emptyBech32Payload() =
      AddressError_EmptyBech32Payload;
  const factory AddressError.invalidBech32Variant({
    required Variant expected,
    required Variant found,
  }) = AddressError_InvalidBech32Variant;
  const factory AddressError.invalidWitnessVersion(
    int field0,
  ) = AddressError_InvalidWitnessVersion;
  const factory AddressError.unparsableWitnessVersion(
    String field0,
  ) = AddressError_UnparsableWitnessVersion;
  const factory AddressError.malformedWitnessVersion() =
      AddressError_MalformedWitnessVersion;
  const factory AddressError.invalidWitnessProgramLength(
    int field0,
  ) = AddressError_InvalidWitnessProgramLength;
  const factory AddressError.invalidSegwitV0ProgramLength(
    int field0,
  ) = AddressError_InvalidSegwitV0ProgramLength;
  const factory AddressError.uncompressedPubkey() =
      AddressError_UncompressedPubkey;
  const factory AddressError.excessiveScriptSize() =
      AddressError_ExcessiveScriptSize;
  const factory AddressError.unrecognizedScript() =
      AddressError_UnrecognizedScript;
  const factory AddressError.unknownAddressType(
    String field0,
  ) = AddressError_UnknownAddressType;
  const factory AddressError.networkValidation({
    required Network networkRequired,
    required Network networkFound,
    required String address,
  }) = AddressError_NetworkValidation;
}

@freezed
sealed class BdkError with _$BdkError implements FrbException {
  const BdkError._();

  /// Hex decoding error
  const factory BdkError.hex(
    HexError field0,
  ) = BdkError_Hex;

  /// Encoding error
  const factory BdkError.consensus(
    ConsensusError field0,
  ) = BdkError_Consensus;

  /// Address error.
  const factory BdkError.address(
    AddressError field0,
  ) = BdkError_Address;

  /// Error related to the parsing and usage of descriptors
  const factory BdkError.descriptor(
    DescriptorError field0,
  ) = BdkError_Descriptor;

  /// Wrong number of bytes found when trying to convert to u32
  const factory BdkError.invalidU32Bytes(
    Uint8List field0,
  ) = BdkError_InvalidU32Bytes;

  /// Generic error
  const factory BdkError.generic(
    String field0,
  ) = BdkError_Generic;

  /// This error is thrown when trying to convert Bare and Public key script to address
  const factory BdkError.scriptDoesntHaveAddressForm() =
      BdkError_ScriptDoesntHaveAddressForm;

  /// Cannot build a tx without recipients
  const factory BdkError.noRecipients() = BdkError_NoRecipients;

  /// `manually_selected_only` option is selected but no utxo has been passed
  const factory BdkError.noUtxosSelected() = BdkError_NoUtxosSelected;

  /// Output created is under the dust limit, 546 satoshis
  const factory BdkError.outputBelowDustLimit(
    int field0,
  ) = BdkError_OutputBelowDustLimit;

  /// Wallet's UTXO set is not enough to cover recipient's requested plus fee
  const factory BdkError.insufficientFunds({
    /// Sats needed for some transaction
    required int needed,

    /// Sats available for spending
    required int available,
  }) = BdkError_InsufficientFunds;

  /// Branch and bound coin selection possible attempts with sufficiently big UTXO set could grow
  /// exponentially, thus a limit is set, and when hit, this error is thrown
  const factory BdkError.bnBTotalTriesExceeded() =
      BdkError_BnBTotalTriesExceeded;

  /// Branch and bound coin selection tries to avoid needing a change by finding the right inputs for
  /// the desired outputs plus fee, if there is not such combination this error is thrown
  const factory BdkError.bnBNoExactMatch() = BdkError_BnBNoExactMatch;

  /// Happens when trying to spend an UTXO that is not in the internal database
  const factory BdkError.unknownUtxo() = BdkError_UnknownUtxo;

  /// Thrown when a tx is not found in the internal database
  const factory BdkError.transactionNotFound() = BdkError_TransactionNotFound;

  /// Happens when trying to bump a transaction that is already confirmed
  const factory BdkError.transactionConfirmed() = BdkError_TransactionConfirmed;

  /// Trying to replace a tx that has a sequence >= `0xFFFFFFFE`
  const factory BdkError.irreplaceableTransaction() =
      BdkError_IrreplaceableTransaction;

  /// When bumping a tx the fee rate requested is lower than required
  const factory BdkError.feeRateTooLow({
    /// Required fee rate (satoshi/vbyte)
    required double needed,
  }) = BdkError_FeeRateTooLow;

  /// When bumping a tx the absolute fee requested is lower than replaced tx absolute fee
  const factory BdkError.feeTooLow({
    /// Required fee absolute value (satoshi)
    required int needed,
  }) = BdkError_FeeTooLow;

  /// Node doesn't have data to estimate a fee rate
  const factory BdkError.feeRateUnavailable() = BdkError_FeeRateUnavailable;
  const factory BdkError.missingKeyOrigin(
    String field0,
  ) = BdkError_MissingKeyOrigin;

  /// Error while working with keys
  const factory BdkError.key(
    String field0,
  ) = BdkError_Key;

  /// Descriptor checksum mismatch
  const factory BdkError.checksumMismatch() = BdkError_ChecksumMismatch;

  /// Spending policy is not compatible with this [KeychainKind]
  const factory BdkError.spendingPolicyRequired(
    KeychainKind field0,
  ) = BdkError_SpendingPolicyRequired;

  /// Error while extracting and manipulating policies
  const factory BdkError.invalidPolicyPathError(
    String field0,
  ) = BdkError_InvalidPolicyPathError;

  /// Signing error
  const factory BdkError.signer(
    String field0,
  ) = BdkError_Signer;

  /// Invalid network
  const factory BdkError.invalidNetwork({
    /// requested network, for example what is given as bdk-cli option
    required Network requested,

    /// found network, for example the network of the bitcoin node
    required Network found,
  }) = BdkError_InvalidNetwork;

  /// Requested outpoint doesn't exist in the tx (vout greater than available outputs)
  const factory BdkError.invalidOutpoint(
    OutPoint field0,
  ) = BdkError_InvalidOutpoint;

  /// Encoding error
  const factory BdkError.encode(
    String field0,
  ) = BdkError_Encode;

  /// Miniscript error
  const factory BdkError.miniscript(
    String field0,
  ) = BdkError_Miniscript;

  /// Miniscript PSBT error
  const factory BdkError.miniscriptPsbt(
    String field0,
  ) = BdkError_MiniscriptPsbt;

  /// BIP32 error
  const factory BdkError.bip32(
    String field0,
  ) = BdkError_Bip32;

  /// BIP39 error
  const factory BdkError.bip39(
    String field0,
  ) = BdkError_Bip39;

  /// A secp256k1 error
  const factory BdkError.secp256K1(
    String field0,
  ) = BdkError_Secp256k1;

  /// Error serializing or deserializing JSON data
  const factory BdkError.json(
    String field0,
  ) = BdkError_Json;

  /// Partially signed bitcoin transaction error
  const factory BdkError.psbt(
    String field0,
  ) = BdkError_Psbt;

  /// Partially signed bitcoin transaction parse error
  const factory BdkError.psbtParse(
    String field0,
  ) = BdkError_PsbtParse;

  ///  sync attempt failed due to missing scripts in cache which
  /// are needed to satisfy `stop_gap`.
  const factory BdkError.missingCachedScripts(
    int field0,
    int field1,
  ) = BdkError_MissingCachedScripts;

  /// Electrum client error
  const factory BdkError.electrum(
    String field0,
  ) = BdkError_Electrum;

  /// Esplora client error
  const factory BdkError.esplora(
    String field0,
  ) = BdkError_Esplora;

  /// Sled database error
  const factory BdkError.sled(
    String field0,
  ) = BdkError_Sled;

  /// Rpc client error
  const factory BdkError.rpc(
    String field0,
  ) = BdkError_Rpc;

  /// Rusqlite client error
  const factory BdkError.rusqlite(
    String field0,
  ) = BdkError_Rusqlite;
  const factory BdkError.invalidInput(
    String field0,
  ) = BdkError_InvalidInput;
  const factory BdkError.invalidLockTime(
    String field0,
  ) = BdkError_InvalidLockTime;
  const factory BdkError.invalidTransaction(
    String field0,
  ) = BdkError_InvalidTransaction;
}

@freezed
sealed class ConsensusError with _$ConsensusError {
  const ConsensusError._();

  const factory ConsensusError.io(
    String field0,
  ) = ConsensusError_Io;
  const factory ConsensusError.oversizedVectorAllocation({
    required int requested,
    required int max,
  }) = ConsensusError_OversizedVectorAllocation;
  const factory ConsensusError.invalidChecksum({
    required U8Array4 expected,
    required U8Array4 actual,
  }) = ConsensusError_InvalidChecksum;
  const factory ConsensusError.nonMinimalVarInt() =
      ConsensusError_NonMinimalVarInt;
  const factory ConsensusError.parseFailed(
    String field0,
  ) = ConsensusError_ParseFailed;
  const factory ConsensusError.unsupportedSegwitFlag(
    int field0,
  ) = ConsensusError_UnsupportedSegwitFlag;
}

@freezed
sealed class DescriptorError with _$DescriptorError {
  const DescriptorError._();

  const factory DescriptorError.invalidHdKeyPath() =
      DescriptorError_InvalidHdKeyPath;
  const factory DescriptorError.invalidDescriptorChecksum() =
      DescriptorError_InvalidDescriptorChecksum;
  const factory DescriptorError.hardenedDerivationXpub() =
      DescriptorError_HardenedDerivationXpub;
  const factory DescriptorError.multiPath() = DescriptorError_MultiPath;
  const factory DescriptorError.key(
    String field0,
  ) = DescriptorError_Key;
  const factory DescriptorError.policy(
    String field0,
  ) = DescriptorError_Policy;
  const factory DescriptorError.invalidDescriptorCharacter(
    int field0,
  ) = DescriptorError_InvalidDescriptorCharacter;
  const factory DescriptorError.bip32(
    String field0,
  ) = DescriptorError_Bip32;
  const factory DescriptorError.base58(
    String field0,
  ) = DescriptorError_Base58;
  const factory DescriptorError.pk(
    String field0,
  ) = DescriptorError_Pk;
  const factory DescriptorError.miniscript(
    String field0,
  ) = DescriptorError_Miniscript;
  const factory DescriptorError.hex(
    String field0,
  ) = DescriptorError_Hex;
}

@freezed
sealed class HexError with _$HexError {
  const HexError._();

  const factory HexError.invalidChar(
    int field0,
  ) = HexError_InvalidChar;
  const factory HexError.oddLengthString(
    int field0,
  ) = HexError_OddLengthString;
  const factory HexError.invalidLength(
    int field0,
    int field1,
  ) = HexError_InvalidLength;
}
