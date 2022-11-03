// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'key_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KeyException {
  String get e => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) invalidPublicKey,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) badWordCount,
    required TResult Function(String e) invalidMnemonic,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? invalidPublicKey,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? badWordCount,
    TResult? Function(String e)? invalidMnemonic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? invalidPublicKey,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? badWordCount,
    TResult Function(String e)? invalidMnemonic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(BadWordCount value) badWordCount,
    required TResult Function(UnknownWord value) invalidMnemonic,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvalidPublicKey value)? invalidPublicKey,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(BadWordCount value)? badWordCount,
    TResult? Function(UnknownWord value)? invalidMnemonic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(BadWordCount value)? badWordCount,
    TResult Function(UnknownWord value)? invalidMnemonic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KeyExceptionCopyWith<KeyException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyExceptionCopyWith<$Res> {
  factory $KeyExceptionCopyWith(
          KeyException value, $Res Function(KeyException) then) =
      _$KeyExceptionCopyWithImpl<$Res, KeyException>;

  @useResult
  $Res call({String e});
}

/// @nodoc
class _$KeyExceptionCopyWithImpl<$Res, $Val extends KeyException>
    implements $KeyExceptionCopyWith<$Res> {
  _$KeyExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_value.copyWith(
      e: null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvalidPublicKeyCopyWith<$Res>
    implements $KeyExceptionCopyWith<$Res> {
  factory _$$InvalidPublicKeyCopyWith(
          _$InvalidPublicKey value, $Res Function(_$InvalidPublicKey) then) =
      __$$InvalidPublicKeyCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$InvalidPublicKeyCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res, _$InvalidPublicKey>
    implements _$$InvalidPublicKeyCopyWith<$Res> {
  __$$InvalidPublicKeyCopyWithImpl(
      _$InvalidPublicKey _value, $Res Function(_$InvalidPublicKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$InvalidPublicKey(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvalidPublicKey implements InvalidPublicKey {
  const _$InvalidPublicKey(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'KeyException.invalidPublicKey(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidPublicKey &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidPublicKeyCopyWith<_$InvalidPublicKey> get copyWith =>
      __$$InvalidPublicKeyCopyWithImpl<_$InvalidPublicKey>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) invalidPublicKey,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) badWordCount,
    required TResult Function(String e) invalidMnemonic,
  }) {
    return invalidPublicKey(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? invalidPublicKey,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? badWordCount,
    TResult? Function(String e)? invalidMnemonic,
  }) {
    return invalidPublicKey?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? invalidPublicKey,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? badWordCount,
    TResult Function(String e)? invalidMnemonic,
    required TResult orElse(),
  }) {
    if (invalidPublicKey != null) {
      return invalidPublicKey(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(BadWordCount value) badWordCount,
    required TResult Function(UnknownWord value) invalidMnemonic,
  }) {
    return invalidPublicKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvalidPublicKey value)? invalidPublicKey,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(BadWordCount value)? badWordCount,
    TResult? Function(UnknownWord value)? invalidMnemonic,
  }) {
    return invalidPublicKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(BadWordCount value)? badWordCount,
    TResult Function(UnknownWord value)? invalidMnemonic,
    required TResult orElse(),
  }) {
    if (invalidPublicKey != null) {
      return invalidPublicKey(this);
    }
    return orElse();
  }
}

abstract class InvalidPublicKey implements KeyException {
  const factory InvalidPublicKey(final String e) = _$InvalidPublicKey;

  @override
  String get e;

  @override
  @JsonKey(ignore: true)
  _$$InvalidPublicKeyCopyWith<_$InvalidPublicKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedCopyWith<$Res>
    implements $KeyExceptionCopyWith<$Res> {
  factory _$$UnexpectedCopyWith(
          _$Unexpected value, $Res Function(_$Unexpected) then) =
      __$$UnexpectedCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$UnexpectedCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res, _$Unexpected>
    implements _$$UnexpectedCopyWith<$Res> {
  __$$UnexpectedCopyWithImpl(
      _$Unexpected _value, $Res Function(_$Unexpected) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$Unexpected(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Unexpected implements Unexpected {
  const _$Unexpected(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'KeyException.unexpected(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Unexpected &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnexpectedCopyWith<_$Unexpected> get copyWith =>
      __$$UnexpectedCopyWithImpl<_$Unexpected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) invalidPublicKey,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) badWordCount,
    required TResult Function(String e) invalidMnemonic,
  }) {
    return unexpected(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? invalidPublicKey,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? badWordCount,
    TResult? Function(String e)? invalidMnemonic,
  }) {
    return unexpected?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? invalidPublicKey,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? badWordCount,
    TResult Function(String e)? invalidMnemonic,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(BadWordCount value) badWordCount,
    required TResult Function(UnknownWord value) invalidMnemonic,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvalidPublicKey value)? invalidPublicKey,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(BadWordCount value)? badWordCount,
    TResult? Function(UnknownWord value)? invalidMnemonic,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(BadWordCount value)? badWordCount,
    TResult Function(UnknownWord value)? invalidMnemonic,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class Unexpected implements KeyException {
  const factory Unexpected(final String e) = _$Unexpected;

  @override
  String get e;

  @override
  @JsonKey(ignore: true)
  _$$UnexpectedCopyWith<_$Unexpected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadWordCountCopyWith<$Res>
    implements $KeyExceptionCopyWith<$Res> {
  factory _$$BadWordCountCopyWith(
          _$BadWordCount value, $Res Function(_$BadWordCount) then) =
      __$$BadWordCountCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$BadWordCountCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res, _$BadWordCount>
    implements _$$BadWordCountCopyWith<$Res> {
  __$$BadWordCountCopyWithImpl(
      _$BadWordCount _value, $Res Function(_$BadWordCount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$BadWordCount(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BadWordCount implements BadWordCount {
  const _$BadWordCount(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'KeyException.badWordCount(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadWordCount &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadWordCountCopyWith<_$BadWordCount> get copyWith =>
      __$$BadWordCountCopyWithImpl<_$BadWordCount>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) invalidPublicKey,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) badWordCount,
    required TResult Function(String e) invalidMnemonic,
  }) {
    return badWordCount(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? invalidPublicKey,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? badWordCount,
    TResult? Function(String e)? invalidMnemonic,
  }) {
    return badWordCount?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? invalidPublicKey,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? badWordCount,
    TResult Function(String e)? invalidMnemonic,
    required TResult orElse(),
  }) {
    if (badWordCount != null) {
      return badWordCount(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(BadWordCount value) badWordCount,
    required TResult Function(UnknownWord value) invalidMnemonic,
  }) {
    return badWordCount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvalidPublicKey value)? invalidPublicKey,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(BadWordCount value)? badWordCount,
    TResult? Function(UnknownWord value)? invalidMnemonic,
  }) {
    return badWordCount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(BadWordCount value)? badWordCount,
    TResult Function(UnknownWord value)? invalidMnemonic,
    required TResult orElse(),
  }) {
    if (badWordCount != null) {
      return badWordCount(this);
    }
    return orElse();
  }
}

abstract class BadWordCount implements KeyException {
  const factory BadWordCount(final String e) = _$BadWordCount;

  @override
  String get e;

  @override
  @JsonKey(ignore: true)
  _$$BadWordCountCopyWith<_$BadWordCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownWordCopyWith<$Res>
    implements $KeyExceptionCopyWith<$Res> {
  factory _$$UnknownWordCopyWith(
          _$UnknownWord value, $Res Function(_$UnknownWord) then) =
      __$$UnknownWordCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$UnknownWordCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res, _$UnknownWord>
    implements _$$UnknownWordCopyWith<$Res> {
  __$$UnknownWordCopyWithImpl(
      _$UnknownWord _value, $Res Function(_$UnknownWord) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$UnknownWord(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnknownWord implements UnknownWord {
  const _$UnknownWord(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'KeyException.invalidMnemonic(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownWord &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownWordCopyWith<_$UnknownWord> get copyWith =>
      __$$UnknownWordCopyWithImpl<_$UnknownWord>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) invalidPublicKey,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) badWordCount,
    required TResult Function(String e) invalidMnemonic,
  }) {
    return invalidMnemonic(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? invalidPublicKey,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? badWordCount,
    TResult? Function(String e)? invalidMnemonic,
  }) {
    return invalidMnemonic?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? invalidPublicKey,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? badWordCount,
    TResult Function(String e)? invalidMnemonic,
    required TResult orElse(),
  }) {
    if (invalidMnemonic != null) {
      return invalidMnemonic(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(BadWordCount value) badWordCount,
    required TResult Function(UnknownWord value) invalidMnemonic,
  }) {
    return invalidMnemonic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InvalidPublicKey value)? invalidPublicKey,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(BadWordCount value)? badWordCount,
    TResult? Function(UnknownWord value)? invalidMnemonic,
  }) {
    return invalidMnemonic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(BadWordCount value)? badWordCount,
    TResult Function(UnknownWord value)? invalidMnemonic,
    required TResult orElse(),
  }) {
    if (invalidMnemonic != null) {
      return invalidMnemonic(this);
    }
    return orElse();
  }
}

abstract class UnknownWord implements KeyException {
  const factory UnknownWord(final String e) = _$UnknownWord;

  @override
  String get e;

  @override
  @JsonKey(ignore: true)
  _$$UnknownWordCopyWith<_$UnknownWord> get copyWith =>
      throw _privateConstructorUsedError;
}
