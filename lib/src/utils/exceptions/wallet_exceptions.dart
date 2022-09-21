import 'package:freezed_annotation/freezed_annotation.dart';
part 'wallet_exceptions.freezed.dart';

@freezed
class WalletException with _$WalletException {
  const factory WalletException.insufficientCoreArguments(String e) =  InsufficientCoreArguments;
  const factory WalletException.repetitiousArguments(String e) = RepetitiousArguments;
  const factory WalletException.unexpected(String e) = Unexpected;
  const factory WalletException.invalidMnemonicAndPassword() =InvalidMnemonicAndPassword;
  const factory WalletException.invalidBlockchainUrl() =InvalidBlockchainUrl;
}