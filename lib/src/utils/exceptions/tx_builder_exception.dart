import 'package:freezed_annotation/freezed_annotation.dart';
part 'tx_builder_exception.freezed.dart';

@freezed

class TxBuilderException with _$TxBuilderException {
  const factory TxBuilderException.insufficientBalance(String e) =  InsufficientBalance;
  const factory TxBuilderException.insufficientBroadcastAmount(String e) =  InsufficientBroadcastAmount;
  const factory TxBuilderException.unexpected(String e) = Unexpected;
  const factory TxBuilderException.invalidTxid(String e) = InvalidTxid;
}