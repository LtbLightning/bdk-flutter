// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'key_exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$KeyException {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyExceptionCopyWith<$Res> {
  factory $KeyExceptionCopyWith(
          KeyException value, $Res Function(KeyException) then) =
      _$KeyExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class _$KeyExceptionCopyWithImpl<$Res> implements $KeyExceptionCopyWith<$Res> {
  _$KeyExceptionCopyWithImpl(this._value, this._then);

  final KeyException _value;
  // ignore: unused_field
  final $Res Function(KeyException) _then;
}

/// @nodoc
abstract class _$$InsufficientCoreVariablesCopyWith<$Res> {
  factory _$$InsufficientCoreVariablesCopyWith(
          _$InsufficientCoreVariables value,
          $Res Function(_$InsufficientCoreVariables) then) =
      __$$InsufficientCoreVariablesCopyWithImpl<$Res>;
  $Res call({String e});
}

/// @nodoc
class __$$InsufficientCoreVariablesCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res>
    implements _$$InsufficientCoreVariablesCopyWith<$Res> {
  __$$InsufficientCoreVariablesCopyWithImpl(_$InsufficientCoreVariables _value,
      $Res Function(_$InsufficientCoreVariables) _then)
      : super(_value, (v) => _then(v as _$InsufficientCoreVariables));

  @override
  _$InsufficientCoreVariables get _value =>
      super._value as _$InsufficientCoreVariables;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$InsufficientCoreVariables(
      e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InsufficientCoreVariables implements InsufficientCoreVariables {
  const _$InsufficientCoreVariables(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'KeyException.insufficientCoreVariables(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientCoreVariables &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$InsufficientCoreVariablesCopyWith<_$InsufficientCoreVariables>
      get copyWith => __$$InsufficientCoreVariablesCopyWithImpl<
          _$InsufficientCoreVariables>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) {
    return insufficientCoreVariables(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) {
    return insufficientCoreVariables?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
    required TResult orElse(),
  }) {
    if (insufficientCoreVariables != null) {
      return insufficientCoreVariables(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) {
    return insufficientCoreVariables(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) {
    return insufficientCoreVariables?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
    required TResult orElse(),
  }) {
    if (insufficientCoreVariables != null) {
      return insufficientCoreVariables(this);
    }
    return orElse();
  }
}

abstract class InsufficientCoreVariables implements KeyException {
  const factory InsufficientCoreVariables(final String e) =
      _$InsufficientCoreVariables;

  String get e;
  @JsonKey(ignore: true)
  _$$InsufficientCoreVariablesCopyWith<_$InsufficientCoreVariables>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidPublicKeyCopyWith<$Res> {
  factory _$$InvalidPublicKeyCopyWith(
          _$InvalidPublicKey value, $Res Function(_$InvalidPublicKey) then) =
      __$$InvalidPublicKeyCopyWithImpl<$Res>;
  $Res call({String e});
}

/// @nodoc
class __$$InvalidPublicKeyCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res>
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
    return 'KeyException.invalidPublicKey(e: $e)';
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
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) {
    return invalidPublicKey(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) {
    return invalidPublicKey?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
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
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) {
    return invalidPublicKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) {
    return invalidPublicKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
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

  String get e;
  @JsonKey(ignore: true)
  _$$InvalidPublicKeyCopyWith<_$InvalidPublicKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidhresholdValueCopyWith<$Res> {
  factory _$$InvalidhresholdValueCopyWith(_$InvalidhresholdValue value,
          $Res Function(_$InvalidhresholdValue) then) =
      __$$InvalidhresholdValueCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidhresholdValueCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res>
    implements _$$InvalidhresholdValueCopyWith<$Res> {
  __$$InvalidhresholdValueCopyWithImpl(_$InvalidhresholdValue _value,
      $Res Function(_$InvalidhresholdValue) _then)
      : super(_value, (v) => _then(v as _$InvalidhresholdValue));

  @override
  _$InvalidhresholdValue get _value => super._value as _$InvalidhresholdValue;
}

/// @nodoc

class _$InvalidhresholdValue implements InvalidhresholdValue {
  const _$InvalidhresholdValue();

  @override
  String toString() {
    return 'KeyException.invalidThresholdValue()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidhresholdValue);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) {
    return invalidThresholdValue();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) {
    return invalidThresholdValue?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
    required TResult orElse(),
  }) {
    if (invalidThresholdValue != null) {
      return invalidThresholdValue();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) {
    return invalidThresholdValue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) {
    return invalidThresholdValue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
    required TResult orElse(),
  }) {
    if (invalidThresholdValue != null) {
      return invalidThresholdValue(this);
    }
    return orElse();
  }
}

abstract class InvalidhresholdValue implements KeyException {
  const factory InvalidhresholdValue() = _$InvalidhresholdValue;
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
    extends _$KeyExceptionCopyWithImpl<$Res>
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
    return 'KeyException.repetitiousArguments(e: $e)';
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
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) {
    return repetitiousArguments(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) {
    return repetitiousArguments?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
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
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) {
    return repetitiousArguments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) {
    return repetitiousArguments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
    required TResult orElse(),
  }) {
    if (repetitiousArguments != null) {
      return repetitiousArguments(this);
    }
    return orElse();
  }
}

abstract class RepetitiousArguments implements KeyException {
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
class __$$UnexpectedCopyWithImpl<$Res> extends _$KeyExceptionCopyWithImpl<$Res>
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
    return 'KeyException.unexpected(e: $e)';
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
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) {
    return unexpected(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) {
    return unexpected?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
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
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
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

  String get e;
  @JsonKey(ignore: true)
  _$$UnexpectedCopyWith<_$Unexpected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidMnemonicCopyWith<$Res> {
  factory _$$InvalidMnemonicCopyWith(
          _$InvalidMnemonic value, $Res Function(_$InvalidMnemonic) then) =
      __$$InvalidMnemonicCopyWithImpl<$Res>;
  $Res call({String e});
}

/// @nodoc
class __$$InvalidMnemonicCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res>
    implements _$$InvalidMnemonicCopyWith<$Res> {
  __$$InvalidMnemonicCopyWithImpl(
      _$InvalidMnemonic _value, $Res Function(_$InvalidMnemonic) _then)
      : super(_value, (v) => _then(v as _$InvalidMnemonic));

  @override
  _$InvalidMnemonic get _value => super._value as _$InvalidMnemonic;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$InvalidMnemonic(
      e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvalidMnemonic implements InvalidMnemonic {
  const _$InvalidMnemonic(this.e);

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
            other is _$InvalidMnemonic &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$InvalidMnemonicCopyWith<_$InvalidMnemonic> get copyWith =>
      __$$InvalidMnemonicCopyWithImpl<_$InvalidMnemonic>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) {
    return invalidMnemonic(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) {
    return invalidMnemonic?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
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
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) {
    return invalidMnemonic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) {
    return invalidMnemonic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
    required TResult orElse(),
  }) {
    if (invalidMnemonic != null) {
      return invalidMnemonic(this);
    }
    return orElse();
  }
}

abstract class InvalidMnemonic implements KeyException {
  const factory InvalidMnemonic(final String e) = _$InvalidMnemonic;

  String get e;
  @JsonKey(ignore: true)
  _$$InvalidMnemonicCopyWith<_$InvalidMnemonic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidXprvCopyWith<$Res> {
  factory _$$InvalidXprvCopyWith(
          _$InvalidXprv value, $Res Function(_$InvalidXprv) then) =
      __$$InvalidXprvCopyWithImpl<$Res>;
  $Res call({String e});
}

/// @nodoc
class __$$InvalidXprvCopyWithImpl<$Res> extends _$KeyExceptionCopyWithImpl<$Res>
    implements _$$InvalidXprvCopyWith<$Res> {
  __$$InvalidXprvCopyWithImpl(
      _$InvalidXprv _value, $Res Function(_$InvalidXprv) _then)
      : super(_value, (v) => _then(v as _$InvalidXprv));

  @override
  _$InvalidXprv get _value => super._value as _$InvalidXprv;

  @override
  $Res call({
    Object? e = freezed,
  }) {
    return _then(_$InvalidXprv(
      e == freezed
          ? _value.e
          : e // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InvalidXprv implements InvalidXprv {
  const _$InvalidXprv(this.e);

  @override
  final String e;

  @override
  String toString() {
    return 'KeyException.invalidXprv(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidXprv &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  @JsonKey(ignore: true)
  @override
  _$$InvalidXprvCopyWith<_$InvalidXprv> get copyWith =>
      __$$InvalidXprvCopyWithImpl<_$InvalidXprv>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) {
    return invalidXprv(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) {
    return invalidXprv?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
    required TResult orElse(),
  }) {
    if (invalidXprv != null) {
      return invalidXprv(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) {
    return invalidXprv(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) {
    return invalidXprv?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
    required TResult orElse(),
  }) {
    if (invalidXprv != null) {
      return invalidXprv(this);
    }
    return orElse();
  }
}

abstract class InvalidXprv implements KeyException {
  const factory InvalidXprv(final String e) = _$InvalidXprv;

  String get e;
  @JsonKey(ignore: true)
  _$$InvalidXprvCopyWith<_$InvalidXprv> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidNetworkCopyWith<$Res> {
  factory _$$InvalidNetworkCopyWith(
          _$InvalidNetwork value, $Res Function(_$InvalidNetwork) then) =
      __$$InvalidNetworkCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidNetworkCopyWithImpl<$Res>
    extends _$KeyExceptionCopyWithImpl<$Res>
    implements _$$InvalidNetworkCopyWith<$Res> {
  __$$InvalidNetworkCopyWithImpl(
      _$InvalidNetwork _value, $Res Function(_$InvalidNetwork) _then)
      : super(_value, (v) => _then(v as _$InvalidNetwork));

  @override
  _$InvalidNetwork get _value => super._value as _$InvalidNetwork;
}

/// @nodoc

class _$InvalidNetwork implements InvalidNetwork {
  const _$InvalidNetwork();

  @override
  String toString() {
    return 'KeyException.invalidNetwork()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidNetwork);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String e) insufficientCoreVariables,
    required TResult Function(String e) invalidPublicKey,
    required TResult Function() invalidThresholdValue,
    required TResult Function(String e) repetitiousArguments,
    required TResult Function(String e) unexpected,
    required TResult Function(String e) invalidMnemonic,
    required TResult Function(String e) invalidXprv,
    required TResult Function() invalidNetwork,
  }) {
    return invalidNetwork();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
  }) {
    return invalidNetwork?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String e)? insufficientCoreVariables,
    TResult Function(String e)? invalidPublicKey,
    TResult Function()? invalidThresholdValue,
    TResult Function(String e)? repetitiousArguments,
    TResult Function(String e)? unexpected,
    TResult Function(String e)? invalidMnemonic,
    TResult Function(String e)? invalidXprv,
    TResult Function()? invalidNetwork,
    required TResult orElse(),
  }) {
    if (invalidNetwork != null) {
      return invalidNetwork();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InsufficientCoreVariables value)
        insufficientCoreVariables,
    required TResult Function(InvalidPublicKey value) invalidPublicKey,
    required TResult Function(InvalidhresholdValue value) invalidThresholdValue,
    required TResult Function(RepetitiousArguments value) repetitiousArguments,
    required TResult Function(Unexpected value) unexpected,
    required TResult Function(InvalidMnemonic value) invalidMnemonic,
    required TResult Function(InvalidXprv value) invalidXprv,
    required TResult Function(InvalidNetwork value) invalidNetwork,
  }) {
    return invalidNetwork(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
  }) {
    return invalidNetwork?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InsufficientCoreVariables value)?
        insufficientCoreVariables,
    TResult Function(InvalidPublicKey value)? invalidPublicKey,
    TResult Function(InvalidhresholdValue value)? invalidThresholdValue,
    TResult Function(RepetitiousArguments value)? repetitiousArguments,
    TResult Function(Unexpected value)? unexpected,
    TResult Function(InvalidMnemonic value)? invalidMnemonic,
    TResult Function(InvalidXprv value)? invalidXprv,
    TResult Function(InvalidNetwork value)? invalidNetwork,
    required TResult orElse(),
  }) {
    if (invalidNetwork != null) {
      return invalidNetwork(this);
    }
    return orElse();
  }
}

abstract class InvalidNetwork implements KeyException {
  const factory InvalidNetwork() = _$InvalidNetwork;
}
