// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wallet_exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WalletException {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreArguments,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function() invalidMnemonicAndPassword,
    required TResult Function() invalidBlockchainUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreArguments value)
        insufficientCoreArguments,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonicAndPassword value)
        invalidMnemonicAndPassword,
    required TResult Function(InvalidBlockchainUrl value) invalidBlockchainUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletExceptionCopyWith<$Res> {
  factory $WalletExceptionCopyWith(
          WalletException value, $Res Function(WalletException) then) =
      _$WalletExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class _$WalletExceptionCopyWithImpl<$Res>
    implements $WalletExceptionCopyWith<$Res> {
  _$WalletExceptionCopyWithImpl(this._value, this._then);

  final WalletException _value;
  // ignore: unused_field
  final $Res Function(WalletException) _then;
}

/// @nodoc
abstract class _$$InsufficientCoreArgumentsCopyWith<$Res> {
  factory _$$InsufficientCoreArgumentsCopyWith(
          _$InsufficientCoreArguments value,
          $Res Function(_$InsufficientCoreArguments) then) =
      __$$InsufficientCoreArgumentsCopyWithImpl<$Res>;
  $Res call({String e});
}

/// @nodoc
class __$$InsufficientCoreArgumentsCopyWithImpl<$Res>
    extends _$WalletExceptionCopyWithImpl<$Res>
    implements _$$InsufficientCoreArgumentsCopyWith<$Res> {
  __$$InsufficientCoreArgumentsCopyWithImpl(_$InsufficientCoreArguments _value,
      $Res Function(_$InsufficientCoreArguments) _then)
      : super(_value, (v) => _then(v as _$InsufficientCoreArguments));

  @override
  _$InsufficientCoreArguments get _value =>
      super._value as _$InsufficientCoreArguments;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$InsufficientCoreArguments(
      e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InsufficientCoreArguments implements InsufficientCoreArguments {
  const _$InsufficientCoreArguments(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'WalletException.insufficientCoreArguments(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientCoreArguments &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$InsufficientCoreArgumentsCopyWith<_$InsufficientCoreArguments>
      get copyWith => __$$InsufficientCoreArgumentsCopyWithImpl<
          _$InsufficientCoreArguments>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreArguments,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function() invalidMnemonicAndPassword,
    required TResult Function() invalidBlockchainUrl,
  }) {
    return insufficientCoreArguments(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
  }) {
    return insufficientCoreArguments?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
    required TResult orElse(),
  }) {
    if (insufficientCoreArguments != null) {
      return insufficientCoreArguments(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreArguments value)
        insufficientCoreArguments,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonicAndPassword value)
        invalidMnemonicAndPassword,
    required TResult Function(InvalidBlockchainUrl value) invalidBlockchainUrl,
  }) {
    return insufficientCoreArguments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
  }) {
    return insufficientCoreArguments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
    required TResult orElse(),
  }) {
    if (insufficientCoreArguments != null) {
      return insufficientCoreArguments(this);
    }
    return orElse();
  }
}

abstract class InsufficientCoreArguments implements WalletException {
  const factory InsufficientCoreArguments(final String e) =
      _$InsufficientCoreArguments;

  String get e;
  @JsonKey(ignore: true)
  _$$InsufficientCoreArgumentsCopyWith<_$InsufficientCoreArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RepetitiousArgumentsCopyWith<$Res> {
  factory _$$RepetitiousArgumentsCopyWith(_$RepetitiousArguments value,
          $Res Function(_$RepetitiousArguments) then) =
      __$$RepetitiousArgumentsCopyWithImpl<$Res>;
  $Res call({String e});
}

/// @nodoc
class __$$RepetitiousArgumentsCopyWithImpl<$Res>
    extends _$WalletExceptionCopyWithImpl<$Res>
    implements _$$RepetitiousArgumentsCopyWith<$Res> {
  __$$RepetitiousArgumentsCopyWithImpl(_$RepetitiousArguments _value,
      $Res Function(_$RepetitiousArguments) _then)
      : super(_value, (v) => _then(v as _$RepetitiousArguments));

  @override
  _$RepetitiousArguments get _value => super._value as _$RepetitiousArguments;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$RepetitiousArguments(
      e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RepetitiousArguments implements RepetitiousArguments {
  const _$RepetitiousArguments(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'WalletException.repetitiousArguments(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepetitiousArguments &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$RepetitiousArgumentsCopyWith<_$RepetitiousArguments> get copyWith =>
      __$$RepetitiousArgumentsCopyWithImpl<_$RepetitiousArguments>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreArguments,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function() invalidMnemonicAndPassword,
    required TResult Function() invalidBlockchainUrl,
  }) {
    return repetitiousArguments(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
  }) {
    return repetitiousArguments?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
    required TResult orElse(),
  }) {
    if (repetitiousArguments != null) {
      return repetitiousArguments(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreArguments value)
        insufficientCoreArguments,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonicAndPassword value)
        invalidMnemonicAndPassword,
    required TResult Function(InvalidBlockchainUrl value) invalidBlockchainUrl,
  }) {
    return repetitiousArguments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
  }) {
    return repetitiousArguments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
    required TResult orElse(),
  }) {
    if (repetitiousArguments != null) {
      return repetitiousArguments(this);
    }
    return orElse();
  }
}

abstract class RepetitiousArguments implements WalletException {
  const factory RepetitiousArguments(final String e) = _$RepetitiousArguments;

  String get e;
  @JsonKey(ignore: true)
  _$$RepetitiousArgumentsCopyWith<_$RepetitiousArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedCopyWith<$Res> {
  factory _$$UnexpectedCopyWith(
          _$Unexpected value, $Res Function(_$Unexpected) then) =
      __$$UnexpectedCopyWithImpl<$Res>;
  $Res call({String e});
}

/// @nodoc
class __$$UnexpectedCopyWithImpl<$Res>
    extends _$WalletExceptionCopyWithImpl<$Res>
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
    return 'WalletException.unexpected(e: $e)';
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
    required TResult Function(String e) insufficientCoreArguments,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function() invalidMnemonicAndPassword,
    required TResult Function() invalidBlockchainUrl,
  }) {
    return unexpected(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
  }) {
    return unexpected?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
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
    required TResult Function(InsufficientCoreArguments value)
        insufficientCoreArguments,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonicAndPassword value)
        invalidMnemonicAndPassword,
    required TResult Function(InvalidBlockchainUrl value) invalidBlockchainUrl,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
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

  String get e;
  @JsonKey(ignore: true)
  _$$UnexpectedCopyWith<_$Unexpected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidMnemonicAndPasswordCopyWith<$Res> {
  factory _$$InvalidMnemonicAndPasswordCopyWith(
          _$InvalidMnemonicAndPassword value,
          $Res Function(_$InvalidMnemonicAndPassword) then) =
      __$$InvalidMnemonicAndPasswordCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidMnemonicAndPasswordCopyWithImpl<$Res>
    extends _$WalletExceptionCopyWithImpl<$Res>
    implements _$$InvalidMnemonicAndPasswordCopyWith<$Res> {
  __$$InvalidMnemonicAndPasswordCopyWithImpl(
      _$InvalidMnemonicAndPassword _value,
      $Res Function(_$InvalidMnemonicAndPassword) _then)
      : super(_value, (v) => _then(v as _$InvalidMnemonicAndPassword));

  @override
  _$InvalidMnemonicAndPassword get _value =>
      super._value as _$InvalidMnemonicAndPassword;
}

/// @nodoc

class _$InvalidMnemonicAndPassword implements InvalidMnemonicAndPassword {
  const _$InvalidMnemonicAndPassword();

  @override
  String toString() {
    return 'WalletException.invalidMnemonicAndPassword()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidMnemonicAndPassword);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreArguments,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function() invalidMnemonicAndPassword,
    required TResult Function() invalidBlockchainUrl,
  }) {
    return invalidMnemonicAndPassword();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
  }) {
    return invalidMnemonicAndPassword?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
    required TResult orElse(),
  }) {
    if (invalidMnemonicAndPassword != null) {
      return invalidMnemonicAndPassword();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreArguments value)
        insufficientCoreArguments,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonicAndPassword value)
        invalidMnemonicAndPassword,
    required TResult Function(InvalidBlockchainUrl value) invalidBlockchainUrl,
  }) {
    return invalidMnemonicAndPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
  }) {
    return invalidMnemonicAndPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
    required TResult orElse(),
  }) {
    if (invalidMnemonicAndPassword != null) {
      return invalidMnemonicAndPassword(this);
    }
    return orElse();
  }
}

abstract class InvalidMnemonicAndPassword implements WalletException {
  const factory InvalidMnemonicAndPassword() = _$InvalidMnemonicAndPassword;
}

/// @nodoc
abstract class _$$InvalidBlockchainUrlCopyWith<$Res> {
  factory _$$InvalidBlockchainUrlCopyWith(_$InvalidBlockchainUrl value,
          $Res Function(_$InvalidBlockchainUrl) then) =
      __$$InvalidBlockchainUrlCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidBlockchainUrlCopyWithImpl<$Res>
    extends _$WalletExceptionCopyWithImpl<$Res>
    implements _$$InvalidBlockchainUrlCopyWith<$Res> {
  __$$InvalidBlockchainUrlCopyWithImpl(_$InvalidBlockchainUrl _value,
      $Res Function(_$InvalidBlockchainUrl) _then)
      : super(_value, (v) => _then(v as _$InvalidBlockchainUrl));

  @override
  _$InvalidBlockchainUrl get _value => super._value as _$InvalidBlockchainUrl;
}

/// @nodoc

class _$InvalidBlockchainUrl implements InvalidBlockchainUrl {
  const _$InvalidBlockchainUrl();

  @override
  String toString() {
    return 'WalletException.invalidBlockchainUrl()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidBlockchainUrl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreArguments,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function() invalidMnemonicAndPassword,
    required TResult Function() invalidBlockchainUrl,
  }) {
    return invalidBlockchainUrl();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
  }) {
    return invalidBlockchainUrl?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreArguments,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function()? invalidMnemonicAndPassword,
    TResult Function()? invalidBlockchainUrl,
    required TResult orElse(),
  }) {
    if (invalidBlockchainUrl != null) {
      return invalidBlockchainUrl();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreArguments value)
        insufficientCoreArguments,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonicAndPassword value)
        invalidMnemonicAndPassword,
    required TResult Function(InvalidBlockchainUrl value) invalidBlockchainUrl,
  }) {
    return invalidBlockchainUrl(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
  }) {
    return invalidBlockchainUrl?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreArguments value)?
        insufficientCoreArguments,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonicAndPassword value)?
        invalidMnemonicAndPassword,
    TResult Function(InvalidBlockchainUrl value)? invalidBlockchainUrl,
    required TResult orElse(),
  }) {
    if (invalidBlockchainUrl != null) {
      return invalidBlockchainUrl(this);
    }
    return orElse();
  }
}

abstract class InvalidBlockchainUrl implements WalletException {
  const factory InvalidBlockchainUrl() = _$InvalidBlockchainUrl;
}
