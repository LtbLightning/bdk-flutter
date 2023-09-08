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

class InvalidByteException extends BdkFfiException {
  InvalidByteException({super.message, super.type});
}

class OutputBelowDustLimitException extends BdkFfiException {
  OutputBelowDustLimitException({super.message, super.type});
}

class PsbtException extends BdkFfiException {
  PsbtException({super.message, super.type});
}

class GenericException extends BdkFfiException {
  GenericException({super.message, super.type});
}

class Bip32Exception extends BdkFfiException {
  Bip32Exception({super.message, super.type});
}

class NoRecipientsException extends BdkFfiException {
  NoRecipientsException({super.message, super.type});
}

class ScriptDoesntHaveAddressFormException extends BdkFfiException {
  ScriptDoesntHaveAddressFormException({super.message, super.type});
}

class NoUtxosSelectedException extends BdkFfiException {
  NoUtxosSelectedException({super.message, super.type});
}

class BnBTotalTriesExceededException extends BdkFfiException {
  BnBTotalTriesExceededException({super.message, super.type});
}

class BnBNoExactMatchException extends BdkFfiException {
  BnBNoExactMatchException({super.message, super.type});
}

///Trying to replace a tx that has a sequence >= 0xFFFFFFFE
class IrreplaceableTransactionException extends BdkFfiException {
  IrreplaceableTransactionException({super.message, super.type});
}

///Error while working with keys
class KeyException extends BdkFfiException {
  KeyException({super.message, super.type});
}

///Spending policy is not compatible with this KeychainKind
class SpendingPolicyRequiredException extends BdkFfiException {
  SpendingPolicyRequiredException({super.message, super.type});
}

class VerificationException extends BdkFfiException {
  VerificationException({super.message, super.type});
}

///Progress value must be between 0.0 (included) and 100.0 (included)
class InvalidProgressValueException extends BdkFfiException {
  InvalidProgressValueException({super.message, super.type});
}

///Progress update error (maybe the channel has been closed)
class ProgressUpdateException extends BdkFfiException {
  ProgressUpdateException({super.message, super.type});
}

///Requested outpoint doesn’t exist in the tx (vout greater than available outputs)
class InvalidOutpointException extends BdkFfiException {
  InvalidOutpointException({super.message, super.type});
}

class EncodeException extends BdkFfiException {
  EncodeException({super.message, super.type});
}

class MiniscriptPsbtException extends BdkFfiException {
  MiniscriptPsbtException({super.message, super.type});
}

class SignerException extends BdkFfiException {
  SignerException({super.message, super.type});
}

//Error while extracting and manipulating policies
class InvalidPolicyPathException extends BdkFfiException {
  InvalidPolicyPathException({super.message, super.type});
}

class MissingKeyOriginException extends BdkFfiException {
  MissingKeyOriginException({super.message, super.type});
}

class UnknownUtxoException extends BdkFfiException {
  UnknownUtxoException({super.message, super.type});
}

///Happens when trying to bump a transaction that is already confirmed
class TransactionNotFoundException extends BdkFfiException {
  TransactionNotFoundException({super.message, super.type});
}

///Node doesn’t have data to estimate a fee rate
class FeeRateUnavailableException extends BdkFfiException {
  FeeRateUnavailableException({super.message, super.type});
}

///Descriptor checksum mismatch
class ChecksumMismatchException extends BdkFfiException {
  ChecksumMismatchException({super.message, super.type});
}

///sync attempt failed due to missing scripts in cache which are needed to satisfy stopGap.
class MissingCachedScriptsException extends BdkFfiException {
  MissingCachedScriptsException({super.message, super.type});
}

///Wallet’s UTXO set is not enough to cover recipient’s requested plus fee
class InsufficientFundsException extends BdkFfiException {
  InsufficientFundsException({super.message, super.type});
}

///When bumping a tx the fee rate requested is lower than required
class FeeRateTooLowException extends BdkFfiException {
  FeeRateTooLowException({super.message, super.type});
}

///When bumping a tx the absolute fee requested is lower than replaced tx absolute fee
class FeeTooLowException extends BdkFfiException {
  FeeTooLowException({super.message, super.type});
}

///Sled database error
class SledException extends BdkFfiException {
  SledException({super.message, super.type});
}

///Error related to the parsing and usage of descriptors
class DescriptorException extends BdkFfiException {
  DescriptorException({super.message, super.type});
}

///Miniscript error
class MiniscriptException extends BdkFfiException {
  MiniscriptException({super.message, super.type});
}

///Esplora Client error
class EsploraException extends BdkFfiException {
  EsploraException({super.message, super.type});
}

class Secp256k1Exception extends BdkFfiException {
  Secp256k1Exception({super.message, super.type});
}

class TransactionConfirmedException extends BdkFfiException {
  TransactionConfirmedException({super.message, super.type});
}

class ElectrumException extends BdkFfiException {
  ElectrumException({super.message, super.type});
}

class RpcException extends BdkFfiException {
  RpcException({super.message, super.type});
}

class RusqliteException extends BdkFfiException {
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
