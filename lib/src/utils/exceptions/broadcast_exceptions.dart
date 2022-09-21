import 'package:freezed_annotation/freezed_annotation.dart';
part 'broadcast_exceptions.freezed.dart';

@freezed
class BroadcastException with _$BroadcastException {
  const factory BroadcastException.insufficientFunds(String e) =  InsufficientFunds;
  const factory BroadcastException.insufficientBroadcastAmount(String e) =  InsufficientBroadcastAmount;
  const factory BroadcastException.unexpected(String e) = Unexpected;
}