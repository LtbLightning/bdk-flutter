// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'broadcast_exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BroadcastException {
  String get e => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientAmount,
    required TResult Function(String e) unexpected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientAmount,
    TResult Function(String e)? unexpected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientAmount,
    TResult Function(String e)? unexpected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvalidPublicKey value) insufficientAmount,
    required TResult Function(Unexpected value) unexpected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? insufficientAmount,
    TResult Function(Unexpected value)? unexpected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? insufficientAmount,
    TResult Function(Unexpected value)? unexpected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BroadcastExceptionCopyWith<BroadcastException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BroadcastExceptionCopyWith<$Res> {
  factory $BroadcastExceptionCopyWith(
          BroadcastException value, $Res Function(BroadcastException) then) =
      _$BroadcastExceptionCopyWithImpl<$Res>;
  $Res call({String e});
}

/// @nodoc
class _$BroadcastExceptionCopyWithImpl<$Res>
    implements $BroadcastExceptionCopyWith<$Res> {
  _$BroadcastExceptionCopyWithImpl(this._value, this._then);

  final BroadcastException _value;
  // ignore: unused_field
  final $Res Function(BroadcastException) _then;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_value.copyWith(
      e: e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$InvalidPublicKeyCopyWith<$Res>
    implements $BroadcastExceptionCopyWith<$Res> {
  factory _$$InvalidPublicKeyCopyWith(
          _$InvalidPublicKey value, $Res Function(_$InvalidPublicKey) then) =
      __$$InvalidPublicKeyCopyWithImpl<$Res>;
  @override
  $Res call({String e});
}

/// @nodoc
class __$$InvalidPublicKeyCopyWithImpl<$Res>
    extends _$BroadcastExceptionCopyWithImpl<$Res>
    implements _$$InvalidPublicKeyCopyWith<$Res> {
  __$$InvalidPublicKeyCopyWithImpl(
      _$InvalidPublicKey _value, $Res Function(_$InvalidPublicKey) _then)
      : super(_value, (v) => _then(v as _$InvalidPublicKey));

  @override
  _$InvalidPublicKey get _value => super._value as _$InvalidPublicKey;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$InvalidPublicKey(
      e == freezed
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
    return 'BroadcastException.insufficientAmount(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidPublicKey &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$InvalidPublicKeyCopyWith<_$InvalidPublicKey> get copyWith =>
      __$$InvalidPublicKeyCopyWithImpl<_$InvalidPublicKey>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientAmount,
    required TResult Function(String e) unexpected,
  }) {
    return insufficientAmount(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientAmount,
    TResult Function(String e)? unexpected,
  }) {
    return insufficientAmount?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientAmount,
    TResult Function(String e)? unexpected,
    required TResult orElse(),
  }) {
    if (insufficientAmount != null) {
      return insufficientAmount(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InvalidPublicKey value) insufficientAmount,
    required TResult Function(Unexpected value) unexpected,
  }) {
    return insufficientAmount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? insufficientAmount,
    TResult Function(Unexpected value)? unexpected,
  }) {
    return insufficientAmount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? insufficientAmount,
    TResult Function(Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (insufficientAmount != null) {
      return insufficientAmount(this);
    }
    return orElse();
  }
}

abstract class InvalidPublicKey implements BroadcastException {
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
    implements $BroadcastExceptionCopyWith<$Res> {
  factory _$$UnexpectedCopyWith(
          _$Unexpected value, $Res Function(_$Unexpected) then) =
      __$$UnexpectedCopyWithImpl<$Res>;
  @override
  $Res call({String e});
}

/// @nodoc
class __$$UnexpectedCopyWithImpl<$Res>
    extends _$BroadcastExceptionCopyWithImpl<$Res>
    implements _$$UnexpectedCopyWith<$Res> {
  __$$UnexpectedCopyWithImpl(
      _$Unexpected _value, $Res Function(_$Unexpected) _then)
      : super(_value, (v) => _then(v as _$Unexpected));

  @override
  _$Unexpected get _value => super._value as _$Unexpected;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$Unexpected(
      e == freezed
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
    return 'BroadcastException.unexpected(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Unexpected &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$UnexpectedCopyWith<_$Unexpected> get copyWith =>
      __$$UnexpectedCopyWithImpl<_$Unexpected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientAmount,
    required TResult Function(String e) unexpected,
  }) {
    return unexpected(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientAmount,
    TResult Function(String e)? unexpected,
  }) {
    return unexpected?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientAmount,
    TResult Function(String e)? unexpected,
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
    required TResult Function(InvalidPublicKey value) insufficientAmount,
    required TResult Function(Unexpected value) unexpected,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? insufficientAmount,
    TResult Function(Unexpected value)? unexpected,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InvalidPublicKey value)? insufficientAmount,
    TResult Function(Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class Unexpected implements BroadcastException {
  const factory Unexpected(final String e) = _$Unexpected;

  @override
  String get e;
  @override
  @JsonKey(ignore: true)
  _$$UnexpectedCopyWith<_$Unexpected> get copyWith =>
      throw _privateConstructorUsedError;
}
