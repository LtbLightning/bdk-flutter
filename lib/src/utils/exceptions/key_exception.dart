import 'package:freezed_annotation/freezed_annotation.dart';
part 'key_exception.freezed.dart';

@freezed
class KeyException with _$KeyException {
  const factory KeyException.invalidPublicKey(String e) =  InvalidPublicKey;
  const factory KeyException.unexpected(String e) = Unexpected;
  /// Mnemonic has a word count that is not a multiple of 6.
  const factory KeyException.badWordCount(String e) =  BadWordCount;
  /// Mnemonic contains an unknown word.
  /// Error contains the index of the word.
  /// Use `mnemonic.split_whitespace().get(i)` to get the word.
 const factory KeyException.invalidMnemonic(String e) =  UnknownWord;

}