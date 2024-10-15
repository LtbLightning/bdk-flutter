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
  return error.when(
      invalidChar: (e) => HexException(message: "Non-hexadecimal character $e"),
      oddLengthString: (e) =>
          HexException(message: "Purported hex string had odd length $e"),
      invalidLength: (BigInt expected, BigInt found) => HexException(
          message:
              "Tried to parse fixed-length hash from a string with the wrong type; \n expected: ${expected.toString()}, found: ${found.toString()}."));
}

Exception mapAddressError(AddressError error) {
  return error.when(
      base58: (e) => AddressException(message: "Base58 encoding error: $e"),
      bech32: (e) => AddressException(message: "Bech32 encoding error: $e"),
      emptyBech32Payload: () =>
          AddressException(message: "The bech32 payload was empty."),
      invalidBech32Variant: (e, f) => AddressException(
          message:
              "Invalid bech32 variant: The wrong checksum algorithm was used. See BIP-0350; \n expected:$e, found: $f "),
      invalidWitnessVersion: (e) => AddressException(
          message:
              "Invalid witness version script: $e, version must be 0 to 16 inclusive."),
      unparsableWitnessVersion: (e) => AddressException(
          message: "Unable to parse witness version from string: $e"),
      malformedWitnessVersion: () => AddressException(
          message:
              "Bitcoin script opcode does not match any known witness version, the script is malformed."),
      invalidWitnessProgramLength: (e) => AddressException(
          message:
              "Invalid witness program length: $e, The witness program must be between 2 and 40 bytes in length."),
      invalidSegwitV0ProgramLength: (e) => AddressException(
          message:
              "Invalid segwitV0 program length: $e, A v0 witness program must be either of length 20 or 32."),
      uncompressedPubkey: () => AddressException(
          message: "An uncompressed pubkey was used where it is not allowed."),
      excessiveScriptSize: () => AddressException(
          message: "Address size more than 520 bytes is not allowed."),
      unrecognizedScript: () => AddressException(
          message:
              "Unrecognized script: Script is not a p2pkh, p2sh or witness program."),
      unknownAddressType: (e) => AddressException(
          message: "Unknown address type: $e, Address type is either invalid or not supported in rust-bitcoin."),
      networkValidation: (required, found, _) => AddressException(message: "Address’s network differs from required one; \n required: $required, found: $found "));
}

Exception mapDescriptorError(DescriptorError error) {
  return error.when(
    invalidHdKeyPath: () => DescriptorException(
        message:
            "Invalid HD Key path, such as having a wildcard but a length != 1"),
    invalidDescriptorChecksum: () => DescriptorException(
        message: "The provided descriptor doesn’t match its checksum"),
    hardenedDerivationXpub: () => DescriptorException(
        message: "The provided descriptor doesn’t match its checksum"),
    multiPath: () =>
        DescriptorException(message: "The descriptor contains multipath keys"),
    key: (e) => KeyException(message: e),
    policy: (e) => DescriptorException(
        message: "Error while extracting and manipulating policies: $e"),
    bip32: (e) => Bip32Exception(message: e),
    base58: (e) =>
        DescriptorException(message: "Error during base58 decoding: $e"),
    pk: (e) => KeyException(message: e),
    miniscript: (e) => MiniscriptException(message: e),
    hex: (e) => HexException(message: e),
    invalidDescriptorCharacter: (e) => DescriptorException(
        message: "Invalid byte found in the descriptor checksum: $e"),
  );
}

Exception mapConsensusError(ConsensusError error) {
  return error.when(
      io: (e) => ConsensusException(message: "I/O error: $e"),
      oversizedVectorAllocation: (e, f) => ConsensusException(
          message:
              "Tried to allocate an oversized vector. The capacity requested: $e, found: $f "),
      invalidChecksum: (e, f) => ConsensusException(
          message:
              "Checksum was invalid, expected: ${e.toString()}, actual:${f.toString()}"),
      nonMinimalVarInt: () => ConsensusException(
          message: "VarInt was encoded in a non-minimal way."),
      parseFailed: (e) => ConsensusException(message: "Parsing error: $e"),
      unsupportedSegwitFlag: (e) =>
          ConsensusException(message: "Unsupported segwit flag $e"));
}

Exception mapBdkError(BdkError error) {
  return error.when(
    noUtxosSelected: () => NoUtxosSelectedException(
        message:
            "manuallySelectedOnly option is selected but no utxo has been passed"),
    invalidU32Bytes: (e) => InvalidByteException(
        message:
            'Wrong number of bytes found when trying to convert the bytes, ${e.toString()}'),
    generic: (e) => GenericException(message: e),
    scriptDoesntHaveAddressForm: () => ScriptDoesntHaveAddressFormException(),
    noRecipients: () => NoRecipientsException(
        message: "Failed to build a transaction without recipients"),
    outputBelowDustLimit: (e) => OutputBelowDustLimitException(
        message:
            'Output created is under the dust limit (546 sats). Output value: ${e.toString()}'),
    insufficientFunds: (needed, available) => InsufficientFundsException(
        message:
            "Wallet's UTXO set is not enough to cover recipient's requested plus fee; \n Needed: $needed, Available: $available"),
    bnBTotalTriesExceeded: () => BnBTotalTriesExceededException(
        message:
            "Utxo branch and bound coin selection attempts have reached its limit"),
    bnBNoExactMatch: () => BnBNoExactMatchException(
        message:
            "Utxo branch and bound coin selection failed to find the correct inputs for the desired outputs."),
    unknownUtxo: () => UnknownUtxoException(
        message: "Utxo not found in the internal database"),
    transactionNotFound: () => TransactionNotFoundException(),
    transactionConfirmed: () => TransactionConfirmedException(),
    irreplaceableTransaction: () => IrreplaceableTransactionException(
        message:
            "Trying to replace the transaction that has a sequence >= 0xFFFFFFFE"),
    feeRateTooLow: (e) => FeeRateTooLowException(
        message:
            "The Fee rate requested is lower than required. Required: ${e.toString()}"),
    feeTooLow: (e) => FeeTooLowException(
        message:
            "The absolute fee requested is lower than replaced tx's absolute fee; \n Required: ${e.toString()}"),
    feeRateUnavailable: () => FeeRateUnavailableException(
        message: "Node doesn't have data to estimate a fee rate"),
    missingKeyOrigin: (e) => MissingKeyOriginException(message: e.toString()),
    key: (e) => KeyException(message: e.toString()),
    checksumMismatch: () => ChecksumMismatchException(),
    spendingPolicyRequired: (e) => SpendingPolicyRequiredException(
        message: "Spending policy is not compatible with: ${e.toString()}"),
    invalidPolicyPathError: (e) =>
        InvalidPolicyPathException(message: e.toString()),
    signer: (e) => SignerException(message: e.toString()),
    invalidNetwork: (requested, found) => InvalidNetworkException(
        message: 'Requested; $requested, Found: $found'),
    invalidOutpoint: (e) => InvalidOutpointException(
        message:
            "${e.toString()} doesn’t exist in the tx (vout greater than available outputs)"),
    descriptor: (e) => mapDescriptorError(e),
    encode: (e) => EncodeException(message: e.toString()),
    miniscript: (e) => MiniscriptException(message: e.toString()),
    miniscriptPsbt: (e) => MiniscriptPsbtException(message: e.toString()),
    bip32: (e) => Bip32Exception(message: e.toString()),
    secp256K1: (e) => Secp256k1Exception(message: e.toString()),
    missingCachedScripts: (missingCount, lastCount) =>
        MissingCachedScriptsException(
            message:
                'Sync attempt failed due to missing scripts in cache which are needed to satisfy stop_gap; \n MissingCount: $missingCount, LastCount: $lastCount '),
    json: (e) => JsonException(message: e.toString()),
    hex: (e) => mapHexError(e),
    psbt: (e) => PsbtException(message: e.toString()),
    psbtParse: (e) => PsbtParseException(message: e.toString()),
    electrum: (e) => ElectrumException(message: e.toString()),
    esplora: (e) => EsploraException(message: e.toString()),
    sled: (e) => SledException(message: e.toString()),
    rpc: (e) => RpcException(message: e.toString()),
    rusqlite: (e) => RusqliteException(message: e.toString()),
    consensus: (e) => mapConsensusError(e),
    address: (e) => mapAddressError(e),
    bip39: (e) => Bip39Exception(message: e.toString()),
    invalidInput: (e) => InvalidInputException(message: e),
    invalidLockTime: (e) => InvalidLockTimeException(message: e),
    invalidTransaction: (e) => InvalidTransactionException(message: e),
    verifyTransaction: (e) => VerifyTransactionException(message: e),
  );
}
