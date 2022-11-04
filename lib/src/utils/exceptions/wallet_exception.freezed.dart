// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WalletException {
  String get e => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidAddress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? invalidAddress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidAddress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidAddress value) invalidAddress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(InvalidAddress value)? invalidAddress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidAddress value)? invalidAddress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletExceptionCopyWith<WalletException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletExceptionCopyWith<$Res> {
  factory $WalletExceptionCopyWith(
          WalletException value, $Res Function(WalletException) then) =
      _$WalletExceptionCopyWithImpl<$Res, WalletException>;
  @useResult
  $Res call({String e});
}

/// @nodoc
class _$WalletExceptionCopyWithImpl<$Res, $Val extends WalletException>
    implements $WalletExceptionCopyWith<$Res> {
  _$WalletExceptionCopyWithImpl(this._value, this._then);

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
abstract class _$$UnexpectedCopyWith<$Res>
    implements $WalletExceptionCopyWith<$Res> {
  factory _$$UnexpectedCopyWith(
          _$Unexpected value, $Res Function(_$Unexpected) then) =
      __$$UnexpectedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$UnexpectedCopyWithImpl<$Res>
    extends _$WalletExceptionCopyWithImpl<$Res, _$Unexpected>
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
    return 'WalletException.unexpected(e: $e)';
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
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidAddress,
  }) {
    return unexpected(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? invalidAddress,
  }) {
    return unexpected?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidAddress,
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
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidAddress value) invalidAddress,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(InvalidAddress value)? invalidAddress,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidAddress value)? invalidAddress,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class Unexpected implements WalletException {
  const factory Unexpected(final String e) = _$Unexpected;

  @override
  String get e;
  @override
  @JsonKey(ignore: true)
  _$$UnexpectedCopyWith<_$Unexpected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidAddressCopyWith<$Res>
    implements $WalletExceptionCopyWith<$Res> {
  factory _$$InvalidAddressCopyWith(
          _$InvalidAddress value, $Res Function(_$InvalidAddress) then) =
      __$$InvalidAddressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$InvalidAddressCopyWithImpl<$Res>
    extends _$WalletExceptionCopyWithImpl<$Res, _$InvalidAddress>
    implements _$$InvalidAddressCopyWith<$Res> {
  __$$InvalidAddressCopyWithImpl(
      _$InvalidAddress _value, $Res Function(_$InvalidAddress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$InvalidAddress(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvalidAddress implements InvalidAddress {
  const _$InvalidAddress(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'WalletException.invalidAddress(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidAddress &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidAddressCopyWith<_$InvalidAddress> get copyWith =>
      __$$InvalidAddressCopyWithImpl<_$InvalidAddress>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidAddress,
  }) {
    return invalidAddress(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? invalidAddress,
  }) {
    return invalidAddress?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidAddress,
    required TResult orElse(),
  }) {
    if (invalidAddress != null) {
      return invalidAddress(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidAddress value) invalidAddress,
  }) {
    return invalidAddress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(InvalidAddress value)? invalidAddress,
  }) {
    return invalidAddress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidAddress value)? invalidAddress,
    required TResult orElse(),
  }) {
    if (invalidAddress != null) {
      return invalidAddress(this);
    }
    return orElse();
  }
}

abstract class InvalidAddress implements WalletException {
  const factory InvalidAddress(final String e) = _$InvalidAddress;

  @override
  String get e;
  @override
  @JsonKey(ignore: true)
  _$$InvalidAddressCopyWith<_$InvalidAddress> get copyWith =>
      throw _privateConstructorUsedError;
}
