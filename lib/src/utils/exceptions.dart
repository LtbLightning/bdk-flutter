import '../generated/api/error.dart';

abstract class BdkFfiException implements Exception {
  String? message;
  BdkFfiException({this.message});
  @override
  String toString() =>
      (message != null) ? '$runtimeType( $message )' : runtimeType.toString();
}

/// Exception thrown when trying to add an invalid byte value, or empty list to txBuilder.addData
class InvalidByteException extends BdkFfiException {
  /// Constructs the [InvalidByteException]
  InvalidByteException({super.message});
}

/// Exception thrown when output created is under the dust limit, 546 sats
class OutputBelowDustLimitException extends BdkFfiException {
  /// Constructs the [OutputBelowDustLimitException]
  OutputBelowDustLimitException({super.message});
}

/// Exception thrown when a there is an error in Partially signed bitcoin transaction
class PsbtException extends BdkFfiException {
  /// Constructs the [PsbtException]
  PsbtException({super.message});
}

/// Exception thrown when a there is an error in Partially signed bitcoin transaction
class PsbtParseException extends BdkFfiException {
  /// Constructs the [PsbtParseException]
  PsbtParseException({super.message});
}

class GenericException extends BdkFfiException {
  /// Constructs the [GenericException]
  GenericException({super.message});
}

class Bip32Exception extends BdkFfiException {
  /// Constructs the [Bip32Exception]
  Bip32Exception({super.message});
}

/// Exception thrown when a tx is build without recipients
class NoRecipientsException extends BdkFfiException {
  /// Constructs the [NoRecipientsException]
  NoRecipientsException({super.message});
}

/// Exception thrown when trying to convert Bare and Public key script to address
class ScriptDoesntHaveAddressFormException extends BdkFfiException {
  /// Constructs the [ScriptDoesntHaveAddressFormException]
  ScriptDoesntHaveAddressFormException({super.message});
}

/// Exception thrown when manuallySelectedOnly() is called but no utxos has been passed
class NoUtxosSelectedException extends BdkFfiException {
  /// Constructs the [NoUtxosSelectedException]
  NoUtxosSelectedException({super.message});
}

/// Branch and bound coin selection possible attempts with sufficiently big UTXO set could grow exponentially,
/// thus a limit is set, and when hit, this exception is thrown
class BnBTotalTriesExceededException extends BdkFfiException {
  /// Constructs the [BnBTotalTriesExceededException]
  BnBTotalTriesExceededException({super.message});
}

///Branch and bound coin selection tries to avoid needing a change by finding the right inputs for the desired outputs plus fee,
/// if there is not such combination this exception is thrown
class BnBNoExactMatchException extends BdkFfiException {
  /// Constructs the [BnBNoExactMatchException]
  BnBNoExactMatchException({super.message});
}

///Exception thrown when trying to replace a tx that has a sequence >= 0xFFFFFFFE
class IrreplaceableTransactionException extends BdkFfiException {
  /// Constructs the [IrreplaceableTransactionException]
  IrreplaceableTransactionException({super.message});
}

///Exception thrown when the keys are invalid
class KeyException extends BdkFfiException {
  /// Constructs the [KeyException]
  KeyException({super.message});
}

///Exception thrown when spending policy is not compatible with this KeychainKind
class SpendingPolicyRequiredException extends BdkFfiException {
  /// Constructs the [SpendingPolicyRequiredException]
  SpendingPolicyRequiredException({super.message});
}

///Transaction verification Exception
class VerificationException extends BdkFfiException {
  /// Constructs the [VerificationException]
  VerificationException({super.message});
}

///Exception thrown when progress value is not between 0.0 (included) and 100.0 (included)
class InvalidProgressValueException extends BdkFfiException {
  /// Constructs the [InvalidProgressValueException]
  InvalidProgressValueException({super.message});
}

///Progress update error (maybe the channel has been closed)
class ProgressUpdateException extends BdkFfiException {
  /// Constructs the [ProgressUpdateException]
  ProgressUpdateException({super.message});
}

///Exception thrown when the requested outpoint doesn’t exist in the tx (vout greater than available outputs)
class InvalidOutpointException extends BdkFfiException {
  /// Constructs the [InvalidOutpointException]
  InvalidOutpointException({super.message});
}

class EncodeException extends BdkFfiException {
  /// Constructs the [EncodeException]
  EncodeException({super.message});
}

class MiniscriptPsbtException extends BdkFfiException {
  /// Constructs the [MiniscriptPsbtException]
  MiniscriptPsbtException({super.message});
}

class SignerException extends BdkFfiException {
  /// Constructs the [SignerException]
  SignerException({super.message});
}

///Exception thrown when there is an error while extracting and manipulating policies
class InvalidPolicyPathException extends BdkFfiException {
  /// Constructs the [InvalidPolicyPathException]
  InvalidPolicyPathException({super.message});
}

/// Exception thrown when extended key in the descriptor is neither be a master key itself (having depth = 0) or have an explicit origin provided
class MissingKeyOriginException extends BdkFfiException {
  /// Constructs the [MissingKeyOriginException]
  MissingKeyOriginException({super.message});
}

///Exception thrown when trying to spend an UTXO that is not in the internal database
class UnknownUtxoException extends BdkFfiException {
  /// Constructs the [UnknownUtxoException]
  UnknownUtxoException({super.message});
}

///Exception thrown when trying to bump a transaction that is already confirmed
class TransactionNotFoundException extends BdkFfiException {
  /// Constructs the [TransactionNotFoundException]
  TransactionNotFoundException({super.message});
}

///Exception thrown when node doesn’t have data to estimate a fee rate
class FeeRateUnavailableException extends BdkFfiException {
  /// Constructs the [FeeRateUnavailableException]
  FeeRateUnavailableException({super.message});
}

///Exception thrown when the descriptor checksum mismatch
class ChecksumMismatchException extends BdkFfiException {
  /// Constructs the [ChecksumMismatchException]
  ChecksumMismatchException({super.message});
}

///Exception thrown when sync attempt failed due to missing scripts in cache which are needed to satisfy stopGap.
class MissingCachedScriptsException extends BdkFfiException {
  /// Constructs the [MissingCachedScriptsException]
  MissingCachedScriptsException({super.message});
}

///Exception thrown when wallet’s UTXO set is not enough to cover recipient’s requested plus fee
class InsufficientFundsException extends BdkFfiException {
  /// Constructs the [InsufficientFundsException]
  InsufficientFundsException({super.message});
}

///Exception thrown when bumping a tx, the fee rate requested is lower than required
class FeeRateTooLowException extends BdkFfiException {
  /// Constructs the [FeeRateTooLowException]
  FeeRateTooLowException({super.message});
}

///Exception thrown when bumping a tx, the absolute fee requested is lower than replaced tx absolute fee
class FeeTooLowException extends BdkFfiException {
  /// Constructs the [FeeTooLowException]
  FeeTooLowException({super.message});
}

///Sled database error
class SledException extends BdkFfiException {
  /// Constructs the [SledException]
  SledException({super.message});
}

///Exception thrown when there is an error in parsing and usage of descriptors
class DescriptorException extends BdkFfiException {
  /// Constructs the [DescriptorException]
  DescriptorException({super.message});
}

///Miniscript exception
class MiniscriptException extends BdkFfiException {
  /// Constructs the [MiniscriptException]
  MiniscriptException({super.message});
}

///Esplora Client exception
class EsploraException extends BdkFfiException {
  /// Constructs the [EsploraException]
  EsploraException({super.message});
}

class Secp256k1Exception extends BdkFfiException {
  /// Constructs the [ Secp256k1Exception]
  Secp256k1Exception({super.message});
}

///Exception thrown when trying to bump a transaction that is already confirmed
class TransactionConfirmedException extends BdkFfiException {
  /// Constructs the [TransactionConfirmedException]
  TransactionConfirmedException({super.message});
}

class ElectrumException extends BdkFfiException {
  /// Constructs the [ElectrumException]
  ElectrumException({super.message});
}

class RpcException extends BdkFfiException {
  /// Constructs the [RpcException]
  RpcException({super.message});
}

class RusqliteException extends BdkFfiException {
  /// Constructs the [RusqliteException]
  RusqliteException({super.message});
}

class InvalidNetworkException extends BdkFfiException {
  /// Constructs the [InvalidNetworkException]
  InvalidNetworkException({super.message});
}

class JsonException extends BdkFfiException {
  /// Constructs the [JsonException]
  JsonException({super.message});
}

class HexException extends BdkFfiException {
  /// Constructs the [HexException]
  HexException({super.message});
}

class AddressException extends BdkFfiException {
  /// Constructs the [AddressException]
  AddressException({super.message});
}

class ConsensusException extends BdkFfiException {
  /// Constructs the [ConsensusException]
  ConsensusException({super.message});
}

class Bip39Exception extends BdkFfiException {
  /// Constructs the [Bip39Exception]
  Bip39Exception({super.message});
}

class InvalidTransactionException extends BdkFfiException {
  /// Constructs the [InvalidTransactionException]
  InvalidTransactionException({super.message});
}

class InvalidLockTimeException extends BdkFfiException {
  /// Constructs the [InvalidLockTimeException]
  InvalidLockTimeException({super.message});
}

class InvalidInputException extends BdkFfiException {
  /// Constructs the [InvalidInputException]
  InvalidInputException({super.message});
}

class VerifyTransactionException extends BdkFfiException {
  /// Constructs the [VerifyTransactionException]
  VerifyTransactionException({super.message});
}

Exception mapHexError(HexError error) {
  if (error is HexError_InvalidChar) {
    return HexException(message: "Non-hexadecimal character ${error.field0}");
  } else if (error is HexError_OddLengthString) {
    return HexException(
      message: "Purported hex string had odd length ${error.field0}",
    );
  } else if (error is HexError_InvalidLength) {
    return HexException(
      message:
          "Tried to parse fixed-length hash from a string with the wrong type; \n expected: ${error.field0}, found: ${error.field1}.",
    );
  }
  return HexException(message: "Unknown hex error");
}

Exception mapAddressError(AddressError error) {
  if (error is AddressError_Base58) {
    return AddressException(message: "Base58 encoding error: ${error.field0}");
  } else if (error is AddressError_Bech32) {
    return AddressException(message: "Bech32 encoding error: ${error.field0}");
  } else if (error is AddressError_EmptyBech32Payload) {
    return AddressException(message: "The bech32 payload was empty.");
  } else if (error is AddressError_InvalidBech32Variant) {
    return AddressException(
      message:
          "Invalid bech32 variant: The wrong checksum algorithm was used. See BIP-0350; \n expected: ${error.expected}, found: ${error.found}",
    );
  } else if (error is AddressError_InvalidWitnessVersion) {
    return AddressException(
      message:
          "Invalid witness version script: ${error.field0}, version must be 0 to 16 inclusive.",
    );
  } else if (error is AddressError_UnparsableWitnessVersion) {
    return AddressException(
      message: "Unable to parse witness version from string: ${error.field0}",
    );
  } else if (error is AddressError_MalformedWitnessVersion) {
    return AddressException(
      message:
          "Bitcoin script opcode does not match any known witness version, the script is malformed.",
    );
  } else if (error is AddressError_InvalidWitnessProgramLength) {
    return AddressException(
      message:
          "Invalid witness program length: ${error.field0}, The witness program must be between 2 and 40 bytes in length.",
    );
  } else if (error is AddressError_InvalidSegwitV0ProgramLength) {
    return AddressException(
      message:
          "Invalid segwitV0 program length: ${error.field0}, A v0 witness program must be either of length 20 or 32.",
    );
  } else if (error is AddressError_UncompressedPubkey) {
    return AddressException(
      message: "An uncompressed pubkey was used where it is not allowed.",
    );
  } else if (error is AddressError_ExcessiveScriptSize) {
    return AddressException(
      message: "Address size more than 520 bytes is not allowed.",
    );
  } else if (error is AddressError_UnrecognizedScript) {
    return AddressException(
      message:
          "Unrecognized script: Script is not a p2pkh, p2sh or witness program.",
    );
  } else if (error is AddressError_UnknownAddressType) {
    return AddressException(
      message:
          "Unknown address type: ${error.field0}, Address type is either invalid or not supported in rust-bitcoin.",
    );
  } else if (error is AddressError_NetworkValidation) {
    return AddressException(
      message:
          "Address's network differs from required one; \n required: ${error.networkRequired}, found: ${error.networkFound}",
    );
  }
  return AddressException(message: "Unknown address error");
}

Exception mapDescriptorError(DescriptorError error) {
  if (error is DescriptorError_InvalidHdKeyPath) {
    return DescriptorException(
      message:
          "Invalid HD Key path, such as having a wildcard but a length != 1",
    );
  } else if (error is DescriptorError_InvalidDescriptorChecksum) {
    return DescriptorException(
      message: "The provided descriptor doesn't match its checksum",
    );
  } else if (error is DescriptorError_HardenedDerivationXpub) {
    return DescriptorException(message: "Hardened derivation with xpub");
  } else if (error is DescriptorError_MultiPath) {
    return DescriptorException(
      message: "The descriptor contains multipath keys",
    );
  } else if (error is DescriptorError_Key) {
    return KeyException(message: error.field0);
  } else if (error is DescriptorError_Policy) {
    return DescriptorException(
      message:
          "Error while extracting and manipulating policies: ${error.field0}",
    );
  } else if (error is DescriptorError_Bip32) {
    return Bip32Exception(message: error.field0);
  } else if (error is DescriptorError_Base58) {
    return DescriptorException(
      message: "Error during base58 decoding: ${error.field0}",
    );
  } else if (error is DescriptorError_Pk) {
    return KeyException(message: error.field0);
  } else if (error is DescriptorError_Miniscript) {
    return MiniscriptException(message: error.field0);
  } else if (error is DescriptorError_Hex) {
    return HexException(message: error.field0);
  } else if (error is DescriptorError_InvalidDescriptorCharacter) {
    return DescriptorException(
      message: "Invalid byte found in the descriptor checksum: ${error.field0}",
    );
  }
  return DescriptorException(message: "Unknown descriptor error");
}

Exception mapConsensusError(ConsensusError error) {
  if (error is ConsensusError_Io) {
    return ConsensusException(message: "I/O error: ${error.field0}");
  } else if (error is ConsensusError_OversizedVectorAllocation) {
    return ConsensusException(
      message:
          "Tried to allocate an oversized vector. The capacity requested: ${error.requested}, found: ${error.max}",
    );
  } else if (error is ConsensusError_InvalidChecksum) {
    return ConsensusException(
      message:
          "Checksum was invalid, expected: ${error.expected}, actual: ${error.actual}",
    );
  } else if (error is ConsensusError_NonMinimalVarInt) {
    return ConsensusException(
      message: "VarInt was encoded in a non-minimal way.",
    );
  } else if (error is ConsensusError_ParseFailed) {
    return ConsensusException(message: "Parsing error: ${error.field0}");
  } else if (error is ConsensusError_UnsupportedSegwitFlag) {
    return ConsensusException(
      message: "Unsupported segwit flag ${error.field0}",
    );
  }
  return ConsensusException(message: "Unknown consensus error");
}

Exception mapBdkError(BdkError error) {
  if (error is BdkError_NoUtxosSelected) {
    return NoUtxosSelectedException(
      message:
          "manuallySelectedOnly option is selected but no utxo has been passed",
    );
  } else if (error is BdkError_InvalidU32Bytes) {
    return InvalidByteException(
      message:
          'Wrong number of bytes found when trying to convert the bytes, ${error.field0}',
    );
  } else if (error is BdkError_Generic) {
    return GenericException(message: error.field0);
  } else if (error is BdkError_ScriptDoesntHaveAddressForm) {
    return ScriptDoesntHaveAddressFormException();
  } else if (error is BdkError_NoRecipients) {
    return NoRecipientsException(
      message: "Failed to build a transaction without recipients",
    );
  } else if (error is BdkError_OutputBelowDustLimit) {
    return OutputBelowDustLimitException(
      message:
          'Output created is under the dust limit (546 sats). Output value: ${error.field0}',
    );
  } else if (error is BdkError_InsufficientFunds) {
    return InsufficientFundsException(
      message:
          "Wallet's UTXO set is not enough to cover recipient's requested plus fee; \n Needed: ${error.needed}, Available: ${error.available}",
    );
  } else if (error is BdkError_BnBTotalTriesExceeded) {
    return BnBTotalTriesExceededException(
      message:
          "Utxo branch and bound coin selection attempts have reached its limit",
    );
  } else if (error is BdkError_BnBNoExactMatch) {
    return BnBNoExactMatchException(
      message:
          "Utxo branch and bound coin selection failed to find the correct inputs for the desired outputs.",
    );
  } else if (error is BdkError_UnknownUtxo) {
    return UnknownUtxoException(
      message: "Utxo not found in the internal database",
    );
  } else if (error is BdkError_TransactionNotFound) {
    return TransactionNotFoundException();
  } else if (error is BdkError_TransactionConfirmed) {
    return TransactionConfirmedException();
  } else if (error is BdkError_IrreplaceableTransaction) {
    return IrreplaceableTransactionException(
      message:
          "Trying to replace the transaction that has a sequence >= 0xFFFFFFFE",
    );
  } else if (error is BdkError_FeeRateTooLow) {
    return FeeRateTooLowException(
      message:
          "The Fee rate requested is lower than required. Required: ${error.needed}",
    );
  } else if (error is BdkError_FeeTooLow) {
    return FeeTooLowException(
      message:
          "The absolute fee requested is lower than replaced tx's absolute fee; \n Required: ${error.needed}",
    );
  } else if (error is BdkError_FeeRateUnavailable) {
    return FeeRateUnavailableException(
      message: "Node doesn't have data to estimate a fee rate",
    );
  } else if (error is BdkError_MissingKeyOrigin) {
    return MissingKeyOriginException(message: error.field0);
  } else if (error is BdkError_Key) {
    return KeyException(message: error.field0);
  } else if (error is BdkError_ChecksumMismatch) {
    return ChecksumMismatchException();
  } else if (error is BdkError_SpendingPolicyRequired) {
    return SpendingPolicyRequiredException(
      message: "Spending policy is not compatible with: ${error.field0}",
    );
  } else if (error is BdkError_InvalidPolicyPathError) {
    return InvalidPolicyPathException(message: error.field0);
  } else if (error is BdkError_Signer) {
    return SignerException(message: error.field0);
  } else if (error is BdkError_InvalidNetwork) {
    return InvalidNetworkException(
      message: 'Requested: ${error.requested}, Found: ${error.found}',
    );
  } else if (error is BdkError_InvalidOutpoint) {
    return InvalidOutpointException(
      message:
          "${error.field0} doesn't exist in the tx (vout greater than available outputs)",
    );
  } else if (error is BdkError_Descriptor) {
    return mapDescriptorError(error.field0);
  } else if (error is BdkError_Encode) {
    return EncodeException(message: error.field0);
  } else if (error is BdkError_Miniscript) {
    return MiniscriptException(message: error.field0);
  } else if (error is BdkError_MiniscriptPsbt) {
    return MiniscriptPsbtException(message: error.field0);
  } else if (error is BdkError_Bip32) {
    return Bip32Exception(message: error.field0);
  } else if (error is BdkError_Secp256k1) {
    return Secp256k1Exception(message: error.field0);
  } else if (error is BdkError_MissingCachedScripts) {
    return MissingCachedScriptsException(
      message:
          'Sync attempt failed due to missing scripts in cache which are needed to satisfy stop_gap; \n MissingCount: ${error.field0}, LastCount: ${error.field1}',
    );
  } else if (error is BdkError_Json) {
    return JsonException(message: error.field0);
  } else if (error is BdkError_Hex) {
    return mapHexError(error.field0);
  } else if (error is BdkError_Psbt) {
    return PsbtException(message: error.field0);
  } else if (error is BdkError_PsbtParse) {
    return PsbtParseException(message: error.field0);
  } else if (error is BdkError_Electrum) {
    return ElectrumException(message: error.field0);
  } else if (error is BdkError_Esplora) {
    return EsploraException(message: error.field0);
  } else if (error is BdkError_Sled) {
    return SledException(message: error.field0);
  } else if (error is BdkError_Rpc) {
    return RpcException(message: error.field0);
  } else if (error is BdkError_Rusqlite) {
    return RusqliteException(message: error.field0);
  } else if (error is BdkError_Consensus) {
    return mapConsensusError(error.field0);
  } else if (error is BdkError_Address) {
    return mapAddressError(error.field0);
  } else if (error is BdkError_Bip39) {
    return Bip39Exception(message: error.field0);
  } else if (error is BdkError_InvalidInput) {
    return InvalidInputException(message: error.field0);
  } else if (error is BdkError_InvalidLockTime) {
    return InvalidLockTimeException(message: error.field0);
  } else if (error is BdkError_InvalidTransaction) {
    return InvalidTransactionException(message: error.field0);
  } else if (error is BdkError_VerifyTransaction) {
    return VerifyTransactionException(message: error.field0);
  }
  return GenericException(message: "Unknown BDK error");
}
