// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bindings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Transaction {
  TransactionDetails get details => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransactionDetails details) unconfirmed,
    required TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)
        confirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TransactionDetails details)? unconfirmed,
    TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)?
        confirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransactionDetails details)? unconfirmed,
    TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)?
        confirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unconfirmed value) unconfirmed,
    required TResult Function(Confirmed value) confirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unconfirmed value)? unconfirmed,
    TResult Function(Confirmed value)? confirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unconfirmed value)? unconfirmed,
    TResult Function(Confirmed value)? confirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res>;
  $Res call({TransactionDetails details});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res> implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  final Transaction _value;
  // ignore: unused_field
  final $Res Function(Transaction) _then;

  @override
  $Res call({
    Object? details = freezed,
  }) {
    return _then(_value.copyWith(
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as TransactionDetails,
    ));
  }
}

/// @nodoc
abstract class _$$UnconfirmedCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$UnconfirmedCopyWith(
          _$Unconfirmed value, $Res Function(_$Unconfirmed) then) =
      __$$UnconfirmedCopyWithImpl<$Res>;
  @override
  $Res call({TransactionDetails details});
}

/// @nodoc
class __$$UnconfirmedCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements _$$UnconfirmedCopyWith<$Res> {
  __$$UnconfirmedCopyWithImpl(
      _$Unconfirmed _value, $Res Function(_$Unconfirmed) _then)
      : super(_value, (v) => _then(v as _$Unconfirmed));

  @override
  _$Unconfirmed get _value => super._value as _$Unconfirmed;

  @override
  $Res call({
    Object? details = freezed,
  }) {
    return _then(_$Unconfirmed(
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as TransactionDetails,
    ));
  }
}

/// @nodoc

class _$Unconfirmed implements Unconfirmed {
  const _$Unconfirmed({required this.details});

  @override
  final TransactionDetails details;

  @override
  String toString() {
    return 'Transaction.unconfirmed(details: $details)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Unconfirmed &&
            const DeepCollectionEquality().equals(other.details, details));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(details));

  @JsonKey(ignore: true)
  @override
  _$$UnconfirmedCopyWith<_$Unconfirmed> get copyWith =>
      __$$UnconfirmedCopyWithImpl<_$Unconfirmed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransactionDetails details) unconfirmed,
    required TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)
        confirmed,
  }) {
    return unconfirmed(details);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TransactionDetails details)? unconfirmed,
    TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)?
        confirmed,
  }) {
    return unconfirmed?.call(details);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransactionDetails details)? unconfirmed,
    TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)?
        confirmed,
    required TResult orElse(),
  }) {
    if (unconfirmed != null) {
      return unconfirmed(details);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unconfirmed value) unconfirmed,
    required TResult Function(Confirmed value) confirmed,
  }) {
    return unconfirmed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unconfirmed value)? unconfirmed,
    TResult Function(Confirmed value)? confirmed,
  }) {
    return unconfirmed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unconfirmed value)? unconfirmed,
    TResult Function(Confirmed value)? confirmed,
    required TResult orElse(),
  }) {
    if (unconfirmed != null) {
      return unconfirmed(this);
    }
    return orElse();
  }
}

abstract class Unconfirmed implements Transaction {
  const factory Unconfirmed({required final TransactionDetails details}) =
      _$Unconfirmed;

  @override
  TransactionDetails get details;
  @override
  @JsonKey(ignore: true)
  _$$UnconfirmedCopyWith<_$Unconfirmed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmedCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$ConfirmedCopyWith(
          _$Confirmed value, $Res Function(_$Confirmed) then) =
      __$$ConfirmedCopyWithImpl<$Res>;
  @override
  $Res call({TransactionDetails details, BlockConfirmationTime confirmation});
}

/// @nodoc
class __$$ConfirmedCopyWithImpl<$Res> extends _$TransactionCopyWithImpl<$Res>
    implements _$$ConfirmedCopyWith<$Res> {
  __$$ConfirmedCopyWithImpl(
      _$Confirmed _value, $Res Function(_$Confirmed) _then)
      : super(_value, (v) => _then(v as _$Confirmed));

  @override
  _$Confirmed get _value => super._value as _$Confirmed;

  @override
  $Res call({
    Object? details = freezed,
    Object? confirmation = freezed,
  }) {
    return _then(_$Confirmed(
      details: details == freezed
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as TransactionDetails,
      confirmation: confirmation == freezed
          ? _value.confirmation
          : confirmation // ignore: cast_nullable_to_non_nullable
              as BlockConfirmationTime,
    ));
  }
}

/// @nodoc

class _$Confirmed implements Confirmed {
  const _$Confirmed({required this.details, required this.confirmation});

  @override
  final TransactionDetails details;
  @override
  final BlockConfirmationTime confirmation;

  @override
  String toString() {
    return 'Transaction.confirmed(details: $details, confirmation: $confirmation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Confirmed &&
            const DeepCollectionEquality().equals(other.details, details) &&
            const DeepCollectionEquality()
                .equals(other.confirmation, confirmation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(details),
      const DeepCollectionEquality().hash(confirmation));

  @JsonKey(ignore: true)
  @override
  _$$ConfirmedCopyWith<_$Confirmed> get copyWith =>
      __$$ConfirmedCopyWithImpl<_$Confirmed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TransactionDetails details) unconfirmed,
    required TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)
        confirmed,
  }) {
    return confirmed(details, confirmation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(TransactionDetails details)? unconfirmed,
    TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)?
        confirmed,
  }) {
    return confirmed?.call(details, confirmation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TransactionDetails details)? unconfirmed,
    TResult Function(
            TransactionDetails details, BlockConfirmationTime confirmation)?
        confirmed,
    required TResult orElse(),
  }) {
    if (confirmed != null) {
      return confirmed(details, confirmation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Unconfirmed value) unconfirmed,
    required TResult Function(Confirmed value) confirmed,
  }) {
    return confirmed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Unconfirmed value)? unconfirmed,
    TResult Function(Confirmed value)? confirmed,
  }) {
    return confirmed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Unconfirmed value)? unconfirmed,
    TResult Function(Confirmed value)? confirmed,
    required TResult orElse(),
  }) {
    if (confirmed != null) {
      return confirmed(this);
    }
    return orElse();
  }
}

abstract class Confirmed implements Transaction {
  const factory Confirmed(
      {required final TransactionDetails details,
      required final BlockConfirmationTime confirmation}) = _$Confirmed;

  @override
  TransactionDetails get details;
  BlockConfirmationTime get confirmation;
  @override
  @JsonKey(ignore: true)
  _$$ConfirmedCopyWith<_$Confirmed> get copyWith =>
      throw _privateConstructorUsedError;
}
