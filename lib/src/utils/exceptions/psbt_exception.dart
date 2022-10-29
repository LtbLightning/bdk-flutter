import 'package:freezed_annotation/freezed_annotation.dart';
part 'psbt_exception.freezed.dart';

@freezed
class PsbtException with _$PsbtException {
  const factory PsbtException.insufficientFunds(String e) =  InsufficientFunds;
  const factory PsbtException.insufficientBroadcastAmount(String e) =  InsufficientBroadcastAmount;
  const factory PsbtException.unexpected(String e) = Unexpected;
}