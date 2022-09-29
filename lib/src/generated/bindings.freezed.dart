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
mixin _$BlockchainConfig {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ElectrumConfig config) electrum,
    required TResult Function(EsploraConfig config) esplora,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ELECTRUM value) electrum,
    required TResult Function(ESPLORA value) esplora,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ELECTRUM value)? electrum,
    TResult Function(ESPLORA value)? esplora,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ELECTRUM value)? electrum,
    TResult Function(ESPLORA value)? esplora,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockchainConfigCopyWith<$Res> {
  factory $BlockchainConfigCopyWith(
          BlockchainConfig value, $Res Function(BlockchainConfig) then) =
      _$BlockchainConfigCopyWithImpl<$Res>;
}

/// @nodoc
class _$BlockchainConfigCopyWithImpl<$Res>
    implements $BlockchainConfigCopyWith<$Res> {
  _$BlockchainConfigCopyWithImpl(this._value, this._then);

  final BlockchainConfig _value;
  // ignore: unused_field
  final $Res Function(BlockchainConfig) _then;
}

/// @nodoc
abstract class _$$ELECTRUMCopyWith<$Res> {
  factory _$$ELECTRUMCopyWith(
          _$ELECTRUM value, $Res Function(_$ELECTRUM) then) =
      __$$ELECTRUMCopyWithImpl<$Res>;
  $Res call({ElectrumConfig config});
}

/// @nodoc
class __$$ELECTRUMCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res>
    implements _$$ELECTRUMCopyWith<$Res> {
  __$$ELECTRUMCopyWithImpl(_$ELECTRUM _value, $Res Function(_$ELECTRUM) _then)
      : super(_value, (v) => _then(v as _$ELECTRUM));

  @override
  _$ELECTRUM get _value => super._value as _$ELECTRUM;

  @override
  $Res call({
    Object? config = freezed,
  }) {
    return _then(_$ELECTRUM(
      config: config == freezed
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as ElectrumConfig,
    ));
  }
}

/// @nodoc

class _$ELECTRUM implements ELECTRUM {
  const _$ELECTRUM({required this.config});

  @override
  final ElectrumConfig config;

  @override
  String toString() {
    return 'BlockchainConfig.electrum(config: $config)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ELECTRUM &&
            const DeepCollectionEquality().equals(other.config, config));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(config));

  @JsonKey(ignore: true)
  @override
  _$$ELECTRUMCopyWith<_$ELECTRUM> get copyWith =>
      __$$ELECTRUMCopyWithImpl<_$ELECTRUM>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ElectrumConfig config) electrum,
    required TResult Function(EsploraConfig config) esplora,
  }) {
    return electrum(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
  }) {
    return electrum?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
    required TResult orElse(),
  }) {
    if (electrum != null) {
      return electrum(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ELECTRUM value) electrum,
    required TResult Function(ESPLORA value) esplora,
  }) {
    return electrum(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ELECTRUM value)? electrum,
    TResult Function(ESPLORA value)? esplora,
  }) {
    return electrum?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ELECTRUM value)? electrum,
    TResult Function(ESPLORA value)? esplora,
    required TResult orElse(),
  }) {
    if (electrum != null) {
      return electrum(this);
    }
    return orElse();
  }
}

abstract class ELECTRUM implements BlockchainConfig {
  const factory ELECTRUM({required final ElectrumConfig config}) = _$ELECTRUM;

  ElectrumConfig get config;
  @JsonKey(ignore: true)
  _$$ELECTRUMCopyWith<_$ELECTRUM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ESPLORACopyWith<$Res> {
  factory _$$ESPLORACopyWith(_$ESPLORA value, $Res Function(_$ESPLORA) then) =
      __$$ESPLORACopyWithImpl<$Res>;
  $Res call({EsploraConfig config});
}

/// @nodoc
class __$$ESPLORACopyWithImpl<$Res> extends _$BlockchainConfigCopyWithImpl<$Res>
    implements _$$ESPLORACopyWith<$Res> {
  __$$ESPLORACopyWithImpl(_$ESPLORA _value, $Res Function(_$ESPLORA) _then)
      : super(_value, (v) => _then(v as _$ESPLORA));

  @override
  _$ESPLORA get _value => super._value as _$ESPLORA;

  @override
  $Res call({
    Object? config = freezed,
  }) {
    return _then(_$ESPLORA(
      config: config == freezed
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as EsploraConfig,
    ));
  }
}

/// @nodoc

class _$ESPLORA implements ESPLORA {
  const _$ESPLORA({required this.config});

  @override
  final EsploraConfig config;

  @override
  String toString() {
    return 'BlockchainConfig.esplora(config: $config)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ESPLORA &&
            const DeepCollectionEquality().equals(other.config, config));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(config));

  @JsonKey(ignore: true)
  @override
  _$$ESPLORACopyWith<_$ESPLORA> get copyWith =>
      __$$ESPLORACopyWithImpl<_$ESPLORA>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ElectrumConfig config) electrum,
    required TResult Function(EsploraConfig config) esplora,
  }) {
    return esplora(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
  }) {
    return esplora?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
    required TResult orElse(),
  }) {
    if (esplora != null) {
      return esplora(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ELECTRUM value) electrum,
    required TResult Function(ESPLORA value) esplora,
  }) {
    return esplora(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ELECTRUM value)? electrum,
    TResult Function(ESPLORA value)? esplora,
  }) {
    return esplora?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ELECTRUM value)? electrum,
    TResult Function(ESPLORA value)? esplora,
    required TResult orElse(),
  }) {
    if (esplora != null) {
      return esplora(this);
    }
    return orElse();
  }
}

abstract class ESPLORA implements BlockchainConfig {
  const factory ESPLORA({required final EsploraConfig config}) = _$ESPLORA;

  EsploraConfig get config;
  @JsonKey(ignore: true)
  _$$ESPLORACopyWith<_$ESPLORA> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DatabaseConfig {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() memory,
    required TResult Function(SqliteConfiguration config) sqlite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteConfiguration config)? sqlite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteConfiguration config)? sqlite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MEMORY value) memory,
    required TResult Function(SQLITE value) sqlite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatabaseConfigCopyWith<$Res> {
  factory $DatabaseConfigCopyWith(
          DatabaseConfig value, $Res Function(DatabaseConfig) then) =
      _$DatabaseConfigCopyWithImpl<$Res>;
}

/// @nodoc
class _$DatabaseConfigCopyWithImpl<$Res>
    implements $DatabaseConfigCopyWith<$Res> {
  _$DatabaseConfigCopyWithImpl(this._value, this._then);

  final DatabaseConfig _value;
  // ignore: unused_field
  final $Res Function(DatabaseConfig) _then;
}

/// @nodoc
abstract class _$$MEMORYCopyWith<$Res> {
  factory _$$MEMORYCopyWith(_$MEMORY value, $Res Function(_$MEMORY) then) =
      __$$MEMORYCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MEMORYCopyWithImpl<$Res> extends _$DatabaseConfigCopyWithImpl<$Res>
    implements _$$MEMORYCopyWith<$Res> {
  __$$MEMORYCopyWithImpl(_$MEMORY _value, $Res Function(_$MEMORY) _then)
      : super(_value, (v) => _then(v as _$MEMORY));

  @override
  _$MEMORY get _value => super._value as _$MEMORY;
}

/// @nodoc

class _$MEMORY implements MEMORY {
  const _$MEMORY();

  @override
  String toString() {
    return 'DatabaseConfig.memory()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MEMORY);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() memory,
    required TResult Function(SqliteConfiguration config) sqlite,
  }) {
    return memory();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteConfiguration config)? sqlite,
  }) {
    return memory?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteConfiguration config)? sqlite,
    required TResult orElse(),
  }) {
    if (memory != null) {
      return memory();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MEMORY value) memory,
    required TResult Function(SQLITE value) sqlite,
  }) {
    return memory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
  }) {
    return memory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
    required TResult orElse(),
  }) {
    if (memory != null) {
      return memory(this);
    }
    return orElse();
  }
}

abstract class MEMORY implements DatabaseConfig {
  const factory MEMORY() = _$MEMORY;
}

/// @nodoc
abstract class _$$SQLITECopyWith<$Res> {
  factory _$$SQLITECopyWith(_$SQLITE value, $Res Function(_$SQLITE) then) =
      __$$SQLITECopyWithImpl<$Res>;
  $Res call({SqliteConfiguration config});
}

/// @nodoc
class __$$SQLITECopyWithImpl<$Res> extends _$DatabaseConfigCopyWithImpl<$Res>
    implements _$$SQLITECopyWith<$Res> {
  __$$SQLITECopyWithImpl(_$SQLITE _value, $Res Function(_$SQLITE) _then)
      : super(_value, (v) => _then(v as _$SQLITE));

  @override
  _$SQLITE get _value => super._value as _$SQLITE;

  @override
  $Res call({
    Object? config = freezed,
  }) {
    return _then(_$SQLITE(
      config: config == freezed
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as SqliteConfiguration,
    ));
  }
}

/// @nodoc

class _$SQLITE implements SQLITE {
  const _$SQLITE({required this.config});

  @override
  final SqliteConfiguration config;

  @override
  String toString() {
    return 'DatabaseConfig.sqlite(config: $config)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SQLITE &&
            const DeepCollectionEquality().equals(other.config, config));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(config));

  @JsonKey(ignore: true)
  @override
  _$$SQLITECopyWith<_$SQLITE> get copyWith =>
      __$$SQLITECopyWithImpl<_$SQLITE>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() memory,
    required TResult Function(SqliteConfiguration config) sqlite,
  }) {
    return sqlite(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteConfiguration config)? sqlite,
  }) {
    return sqlite?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteConfiguration config)? sqlite,
    required TResult orElse(),
  }) {
    if (sqlite != null) {
      return sqlite(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MEMORY value) memory,
    required TResult Function(SQLITE value) sqlite,
  }) {
    return sqlite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
  }) {
    return sqlite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
    required TResult orElse(),
  }) {
    if (sqlite != null) {
      return sqlite(this);
    }
    return orElse();
  }
}

abstract class SQLITE implements DatabaseConfig {
  const factory SQLITE({required final SqliteConfiguration config}) = _$SQLITE;

  SqliteConfiguration get config;
  @JsonKey(ignore: true)
  _$$SQLITECopyWith<_$SQLITE> get copyWith =>
      throw _privateConstructorUsedError;
}

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
