import 'package:freezed_annotation/freezed_annotation.dart';

part 'path_exception.freezed.dart';

@freezed
class PathException with _$PathException {
  const factory PathException.invalidPath(String e) = InvalidPath;

  const factory PathException.unexpected(String e) = Unexpected;
}
