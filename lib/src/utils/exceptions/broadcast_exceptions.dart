import 'package:freezed_annotation/freezed_annotation.dart';
part 'broadcast_exceptions.freezed.dart';

@freezed
class BroadcastException with _$BroadcastException {
  const factory BroadcastException.insufficientAmount(String e) =  InvalidPublicKey;
  const factory BroadcastException.unexpected(String e) = Unexpected;
}