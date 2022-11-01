import 'package:freezed_annotation/freezed_annotation.dart';
part 'wallet_exception.freezed.dart';

@freezed
class WalletException with _$WalletException {
  const factory WalletException.unexpected(String e) = Unexpected;
  const factory WalletException.invalidAddress(String e) = InvalidAddress;
}