import 'package:bdk_flutter/src/generated/api/error.dart';

abstract class BdkFfiException implements Exception {
  String? errorMessage;
  String code;
  BdkFfiException({this.errorMessage, required this.code});
  @override
  String toString() => (errorMessage != null)
      ? '$runtimeType( code:$code, error:$errorMessage )'
      : runtimeType.toString();
}

/// Exception thrown when parsing an address
class AddressParseException extends BdkFfiException {
  /// Constructs the [AddressParseException]
  AddressParseException({super.errorMessage, required super.code});
}

Exception mapAddressParseError(AddressParseError error) {
  return error.when(
      base58: () => AddressParseException(
          code: "Base58", errorMessage: "base58 address encoding error"),
      bech32: () => AddressParseException(
          code: "Bech32", errorMessage: "bech32 address encoding error"),
      witnessVersion: (e) => AddressParseException(
          code: "WitnessVersion",
          errorMessage: "witness version conversion/parsing error:$e"),
      witnessProgram: (e) => AddressParseException(
          code: "WitnessProgram", errorMessage: "witness program error:$e"),
      unknownHrp: () => AddressParseException(
          code: "UnknownHrp", errorMessage: "tried to parse an unknown hrp"),
      legacyAddressTooLong: () => AddressParseException(
          code: "LegacyAddressTooLong",
          errorMessage: "legacy address base58 string"),
      invalidBase58PayloadLength: () => AddressParseException(
          code: "InvalidBase58PayloadLength",
          errorMessage: "legacy address base58 data"),
      invalidLegacyPrefix: () => AddressParseException(
          code: "InvalidLegacyPrefix",
          errorMessage: "segwit address bech32 string"),
      networkValidation: () => AddressParseException(code: "NetworkValidation"),
      otherAddressParseErr: () =>
          AddressParseException(code: "OtherAddressParseErr"));
}

class Bip32Exception extends BdkFfiException {
  /// Constructs the [Bip32Exception]
  Bip32Exception({super.errorMessage, required super.code});
}

Exception mapBip32Error(Bip32Error error) {
  return error.when(
      cannotDeriveFromHardenedKey: () =>
          Bip32Exception(code: "CannotDeriveFromHardenedKey"),
      secp256K1: (e) => Bip32Exception(code: "Secp256k1", errorMessage: e),
      invalidChildNumber: (e) => Bip32Exception(
          code: "InvalidChildNumber", errorMessage: "invalid child number: $e"),
      invalidChildNumberFormat: () =>
          Bip32Exception(code: "InvalidChildNumberFormat"),
      invalidDerivationPathFormat: () =>
          Bip32Exception(code: "InvalidDerivationPathFormat"),
      unknownVersion: (e) =>
          Bip32Exception(code: "UnknownVersion", errorMessage: e),
      wrongExtendedKeyLength: (e) => Bip32Exception(
          code: "WrongExtendedKeyLength", errorMessage: e.toString()),
      base58: (e) => Bip32Exception(code: "Base58", errorMessage: e),
      hex: (e) =>
          Bip32Exception(code: "HexadecimalConversion", errorMessage: e),
      invalidPublicKeyHexLength: (e) =>
          Bip32Exception(code: "InvalidPublicKeyHexLength", errorMessage: "$e"),
      unknownError: (e) =>
          Bip32Exception(code: "UnknownError", errorMessage: e));
}

class Bip39Exception extends BdkFfiException {
  /// Constructs the [Bip39Exception]
  Bip39Exception({super.errorMessage, required super.code});
}

Exception mapBip39Error(Bip39Error error) {
  return error.when(
      badWordCount: (e) => Bip39Exception(
          code: "BadWordCount",
          errorMessage: "the word count ${e.toString()} is not supported"),
      unknownWord: (e) => Bip39Exception(
          code: "UnknownWord",
          errorMessage: "unknown word at index ${e.toString()} "),
      badEntropyBitCount: (e) => Bip39Exception(
          code: "BadEntropyBitCount",
          errorMessage: "entropy bit count ${e.toString()} is invalid"),
      invalidChecksum: () => Bip39Exception(code: "InvalidChecksum"),
      ambiguousLanguages: (e) => Bip39Exception(
          code: "AmbiguousLanguages",
          errorMessage: "ambiguous languages detected: ${e.toString()}"));
}

class CalculateFeeException extends BdkFfiException {
  /// Constructs the [ CalculateFeeException]
  CalculateFeeException({super.errorMessage, required super.code});
}

CalculateFeeException mapCalculateFeeError(CalculateFeeError error) {
  return error.when(
    generic: (e) =>
        CalculateFeeException(code: "Unknown", errorMessage: e.toString()),
    missingTxOut: (e) => CalculateFeeException(
        code: "MissingTxOut",
        errorMessage: "missing transaction output:  ${e.toString()}"),
    negativeFee: (e) => CalculateFeeException(
        code: "NegativeFee", errorMessage: "value:  ${e.toString()}"),
  );
}

class CannotConnectException extends BdkFfiException {
  /// Constructs the [ CannotConnectException]
  CannotConnectException({super.errorMessage, required super.code});
}

CannotConnectException mapCannotConnectError(CannotConnectError error) {
  return error.when(
    include: (e) => CannotConnectException(
        code: "Include",
        errorMessage: "cannot include height:  ${e.toString()}"),
  );
}

class CreateTxException extends BdkFfiException {
  /// Constructs the [ CreateTxException]
  CreateTxException({super.errorMessage, required super.code});
}

CreateTxException mapCreateTxError(CreateTxError error) {
  return error.when(
      generic: (e) =>
          CreateTxException(code: "Unknown", errorMessage: e.toString()),
      descriptor: (e) =>
          CreateTxException(code: "Descriptor", errorMessage: e.toString()),
      policy: (e) =>
          CreateTxException(code: "Policy", errorMessage: e.toString()),
      spendingPolicyRequired: (e) => CreateTxException(
          code: "SpendingPolicyRequired",
          errorMessage: "spending policy required for: ${e.toString()}"),
      version0: () => CreateTxException(
          code: "Version0", errorMessage: "unsupported version 0"),
      version1Csv: () => CreateTxException(
          code: "Version1Csv", errorMessage: "unsupported version 1 with csv"),
      lockTime: (requested, required) => CreateTxException(
          code: "LockTime",
          errorMessage:
              "lock time conflict: requested $requested, but required $required"),
      rbfSequence: () => CreateTxException(
          code: "RbfSequence",
          errorMessage: "transaction requires rbf sequence number"),
      rbfSequenceCsv: (rbf, csv) => CreateTxException(
          code: "RbfSequenceCsv",
          errorMessage: "rbf sequence: $rbf, csv sequence: $csv"),
      feeTooLow: (e) => CreateTxException(
          code: "FeeTooLow",
          errorMessage: "fee too low: required ${e.toString()}"),
      feeRateTooLow: (e) => CreateTxException(
          code: "FeeRateTooLow",
          errorMessage: "fee rate too low: ${e.toString()}"),
      noUtxosSelected: () => CreateTxException(
          code: "NoUtxosSelected",
          errorMessage: "no utxos selected for the transaction"),
      outputBelowDustLimit: (e) => CreateTxException(
          code: "OutputBelowDustLimit",
          errorMessage: "output value below dust limit at index $e"),
      changePolicyDescriptor: () => CreateTxException(
          code: "ChangePolicyDescriptor",
          errorMessage: "change policy descriptor error"),
      coinSelection: (e) => CreateTxException(
          code: "CoinSelectionFailed", errorMessage: e.toString()),
      insufficientFunds: (needed, available) => CreateTxException(code: "InsufficientFunds", errorMessage: "insufficient funds: needed $needed sat, available $available sat"),
      noRecipients: () => CreateTxException(code: "NoRecipients", errorMessage: "transaction has no recipients"),
      psbt: (e) => CreateTxException(code: "Psbt", errorMessage: "spending policy required for: ${e.toString()}"),
      missingKeyOrigin: (e) => CreateTxException(code: "MissingKeyOrigin", errorMessage: "missing key origin for: ${e.toString()}"),
      unknownUtxo: (e) => CreateTxException(code: "UnknownUtxo", errorMessage: "reference to an unknown utxo: ${e.toString()}"),
      missingNonWitnessUtxo: (e) => CreateTxException(code: "MissingNonWitnessUtxo", errorMessage: "missing non-witness utxo for outpoint:${e.toString()}"),
      miniscriptPsbt: (e) => CreateTxException(code: "MiniscriptPsbt", errorMessage: e.toString()));
}

class CreateWithPersistException extends BdkFfiException {
  /// Constructs the [ CreateWithPersistException]
  CreateWithPersistException({super.errorMessage, required super.code});
}

CreateWithPersistException mapCreateWithPersistError(
    CreateWithPersistError error) {
  return error.when(
      persist: (e) => CreateWithPersistException(
          code: "SqlitePersist", errorMessage: e.toString()),
      dataAlreadyExists: () => CreateWithPersistException(
          code: "DataAlreadyExists",
          errorMessage: "the wallet has already been created"),
      descriptor: (e) => CreateWithPersistException(
          code: "Descriptor",
          errorMessage:
              "the loaded changeset cannot construct wallet: ${e.toString()}"));
}

class DescriptorException extends BdkFfiException {
  /// Constructs the [ DescriptorException]
  DescriptorException({super.errorMessage, required super.code});
}

DescriptorException mapDescriptorError(DescriptorError error) {
  return error.when(
      invalidHdKeyPath: () => DescriptorException(code: "InvalidHdKeyPath"),
      missingPrivateData: () => DescriptorException(
          code: "MissingPrivateData",
          errorMessage: "the extended key does not contain private data"),
      invalidDescriptorChecksum: () => DescriptorException(
          code: "InvalidDescriptorChecksum",
          errorMessage: "the provided descriptor doesn't match its checksum"),
      hardenedDerivationXpub: () => DescriptorException(
          code: "HardenedDerivationXpub",
          errorMessage:
              "the descriptor contains hardened derivation steps on public extended keys"),
      multiPath: () => DescriptorException(
          code: "MultiPath",
          errorMessage:
              "the descriptor contains multipath keys, which are not supported yet"),
      key: (e) => DescriptorException(code: "Key", errorMessage: e),
      generic: (e) => DescriptorException(code: "Unknown", errorMessage: e),
      policy: (e) => DescriptorException(code: "Policy", errorMessage: e),
      invalidDescriptorCharacter: (e) => DescriptorException(
          code: "InvalidDescriptorCharacter",
          errorMessage: "invalid descriptor character: $e"),
      bip32: (e) => DescriptorException(code: "Bip32", errorMessage: e),
      base58: (e) => DescriptorException(code: "Base58", errorMessage: e),
      pk: (e) => DescriptorException(code: "PrivateKey", errorMessage: e),
      miniscript: (e) =>
          DescriptorException(code: "Miniscript", errorMessage: e),
      hex: (e) => DescriptorException(code: "HexDecoding", errorMessage: e),
      externalAndInternalAreTheSame: () => DescriptorException(
          code: "ExternalAndInternalAreTheSame",
          errorMessage: "external and internal descriptors are the same"));
}

class DescriptorKeyException extends BdkFfiException {
  /// Constructs the [ DescriptorKeyException]
  DescriptorKeyException({super.errorMessage, required super.code});
}

DescriptorKeyException mapDescriptorKeyError(DescriptorKeyError error) {
  return error.when(
      parse: (e) =>
          DescriptorKeyException(code: "ParseFailed", errorMessage: e),
      invalidKeyType: () => DescriptorKeyException(
            code: "InvalidKeyType",
          ),
      bip32: (e) => DescriptorKeyException(code: "Bip32", errorMessage: e));
}

class ElectrumException extends BdkFfiException {
  /// Constructs the [ ElectrumException]
  ElectrumException({super.errorMessage, required super.code});
}

ElectrumException mapElectrumError(ElectrumError error) {
  return error.when(
      ioError: (e) => ElectrumException(code: "IoError", errorMessage: e),
      json: (e) => ElectrumException(code: "Json", errorMessage: e),
      hex: (e) => ElectrumException(code: "Hex", errorMessage: e),
      protocol: (e) =>
          ElectrumException(code: "ElectrumProtocol", errorMessage: e),
      bitcoin: (e) => ElectrumException(code: "Bitcoin", errorMessage: e),
      alreadySubscribed: () => ElectrumException(
          code: "AlreadySubscribed",
          errorMessage:
              "already subscribed to the notifications of an address"),
      notSubscribed: () => ElectrumException(
          code: "NotSubscribed",
          errorMessage: "not subscribed to the notifications of an address"),
      invalidResponse: (e) => ElectrumException(
          code: "InvalidResponse",
          errorMessage:
              "error during the deserialization of a response from the server: $e"),
      message: (e) => ElectrumException(code: "Message", errorMessage: e),
      invalidDnsNameError: (e) => ElectrumException(
          code: "InvalidDNSNameError",
          errorMessage: "invalid domain name $e not matching SSL certificate"),
      missingDomain: () => ElectrumException(
          code: "MissingDomain",
          errorMessage:
              "missing domain while it was explicitly asked to validate it"),
      allAttemptsErrored: () => ElectrumException(
          code: "AllAttemptsErrored",
          errorMessage: "made one or multiple attempts, all errored"),
      sharedIoError: (e) =>
          ElectrumException(code: "SharedIOError", errorMessage: e),
      couldntLockReader: () => ElectrumException(
          code: "CouldntLockReader",
          errorMessage:
              "couldn't take a lock on the reader mutex. This means that there's already another reader thread is running"),
      mpsc: () => ElectrumException(
          code: "Mpsc",
          errorMessage:
              "broken IPC communication channel: the other thread probably has exited"),
      couldNotCreateConnection: (e) =>
          ElectrumException(code: "CouldNotCreateConnection", errorMessage: e),
      requestAlreadyConsumed: () =>
          ElectrumException(code: "RequestAlreadyConsumed"));
}

class EsploraException extends BdkFfiException {
  /// Constructs the [ EsploraException]
  EsploraException({super.errorMessage, required super.code});
}

EsploraException mapEsploraError(EsploraError error) {
  return error.when(
      minreq: (e) => EsploraException(code: "Minreq", errorMessage: e),
      httpResponse: (s, e) => EsploraException(
          code: "HttpResponse",
          errorMessage: "http error with status code $s and message $e"),
      parsing: (e) => EsploraException(code: "ParseFailed", errorMessage: e),
      statusCode: (e) => EsploraException(
          code: "StatusCode",
          errorMessage: "invalid status code, unable to convert to u16: $e"),
      bitcoinEncoding: (e) =>
          EsploraException(code: "BitcoinEncoding", errorMessage: e),
      hexToArray: (e) => EsploraException(
          code: "HexToArrayFailed",
          errorMessage: "invalid hex data returned: $e"),
      hexToBytes: (e) => EsploraException(
          code: "HexToBytesFailed",
          errorMessage: "invalid hex data returned: $e"),
      transactionNotFound: () => EsploraException(code: "TransactionNotFound"),
      headerHeightNotFound: (e) => EsploraException(
          code: "HeaderHeightNotFound",
          errorMessage: "header height $e not found"),
      headerHashNotFound: () => EsploraException(code: "HeaderHashNotFound"),
      invalidHttpHeaderName: (e) => EsploraException(
          code: "InvalidHttpHeaderName", errorMessage: "header name: $e"),
      invalidHttpHeaderValue: (e) => EsploraException(
          code: "InvalidHttpHeaderValue", errorMessage: "header value: $e"),
      requestAlreadyConsumed: () => EsploraException(
          code: "RequestAlreadyConsumed",
          errorMessage: "the request has already been consumed"));
}

class ExtractTxException extends BdkFfiException {
  /// Constructs the [ ExtractTxException]
  ExtractTxException({super.errorMessage, required super.code});
}

ExtractTxException mapExtractTxError(ExtractTxError error) {
  return error.when(
      absurdFeeRate: (e) => ExtractTxException(
          code: "AbsurdFeeRate",
          errorMessage:
              "an absurdly high fee rate of ${e.toString()} sat/vbyte"),
      missingInputValue: () => ExtractTxException(
          code: "MissingInputValue",
          errorMessage:
              "one of the inputs lacked value information (witness_utxo or non_witness_utxo)"),
      sendingTooMuch: () => ExtractTxException(
          code: "SendingTooMuch",
          errorMessage:
              "transaction would be invalid due to output value being greater than input value"),
      otherExtractTxErr: () => ExtractTxException(
          code: "OtherExtractTxErr", errorMessage: "non-exhaustive error"));
}

class FromScriptException extends BdkFfiException {
  /// Constructs the [ FromScriptException]
  FromScriptException({super.errorMessage, required super.code});
}

FromScriptException mapFromScriptError(FromScriptError error) {
  return error.when(
    unrecognizedScript: () => FromScriptException(
        code: "UnrecognizedScript",
        errorMessage: "script is not a p2pkh, p2sh or witness program"),
    witnessProgram: (e) =>
        FromScriptException(code: "WitnessProgram", errorMessage: e),
    witnessVersion: (e) => FromScriptException(
        code: "WitnessVersionConstructionFailed", errorMessage: e),
    otherFromScriptErr: () => FromScriptException(
      code: "OtherFromScriptErr",
    ),
  );
}

class RequestBuilderException extends BdkFfiException {
  /// Constructs the [ RequestBuilderException]
  RequestBuilderException({super.errorMessage, required super.code});
}

RequestBuilderException mapRequestBuilderError(RequestBuilderError error) {
  return RequestBuilderException(code: "RequestAlreadyConsumed");
}

class LoadWithPersistException extends BdkFfiException {
  /// Constructs the [ LoadWithPersistException]
  LoadWithPersistException({super.errorMessage, required super.code});
}

LoadWithPersistException mapLoadWithPersistError(LoadWithPersistError error) {
  return error.when(
      persist: (e) => LoadWithPersistException(
          errorMessage: e, code: "SqlitePersistenceFailed"),
      invalidChangeSet: (e) => LoadWithPersistException(
          errorMessage: "the loaded changeset cannot construct wallet: $e",
          code: "InvalidChangeSet"),
      couldNotLoad: () =>
          LoadWithPersistException(code: "CouldNotLoadConnection"));
}

class PersistenceException extends BdkFfiException {
  /// Constructs the [ PersistenceException]
  PersistenceException({super.errorMessage, required super.code});
}

class PsbtException extends BdkFfiException {
  /// Constructs the [ PsbtException]
  PsbtException({super.errorMessage, required super.code});
}

PsbtException mapPsbtError(PsbtError error) {
  return error.when(
      invalidMagic: () => PsbtException(code: "InvalidMagic"),
      missingUtxo: () => PsbtException(
          code: "MissingUtxo",
          errorMessage: "UTXO information is not present in PSBT"),
      invalidSeparator: () => PsbtException(code: "InvalidSeparator"),
      psbtUtxoOutOfBounds: () => PsbtException(
          code: "PsbtUtxoOutOfBounds",
          errorMessage:
              "output index is out of bounds of non witness script output array"),
      invalidKey: (e) => PsbtException(code: "InvalidKey", errorMessage: e),
      invalidProprietaryKey: () => PsbtException(
          code: "InvalidProprietaryKey",
          errorMessage:
              "non-proprietary key type found when proprietary key was expected"),
      duplicateKey: (e) => PsbtException(code: "DuplicateKey", errorMessage: e),
      unsignedTxHasScriptSigs: () => PsbtException(
          code: "UnsignedTxHasScriptSigs",
          errorMessage: "the unsigned transaction has script sigs"),
      unsignedTxHasScriptWitnesses: () => PsbtException(
          code: "UnsignedTxHasScriptWitnesses",
          errorMessage: "the unsigned transaction has script witnesses"),
      mustHaveUnsignedTx: () => PsbtException(
          code: "MustHaveUnsignedTx",
          errorMessage:
              "partially signed transactions must have an unsigned transaction"),
      noMorePairs: () => PsbtException(
          code: "NoMorePairs",
          errorMessage: "no more key-value pairs for this psbt map"),
      unexpectedUnsignedTx: () => PsbtException(
          code: "UnexpectedUnsignedTx",
          errorMessage: "different unsigned transaction"),
      nonStandardSighashType: (e) => PsbtException(
          code: "NonStandardSighashType", errorMessage: e.toString()),
      invalidHash: (e) => PsbtException(
          code: "InvalidHash",
          errorMessage: "invalid hash when parsing slice: $e"),
      invalidPreimageHashPair: () =>
          PsbtException(code: "InvalidPreimageHashPair"),
      combineInconsistentKeySources: (e) => PsbtException(
          code: "CombineInconsistentKeySources",
          errorMessage: "combine conflict: $e"),
      consensusEncoding: (e) => PsbtException(
          code: "ConsensusEncoding",
          errorMessage: "bitcoin consensus encoding error: $e"),
      negativeFee: () => PsbtException(code: "NegativeFee", errorMessage: "PSBT has a negative fee which is not allowed"),
      feeOverflow: () => PsbtException(code: "FeeOverflow", errorMessage: "integer overflow in fee calculation"),
      invalidPublicKey: (e) => PsbtException(code: "InvalidPublicKey", errorMessage: e),
      invalidSecp256K1PublicKey: (e) => PsbtException(code: "InvalidSecp256k1PublicKey", errorMessage: e),
      invalidXOnlyPublicKey: () => PsbtException(code: "InvalidXOnlyPublicKey"),
      invalidEcdsaSignature: (e) => PsbtException(code: "InvalidEcdsaSignature", errorMessage: e),
      invalidTaprootSignature: (e) => PsbtException(code: "InvalidTaprootSignature", errorMessage: e),
      invalidControlBlock: () => PsbtException(code: "InvalidControlBlock"),
      invalidLeafVersion: () => PsbtException(code: "InvalidLeafVersion"),
      taproot: () => PsbtException(code: "Taproot"),
      tapTree: (e) => PsbtException(code: "TapTree", errorMessage: e),
      xPubKey: () => PsbtException(code: "XPubKey"),
      version: (e) => PsbtException(code: "Version", errorMessage: e),
      partialDataConsumption: () => PsbtException(code: "PartialDataConsumption", errorMessage: "data not consumed entirely when explicitly deserializing"),
      io: (e) => PsbtException(code: "I/O error", errorMessage: e),
      otherPsbtErr: () => PsbtException(code: "OtherPsbtErr"));
}

PsbtException mapPsbtParseError(PsbtParseError error) {
  return error.when(
      psbtEncoding: (e) => PsbtException(
          code: "PsbtEncoding",
          errorMessage: "error in internal psbt data structure: $e"),
      base64Encoding: (e) => PsbtException(
          code: "Base64Encoding",
          errorMessage: "error in psbt base64 encoding: $e"));
}

class SignerException extends BdkFfiException {
  /// Constructs the [ SignerException]
  SignerException({super.errorMessage, required super.code});
}

SignerException mapSignerError(SignerError error) {
  return error.when(
      missingKey: () => SignerException(
          code: "MissingKey", errorMessage: "missing key for signing"),
      invalidKey: () => SignerException(code: "InvalidKeyProvided"),
      userCanceled: () => SignerException(
          code: "UserOptionCanceled", errorMessage: "missing key for signing"),
      inputIndexOutOfRange: () => SignerException(
          code: "InputIndexOutOfRange",
          errorMessage: "input index out of range"),
      missingNonWitnessUtxo: () => SignerException(
          code: "MissingNonWitnessUtxo",
          errorMessage: "missing non-witness utxo information"),
      invalidNonWitnessUtxo: () => SignerException(
          code: "InvalidNonWitnessUtxo",
          errorMessage: "invalid non-witness utxo information provided"),
      missingWitnessUtxo: () => SignerException(code: "MissingWitnessUtxo"),
      missingWitnessScript: () => SignerException(code: "MissingWitnessScript"),
      missingHdKeypath: () => SignerException(code: "MissingHdKeypath"),
      nonStandardSighash: () => SignerException(code: "NonStandardSighash"),
      invalidSighash: () => SignerException(code: "InvalidSighashProvided"),
      sighashP2Wpkh: (e) => SignerException(
          code: "SighashP2wpkh",
          errorMessage:
              "error while computing the hash to sign a P2WPKH input: $e"),
      sighashTaproot: (e) => SignerException(
          code: "SighashTaproot",
          errorMessage:
              "error while computing the hash to sign a taproot input: $e"),
      txInputsIndexError: (e) => SignerException(
          code: "TxInputsIndexError",
          errorMessage:
              "Error while computing the hash, out of bounds access on the transaction inputs: $e"),
      miniscriptPsbt: (e) =>
          SignerException(code: "MiniscriptPsbt", errorMessage: e),
      external_: (e) => SignerException(code: "External", errorMessage: e),
      psbt: (e) => SignerException(code: "InvalidPsbt", errorMessage: e));
}

class SqliteException extends BdkFfiException {
  /// Constructs the [ SqliteException]
  SqliteException({super.errorMessage, required super.code});
}

SqliteException mapSqliteError(SqliteError error) {
  return error.when(
      sqlite: (e) => SqliteException(code: "IO/Sqlite", errorMessage: e));
}

class TransactionException extends BdkFfiException {
  /// Constructs the [ TransactionException]
  TransactionException({super.errorMessage, required super.code});
}

TransactionException mapTransactionError(TransactionError error) {
  return error.when(
      io: () => TransactionException(code: "IO/Transaction"),
      oversizedVectorAllocation: () => TransactionException(
          code: "OversizedVectorAllocation",
          errorMessage: "allocation of oversized vector"),
      invalidChecksum: (expected, actual) => TransactionException(
          code: "InvalidChecksum",
          errorMessage: "expected=$expected actual=$actual"),
      nonMinimalVarInt: () => TransactionException(
          code: "NonMinimalVarInt", errorMessage: "non-minimal var int"),
      parseFailed: () => TransactionException(code: "ParseFailed"),
      unsupportedSegwitFlag: (e) => TransactionException(
          code: "UnsupportedSegwitFlag",
          errorMessage: "unsupported segwit version: $e"),
      otherTransactionErr: () =>
          TransactionException(code: "OtherTransactionErr"));
}

class TxidParseException extends BdkFfiException {
  /// Constructs the [ TxidParseException]
  TxidParseException({super.errorMessage, required super.code});
}

TxidParseException mapTxidParseError(TxidParseError error) {
  return error.when(
      invalidTxid: (e) =>
          TxidParseException(code: "InvalidTxid", errorMessage: e));
}
