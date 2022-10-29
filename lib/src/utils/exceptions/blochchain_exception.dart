import 'package:freezed_annotation/freezed_annotation.dart';
part 'blochchain_exception.freezed.dart';

@freezed
class BlockchainException with _$BlockchainException {
  const factory BlockchainException.unexpected(String e) = Unexpected;
}