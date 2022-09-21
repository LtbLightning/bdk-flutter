import 'package:freezed_annotation/freezed_annotation.dart';
part 'key_exceptions.freezed.dart';

@freezed
class KeyException with _$KeyException {
  const factory KeyException.insufficientCoreVariables(String e) =  InsufficientCoreVariables;
  const factory KeyException.invalidPublicKey(String e) =  InvalidPublicKey;
  const factory KeyException.invalidThresholdValue() =  InvalidhresholdValue;
  const factory KeyException.repetitiousArguments(String e) = RepetitiousArguments;
  const factory KeyException.unexpected(String e) = Unexpected;
  const factory KeyException.invalidMnemonic(String e) =InvalidMnemonic;
  const factory KeyException.invalidXprv(String e) =InvalidXprv;
  const factory KeyException.invalidNetwork() =  InvalidNetwork;
}