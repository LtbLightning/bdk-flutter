import 'package:freezed_annotation/freezed_annotation.dart';

part 'bdk_exception.freezed.dart';

@freezed
class BdkException with _$BdkException {
  const factory BdkException.scriptDoesntHaveAddressForm() = ScriptDoesntHaveAddressForm;
  const factory BdkException.noRecipients() = NoRecipients;
  const factory BdkException.generic(String e) =Generic;
  const factory BdkException.noUtxosSelected() = NoUtxosSelected;
  const factory BdkException.outputBelowDustLimit() = OutputBelowDustLimit;
  const factory BdkException.insufficientFunds(String e) = InsufficientFunds;
  const factory BdkException.bnBTotalTriesExceeded() =BnBTotalTriesExceeded;
  const factory BdkException.bnBNoExactMatch() = BnBNoExactMatch;
  const factory BdkException.unknownUtxo() = UnknownUtxo;
  const factory BdkException.transactionNotFound() = TransactionNotFound;
  const factory BdkException.transactionConfirmed() = TransactionConfirmed;
  //
  const factory BdkException.feeRateTooLow(String e) = FeeRateTooLow;
  const factory BdkException.feeTooLow(String e) =  FeeTooLow;

  const factory BdkException.feeRateUnavailable() = FeeRateUnavailable;
  const factory BdkException.checksumMismatch() = ChecksumMismatch;
  //


  // const factory BdkException.descriptor(String e) = Descriptor;
  const factory BdkException.miniscript(String e) =  Miniscript;
  const factory BdkException.bip32(String e) = Bip32;
  const factory BdkException.secp256k1(String e) =  Secp256k1;

  const factory BdkException.missingCachedScripts() = MissingCachedScripts;

  const factory BdkException.electrum(String e) = Electrum;
  const factory BdkException.esplora(String e) =  Esplora;
  const factory BdkException.sled(String e) = Sled;
  const factory BdkException.rpc(String e) =  Rpc;
  const factory BdkException.rusqlite(String e) =  Rusqlite;
  const factory BdkException.unExpected(String e) =  UnExpected;
}