abstract class BdkFfiException implements Exception {
  String? message;
  String? type;
  BdkFfiException({this.message, this.type});
  @override
  String toString() => (type != null && message != null)
      ? '$type${message!.split(type!).last}'
      : (message != null)
          ? message!
          : 'Unexpected Error';
}

/// Exception thrown when trying to add an invalid byte value, or empty list to txBuilder.addData
class InvalidByteException extends BdkFfiException {
  /// Constructs the [InvalidByteException]
  InvalidByteException({super.message, super.type});
}

/// Exception thrown when output created is under the dust limit, 546 sats
class OutputBelowDustLimitException extends BdkFfiException {
  /// Constructs the [OutputBelowDustLimitException]
  OutputBelowDustLimitException({super.message, super.type});
}

/// Exception thrown when a there is an error in Partially signed bitcoin transaction
class PsbtException extends BdkFfiException {
  /// Constructs the [PsbtException]
  PsbtException({super.message, super.type});
}

class GenericException extends BdkFfiException {
  /// Constructs the [GenericException]
  GenericException({super.message, super.type});
}

class Bip32Exception extends BdkFfiException {
  /// Constructs the [Bip32Exception]
  Bip32Exception({super.message, super.type});
}

/// Exception thrown when a tx is build without recipients
class NoRecipientsException extends BdkFfiException {
  /// Constructs the [NoRecipientsException]
  NoRecipientsException({super.message, super.type});
}

/// Exception thrown when trying to convert Bare and Public key script to address
class ScriptDoesntHaveAddressFormException extends BdkFfiException {
  /// Constructs the [ScriptDoesntHaveAddressFormException]
  ScriptDoesntHaveAddressFormException({super.message, super.type});
}

/// Exception thrown when manuallySelectedOnly() is called but no utxos has been passed
class NoUtxosSelectedException extends BdkFfiException {
  /// Constructs the [NoUtxosSelectedException]
  NoUtxosSelectedException({super.message, super.type});
}

/// Branch and bound coin selection possible attempts with sufficiently big UTXO set could grow exponentially,
/// thus a limit is set, and when hit, this exception is thrown
class BnBTotalTriesExceededException extends BdkFfiException {
  /// Constructs the [BnBTotalTriesExceededException]
  BnBTotalTriesExceededException({super.message, super.type});
}

///Branch and bound coin selection tries to avoid needing a change by finding the right inputs for the desired outputs plus fee,
/// if there is not such combination this exception is thrown
class BnBNoExactMatchException extends BdkFfiException {
  /// Constructs the [BnBNoExactMatchException]
  BnBNoExactMatchException({super.message, super.type});
}

///Exception thrown when trying to replace a tx that has a sequence >= 0xFFFFFFFE
class IrreplaceableTransactionException extends BdkFfiException {
  /// Constructs the [IrreplaceableTransactionException]
  IrreplaceableTransactionException({super.message, super.type});
}

///Exception thrown when the keys are invalid
class KeyException extends BdkFfiException {
  /// Constructs the [KeyException]
  KeyException({super.message, super.type});
}

///Exception thrown when spending policy is not compatible with this KeychainKind
class SpendingPolicyRequiredException extends BdkFfiException {
  /// Constructs the [SpendingPolicyRequiredException]
  SpendingPolicyRequiredException({super.message, super.type});
}

///Transaction verification Exception
class VerificationException extends BdkFfiException {
  /// Constructs the [VerificationException]
  VerificationException({super.message, super.type});
}

///Exception thrown when progress value is not between 0.0 (included) and 100.0 (included)
class InvalidProgressValueException extends BdkFfiException {
  /// Constructs the [InvalidProgressValueException]
  InvalidProgressValueException({super.message, super.type});
}

///Progress update error (maybe the channel has been closed)
class ProgressUpdateException extends BdkFfiException {
  /// Constructs the [ProgressUpdateException]
  ProgressUpdateException({super.message, super.type});
}

///Exception thrown when the requested outpoint doesn’t exist in the tx (vout greater than available outputs)
class InvalidOutpointException extends BdkFfiException {
  /// Constructs the [InvalidOutpointException]
  InvalidOutpointException({super.message, super.type});
}

class EncodeException extends BdkFfiException {
  /// Constructs the [EncodeException]
  EncodeException({super.message, super.type});
}

class MiniscriptPsbtException extends BdkFfiException {
  /// Constructs the [MiniscriptPsbtException]
  MiniscriptPsbtException({super.message, super.type});
}

class SignerException extends BdkFfiException {
  /// Constructs the [SignerException]
  SignerException({super.message, super.type});
}

//Exception thrown when there is an error while extracting and manipulating policies
class InvalidPolicyPathException extends BdkFfiException {
  /// Constructs the [InvalidPolicyPathException]
  InvalidPolicyPathException({super.message, super.type});
}

class MissingKeyOriginException extends BdkFfiException {
  /// Constructs the [MissingKeyOriginException]
  MissingKeyOriginException({super.message, super.type});
}

///Exception thrown when trying to spend an UTXO that is not in the internal database
class UnknownUtxoException extends BdkFfiException {
  /// Constructs the [UnknownUtxoException]
  UnknownUtxoException({super.message, super.type});
}

///Exception thrown when trying to bump a transaction that is already confirmed
class TransactionNotFoundException extends BdkFfiException {
  /// Constructs the [TransactionNotFoundException]
  TransactionNotFoundException({super.message, super.type});
}

///Exception thrown when node doesn’t have data to estimate a fee rate
class FeeRateUnavailableException extends BdkFfiException {
  /// Constructs the [FeeRateUnavailableException]
  FeeRateUnavailableException({super.message, super.type});
}

///Exception thrown when the descriptor checksum mismatch
class ChecksumMismatchException extends BdkFfiException {
  /// Constructs the [ChecksumMismatchException]
  ChecksumMismatchException({super.message, super.type});
}

///Exception thrown when sync attempt failed due to missing scripts in cache which are needed to satisfy stopGap.
class MissingCachedScriptsException extends BdkFfiException {
  /// Constructs the [MissingCachedScriptsException]
  MissingCachedScriptsException({super.message, super.type});
}

///Exception thrown when wallet’s UTXO set is not enough to cover recipient’s requested plus fee
class InsufficientFundsException extends BdkFfiException {
  /// Constructs the [InsufficientFundsException]
  InsufficientFundsException({super.message, super.type});
}

///Exception thrown when bumping a tx, the fee rate requested is lower than required
class FeeRateTooLowException extends BdkFfiException {
  /// Constructs the [FeeRateTooLowException]
  FeeRateTooLowException({super.message, super.type});
}

///Exception thrown when bumping a tx, the absolute fee requested is lower than replaced tx absolute fee
class FeeTooLowException extends BdkFfiException {
  /// Constructs the [FeeTooLowException]
  FeeTooLowException({super.message, super.type});
}

///Sled database error
class SledException extends BdkFfiException {
  /// Constructs the [SledException]
  SledException({super.message, super.type});
}

///Exception thrown when there is an error in parsing and usage of descriptors
class DescriptorException extends BdkFfiException {
  /// Constructs the [DescriptorException]
  DescriptorException({super.message, super.type});
}

///Miniscript exception
class MiniscriptException extends BdkFfiException {
  /// Constructs the [MiniscriptException]
  MiniscriptException({super.message, super.type});
}

///Esplora Client exception
class EsploraException extends BdkFfiException {
  /// Constructs the [EsploraException]
  EsploraException({super.message, super.type});
}

class Secp256k1Exception extends BdkFfiException {
  /// Constructs the [ Secp256k1Exception]
  Secp256k1Exception({super.message, super.type});
}

///Exception thrown when trying to bump a transaction that is already confirmed
class TransactionConfirmedException extends BdkFfiException {
  /// Constructs the [TransactionConfirmedException]
  TransactionConfirmedException({super.message, super.type});
}

class ElectrumException extends BdkFfiException {
  /// Constructs the [ElectrumException]
  ElectrumException({super.message, super.type});
}

class RpcException extends BdkFfiException {
  /// Constructs the [RpcException]
  RpcException({super.message, super.type});
}

class RusqliteException extends BdkFfiException {
  /// Constructs the [RusqliteException]
  RusqliteException({super.message, super.type});
}

handleException(String e) {
  if (e.contains("Generic")) {
    return GenericException(message: e, type: 'Generic');
  } else if (e.contains('NoRecipients')) {
    return NoRecipientsException(message: e, type: 'NoRecipients');
  } else if (e.contains('ScriptDoesntHaveAddressForm')) {
    return ScriptDoesntHaveAddressFormException(
        message: e, type: 'ScriptDoesntHaveAddressForm');
  } else if (e.contains('NoUtxosSelected')) {
    return NoUtxosSelectedException(message: e, type: 'NoUtxosSelected');
  } else if (e.contains('OutputBelowDustLimit')) {
    return OutputBelowDustLimitException(
        message: e, type: 'OutputBelowDustLimit');
  } else if (e.contains('BnBTotalTriesExceeded')) {
    return BnBTotalTriesExceededException(
        message: e, type: 'BnBTotalTriesExceeded');
  } else if (e.contains('BnBNoExactMatch')) {
    return BnBNoExactMatchException(message: e, type: 'BnBNoExactMatch');
  } else if (e.contains('UnknownUtxo')) {
    return UnknownUtxoException(message: e, type: 'UnknownUtxo');
  } else if (e.contains('TransactionNotFound')) {
    return TransactionNotFoundException(
        message: e, type: 'TransactionNotFound');
  } else if (e.contains('TransactionConfirmed')) {
    return TransactionConfirmedException(
        message: e, type: 'TransactionConfirmed');
  } else if (e.contains('FeeRateUnavailable')) {
    return FeeRateUnavailableException(message: e, type: 'FeeRateUnavailable');
  } else if (e.contains('ChecksumMismatch')) {
    return ChecksumMismatchException(message: e, type: 'ChecksumMismatch');
  } else if (e.contains('MissingCachedScripts')) {
    return MissingCachedScriptsException(
        message: e, type: 'MissingCachedScripts');
  } else if (e.contains('InsufficientFunds')) {
    return InsufficientFundsException(message: e, type: 'InsufficientFunds');
  } else if (e.contains('FeeRateTooLow')) {
    return FeeRateTooLowException(message: e, type: 'FeeRateTooLow');
  } else if (e.contains('FeeTooLow')) {
    return FeeTooLowException(message: e, type: 'FeeTooLow');
  } else if (e.contains('Sled')) {
    return SledException(message: e, type: 'Sled');
  } else if (e.contains('Descriptor')) {
    return DescriptorException(message: e, type: 'Descriptor');
  } else if (e.contains('Miniscript')) {
    return MiniscriptException(message: e, type: 'Miniscript');
  } else if (e.contains('Bip32')) {
    return Bip32Exception(message: e, type: 'Bip32');
  } else if (e.contains('Esplora')) {
    return EsploraException(message: e, type: 'Esplora');
  } else if (e.contains('Secp256k1')) {
    return Secp256k1Exception(message: e, type: 'Secp256k1');
  } else if (e.contains('Electrum')) {
    return ElectrumException(message: e, type: 'Electrum');
  } else if (e.contains('Rpc')) {
    return RpcException(message: e, type: 'Rpc');
  } else if (e.contains('Rusqlite')) {
    return RusqliteException(message: e, type: 'Rusqlite');
  } else {
    return Exception("Unexpected exception");
  }
}
