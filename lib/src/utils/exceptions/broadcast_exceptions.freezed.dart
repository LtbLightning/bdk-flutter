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
    required TResult Function(String e) insufficientFunds,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientFunds,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientFunds,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
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
abstract class _$$InsufficientFundsCopyWith<$Res>
    implements $BroadcastExceptionCopyWith<$Res> {
  factory _$$InsufficientFundsCopyWith(
          _$InsufficientFunds value, $Res Function(_$InsufficientFunds) then) =
      __$$InsufficientFundsCopyWithImpl<$Res>;
  @override
  $Res call({String e});
}

/// @nodoc
class __$$InsufficientFundsCopyWithImpl<$Res>
    extends _$BroadcastExceptionCopyWithImpl<$Res>
    implements _$$InsufficientFundsCopyWith<$Res> {
  __$$InsufficientFundsCopyWithImpl(
      _$InsufficientFunds _value, $Res Function(_$InsufficientFunds) _then)
      : super(_value, (v) => _then(v as _$InsufficientFunds));

  @override
  _$InsufficientFunds get _value => super._value as _$InsufficientFunds;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$InsufficientFunds(
      e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InsufficientFunds implements InsufficientFunds {
  const _$InsufficientFunds(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'BroadcastException.insufficientFunds(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientFunds &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$InsufficientFundsCopyWith<_$InsufficientFunds> get copyWith =>
      __$$InsufficientFundsCopyWithImpl<_$InsufficientFunds>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientFunds,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
  }) {
    return insufficientFunds(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientFunds,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
  }) {
    return insufficientFunds?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientFunds,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
  }) {
    return insufficientFunds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
  }) {
    return insufficientFunds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds(this);
    }
    return orElse();
  }
}

abstract class InsufficientFunds implements BroadcastException {
  const factory InsufficientFunds(final String e) = _$InsufficientFunds;

  @override
  String get e;
  @override
  @JsonKey(ignore: true)
  _$$InsufficientFundsCopyWith<_$InsufficientFunds> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsufficientBroadcastAmountCopyWith<$Res>
    implements $BroadcastExceptionCopyWith<$Res> {
  factory _$$InsufficientBroadcastAmountCopyWith(
          _$InsufficientBroadcastAmount value,
          $Res Function(_$InsufficientBroadcastAmount) then) =
      __$$InsufficientBroadcastAmountCopyWithImpl<$Res>;
  @override
  $Res call({String e});
}

/// @nodoc
class __$$InsufficientBroadcastAmountCopyWithImpl<$Res>
    extends _$BroadcastExceptionCopyWithImpl<$Res>
    implements _$$InsufficientBroadcastAmountCopyWith<$Res> {
  __$$InsufficientBroadcastAmountCopyWithImpl(
      _$InsufficientBroadcastAmount _value,
      $Res Function(_$InsufficientBroadcastAmount) _then)
      : super(_value, (v) => _then(v as _$InsufficientBroadcastAmount));

  @override
  _$InsufficientBroadcastAmount get _value =>
      super._value as _$InsufficientBroadcastAmount;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$InsufficientBroadcastAmount(
      e == freezed
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
    return 'BroadcastException.insufficientBroadcastAmount(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientBroadcastAmount &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$InsufficientBroadcastAmountCopyWith<_$InsufficientBroadcastAmount>
      get copyWith => __$$InsufficientBroadcastAmountCopyWithImpl<
          _$InsufficientBroadcastAmount>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientFunds,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
  }) {
    return insufficientBroadcastAmount(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientFunds,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
  }) {
    return insufficientBroadcastAmount?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientFunds,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
  }) {
    return insufficientBroadcastAmount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
  }) {
    return insufficientBroadcastAmount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
    required TResult orElse(),
  }) {
    if (insufficientBroadcastAmount != null) {
      return insufficientBroadcastAmount(this);
    }
    return orElse();
  }
}

abstract class InsufficientBroadcastAmount implements BroadcastException {
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
    required TResult Function(String e) insufficientFunds,
    required TResult Function(String e) insufficientBroadcastAmount,
    required TResult Function(String e) unexpected,
  }) {
    return unexpected(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientFunds,
    TResult Function(String e)? insufficientBroadcastAmount,
    TResult Function(String e)? unexpected,
  }) {
    return unexpected?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientFunds,
    TResult Function(String e)? insufficientBroadcastAmount,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientBroadcastAmount value)
        insufficientBroadcastAmount,
    required TResult Function(Unexpected value) unexpected,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
    TResult Function(Unexpected value)? unexpected,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientBroadcastAmount value)?
        insufficientBroadcastAmount,
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
