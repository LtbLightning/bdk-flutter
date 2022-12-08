import 'package:freezed_annotation/freezed_annotation.dart';

part 'blockchain_exception.freezed.dart';

@freezed
class BlockchainException with _$BlockchainException {
  const factory BlockchainException.unexpected(String e) = Unexpected;
}
