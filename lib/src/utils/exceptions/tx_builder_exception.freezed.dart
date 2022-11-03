// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tx_builder_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TxBuilderException {
  String get e => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientBalance,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidTxid,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? insufficientBalance,
    TResult? Function(String e)? insufficientBroadcastAmount,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? invalidTxid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientBalance,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidTxid,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientBalance value) insufficientBalance,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidTxid value) invalidTxid,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InsufficientBalance value)? insufficientBalance,
    TResult? Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(InvalidTxid value)? invalidTxid,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientBalance value)? insufficientBalance,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidTxid value)? invalidTxid,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TxBuilderExceptionCopyWith<TxBuilderException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxBuilderExceptionCopyWith<$Res> {
  factory $TxBuilderExceptionCopyWith(
          TxBuilderException value, $Res Function(TxBuilderException) then) =
      _$TxBuilderExceptionCopyWithImpl<$Res, TxBuilderException>;

  @useResult
  $Res call({String e});
}

/// @nodoc
class _$TxBuilderExceptionCopyWithImpl<$Res, $Val extends TxBuilderException>
    implements $TxBuilderExceptionCopyWith<$Res> {
  _$TxBuilderExceptionCopyWithImpl(this._value, this._then);

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
abstract class _$$InsufficientBalanceCopyWith<$Res>
    implements $TxBuilderExceptionCopyWith<$Res> {
  factory _$$InsufficientBalanceCopyWith(_$InsufficientBalance value,
          $Res Function(_$InsufficientBalance) then) =
      __$$InsufficientBalanceCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$InsufficientBalanceCopyWithImpl<$Res>
    extends _$TxBuilderExceptionCopyWithImpl<$Res, _$InsufficientBalance>
    implements _$$InsufficientBalanceCopyWith<$Res> {
  __$$InsufficientBalanceCopyWithImpl(
      _$InsufficientBalance _value, $Res Function(_$InsufficientBalance) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$InsufficientBalance(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InsufficientBalance implements InsufficientBalance {
  const _$InsufficientBalance(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'TxBuilderException.insufficientBalance(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientBalance &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsufficientBalanceCopyWith<_$InsufficientBalance> get copyWith =>
      __$$InsufficientBalanceCopyWithImpl<_$InsufficientBalance>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientBalance,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidTxid,
  }) {
    return insufficientBalance(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? insufficientBalance,
    TResult? Function(String e)? insufficientBroadcastAmount,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? invalidTxid,
  }) {
    return insufficientBalance?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientBalance,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidTxid,
    required TResult orElse(),
  }) {
    if (insufficientBalance != null) {
      return insufficientBalance(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientBalance value) insufficientBalance,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidTxid value) invalidTxid,
  }) {
    return insufficientBalance(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InsufficientBalance value)? insufficientBalance,
    TResult? Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(InvalidTxid value)? invalidTxid,
  }) {
    return insufficientBalance?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientBalance value)? insufficientBalance,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidTxid value)? invalidTxid,
    required TResult orElse(),
  }) {
    if (insufficientBalance != null) {
      return insufficientBalance(this);
    }
    return orElse();
  }
}

abstract class InsufficientBalance implements TxBuilderException {
  const factory InsufficientBalance(final String e) = _$InsufficientBalance;

  @override
  String get e;

  @override
  @JsonKey(ignore: true)
  _$$InsufficientBalanceCopyWith<_$InsufficientBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsufficientBroadcastAmountCopyWith<$Res>
    implements $TxBuilderExceptionCopyWith<$Res> {
  factory _$$InsufficientBroadcastAmountCopyWith(
          _$InsufficientBroadcastAmount value,
          $Res Function(_$InsufficientBroadcastAmount) then) =
      __$$InsufficientBroadcastAmountCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$InsufficientBroadcastAmountCopyWithImpl<$Res>
    extends _$TxBuilderExceptionCopyWithImpl<$Res,
        _$InsufficientBroadcastAmount>
    implements _$$InsufficientBroadcastAmountCopyWith<$Res> {
  __$$InsufficientBroadcastAmountCopyWithImpl(
      _$InsufficientBroadcastAmount _value,
      $Res Function(_$InsufficientBroadcastAmount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$InsufficientBroadcastAmount(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InsufficientBroadcastAmount implements InsufficientBroadcastAmount {
  const _$InsufficientBroadcastAmount(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'TxBuilderException.insufficientBroadcastAmount(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientBroadcastAmount &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsufficientBroadcastAmountCopyWith<_$InsufficientBroadcastAmount>
      get copyWith => __$$InsufficientBroadcastAmountCopyWithImpl<
          _$InsufficientBroadcastAmount>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientBalance,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidTxid,
  }) {
    return insufficientBroadcastAmount(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? insufficientBalance,
    TResult? Function(String e)? insufficientBroadcastAmount,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? invalidTxid,
  }) {
    return insufficientBroadcastAmount?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientBalance,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidTxid,
    required TResult orElse(),
  }) {
    if (insufficientBroadcastAmount != null) {
      return insufficientBroadcastAmount(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientBalance value) insufficientBalance,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidTxid value) invalidTxid,
  }) {
    return insufficientBroadcastAmount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InsufficientBalance value)? insufficientBalance,
    TResult? Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(InvalidTxid value)? invalidTxid,
  }) {
    return insufficientBroadcastAmount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientBalance value)? insufficientBalance,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidTxid value)? invalidTxid,
    required TResult orElse(),
  }) {
    if (insufficientBroadcastAmount != null) {
      return insufficientBroadcastAmount(this);
    }
    return orElse();
  }
}

abstract class InsufficientBroadcastAmount implements TxBuilderException {
  const factory InsufficientBroadcastAmount(final String e) =
      _$InsufficientBroadcastAmount;

  @override
  String get e;

  @override
  @JsonKey(ignore: true)
  _$$InsufficientBroadcastAmountCopyWith<_$InsufficientBroadcastAmount>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedCopyWith<$Res>
    implements $TxBuilderExceptionCopyWith<$Res> {
  factory _$$UnexpectedCopyWith(
          _$Unexpected value, $Res Function(_$Unexpected) then) =
      __$$UnexpectedCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$UnexpectedCopyWithImpl<$Res>
    extends _$TxBuilderExceptionCopyWithImpl<$Res, _$Unexpected>
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
    return 'TxBuilderException.unexpected(e: $e)';
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
    required TResult Function(String e) insufficientBalance,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidTxid,
  }) {
    return unexpected(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? insufficientBalance,
    TResult? Function(String e)? insufficientBroadcastAmount,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? invalidTxid,
  }) {
    return unexpected?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientBalance,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidTxid,
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
    required TResult Function(InsufficientBalance value) insufficientBalance,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidTxid value) invalidTxid,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InsufficientBalance value)? insufficientBalance,
    TResult? Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(InvalidTxid value)? invalidTxid,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientBalance value)? insufficientBalance,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidTxid value)? invalidTxid,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class Unexpected implements TxBuilderException {
  const factory Unexpected(final String e) = _$Unexpected;

  @override
  String get e;

  @override
  @JsonKey(ignore: true)
  _$$UnexpectedCopyWith<_$Unexpected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidTxidCopyWith<$Res>
    implements $TxBuilderExceptionCopyWith<$Res> {
  factory _$$InvalidTxidCopyWith(
          _$InvalidTxid value, $Res Function(_$InvalidTxid) then) =
      __$$InvalidTxidCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String e});
}

/// @nodoc
class __$$InvalidTxidCopyWithImpl<$Res>
    extends _$TxBuilderExceptionCopyWithImpl<$Res, _$InvalidTxid>
    implements _$$InvalidTxidCopyWith<$Res> {
  __$$InvalidTxidCopyWithImpl(
      _$InvalidTxid _value, $Res Function(_$InvalidTxid) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$InvalidTxid(
      null == e
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvalidTxid implements InvalidTxid {
  const _$InvalidTxid(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'TxBuilderException.invalidTxid(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidTxid &&
            (identical(other.e, e) || other.e == e));
  }

  @override
  int get hashCode => Object.hash(runtimeType, e);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvalidTxidCopyWith<_$InvalidTxid> get copyWith =>
      __$$InvalidTxidCopyWithImpl<_$InvalidTxid>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientBalance,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidTxid,
  }) {
    return invalidTxid(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String e)? insufficientBalance,
    TResult? Function(String e)? insufficientBroadcastAmount,
    TResult? Function(String e)? unexpected,
    TResult? Function(String e)? invalidTxid,
  }) {
    return invalidTxid?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientBalance,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidTxid,
    required TResult orElse(),
  }) {
    if (invalidTxid != null) {
      return invalidTxid(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientBalance value) insufficientBalance,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidTxid value) invalidTxid,
  }) {
    return invalidTxid(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InsufficientBalance value)? insufficientBalance,
    TResult? Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult? Function(Unexpected value)? unexpected,
    TResult? Function(InvalidTxid value)? invalidTxid,
  }) {
    return invalidTxid?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientBalance value)? insufficientBalance,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidTxid value)? invalidTxid,
    required TResult orElse(),
  }) {
    if (invalidTxid != null) {
      return invalidTxid(this);
    }
    return orElse();
  }
}

abstract class InvalidTxid implements TxBuilderException {
  const factory InvalidTxid(final String e) = _$InvalidTxid;

  @override
  String get e;

  @override
  @JsonKey(ignore: true)
  _$$InvalidTxidCopyWith<_$InvalidTxid> get copyWith =>
      throw _privateConstructorUsedError;
}
