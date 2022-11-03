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
    TResult? Function(ElectrumConfig config)? electrum,
    TResult? Function(EsploraConfig config)? esplora,
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
    TResult? Function(ELECTRUM value)? electrum,
    TResult? Function(ESPLORA value)? esplora,
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
      _$BlockchainConfigCopyWithImpl<$Res, BlockchainConfig>;
}

/// @nodoc
class _$BlockchainConfigCopyWithImpl<$Res, $Val extends BlockchainConfig>
    implements $BlockchainConfigCopyWith<$Res> {
  _$BlockchainConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ELECTRUMCopyWith<$Res> {
  factory _$$ELECTRUMCopyWith(
          _$ELECTRUM value, $Res Function(_$ELECTRUM) then) =
      __$$ELECTRUMCopyWithImpl<$Res>;

  @useResult
  $Res call({ElectrumConfig config});
}

/// @nodoc
class __$$ELECTRUMCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res, _$ELECTRUM>
    implements _$$ELECTRUMCopyWith<$Res> {
  __$$ELECTRUMCopyWithImpl(_$ELECTRUM _value, $Res Function(_$ELECTRUM) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$ELECTRUM(
      config: null == config
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
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(ElectrumConfig config)? electrum,
    TResult? Function(EsploraConfig config)? esplora,
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
    TResult? Function(ELECTRUM value)? electrum,
    TResult? Function(ESPLORA value)? esplora,
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

  @useResult
  $Res call({EsploraConfig config});
}

/// @nodoc
class __$$ESPLORACopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res, _$ESPLORA>
    implements _$$ESPLORACopyWith<$Res> {
  __$$ESPLORACopyWithImpl(_$ESPLORA _value, $Res Function(_$ESPLORA) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$ESPLORA(
      config: null == config
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
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(ElectrumConfig config)? electrum,
    TResult? Function(EsploraConfig config)? esplora,
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
    TResult? Function(ELECTRUM value)? electrum,
    TResult? Function(ESPLORA value)? esplora,
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
    required TResult Function(SqliteDbConfiguration config) sqlite,
    required TResult Function(SledDbConfiguration config) sled,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? memory,
    TResult? Function(SqliteDbConfiguration config)? sqlite,
    TResult? Function(SledDbConfiguration config)? sled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteDbConfiguration config)? sqlite,
    TResult Function(SledDbConfiguration config)? sled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MEMORY value) memory,
    required TResult Function(SQLITE value) sqlite,
    required TResult Function(SLED value) sled,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MEMORY value)? memory,
    TResult? Function(SQLITE value)? sqlite,
    TResult? Function(SLED value)? sled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
    TResult Function(SLED value)? sled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DatabaseConfigCopyWith<$Res> {
  factory $DatabaseConfigCopyWith(
          DatabaseConfig value, $Res Function(DatabaseConfig) then) =
      _$DatabaseConfigCopyWithImpl<$Res, DatabaseConfig>;
}

/// @nodoc
class _$DatabaseConfigCopyWithImpl<$Res, $Val extends DatabaseConfig>
    implements $DatabaseConfigCopyWith<$Res> {
  _$DatabaseConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MEMORYCopyWith<$Res> {
  factory _$$MEMORYCopyWith(_$MEMORY value, $Res Function(_$MEMORY) then) =
      __$$MEMORYCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MEMORYCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$MEMORY>
    implements _$$MEMORYCopyWith<$Res> {
  __$$MEMORYCopyWithImpl(_$MEMORY _value, $Res Function(_$MEMORY) _then)
      : super(_value, _then);
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
    required TResult Function(SqliteDbConfiguration config) sqlite,
    required TResult Function(SledDbConfiguration config) sled,
  }) {
    return memory();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? memory,
    TResult? Function(SqliteDbConfiguration config)? sqlite,
    TResult? Function(SledDbConfiguration config)? sled,
  }) {
    return memory?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteDbConfiguration config)? sqlite,
    TResult Function(SledDbConfiguration config)? sled,
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
    required TResult Function(SLED value) sled,
  }) {
    return memory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MEMORY value)? memory,
    TResult? Function(SQLITE value)? sqlite,
    TResult? Function(SLED value)? sled,
  }) {
    return memory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
    TResult Function(SLED value)? sled,
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

  @useResult
  $Res call({SqliteDbConfiguration config});
}

/// @nodoc
class __$$SQLITECopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$SQLITE>
    implements _$$SQLITECopyWith<$Res> {
  __$$SQLITECopyWithImpl(_$SQLITE _value, $Res Function(_$SQLITE) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$SQLITE(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as SqliteDbConfiguration,
    ));
  }
}

/// @nodoc

class _$SQLITE implements SQLITE {
  const _$SQLITE({required this.config});

  @override
  final SqliteDbConfiguration config;

  @override
  String toString() {
    return 'DatabaseConfig.sqlite(config: $config)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SQLITE &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SQLITECopyWith<_$SQLITE> get copyWith =>
      __$$SQLITECopyWithImpl<_$SQLITE>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() memory,
    required TResult Function(SqliteDbConfiguration config) sqlite,
    required TResult Function(SledDbConfiguration config) sled,
  }) {
    return sqlite(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? memory,
    TResult? Function(SqliteDbConfiguration config)? sqlite,
    TResult? Function(SledDbConfiguration config)? sled,
  }) {
    return sqlite?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteDbConfiguration config)? sqlite,
    TResult Function(SledDbConfiguration config)? sled,
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
    required TResult Function(SLED value) sled,
  }) {
    return sqlite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MEMORY value)? memory,
    TResult? Function(SQLITE value)? sqlite,
    TResult? Function(SLED value)? sled,
  }) {
    return sqlite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
    TResult Function(SLED value)? sled,
    required TResult orElse(),
  }) {
    if (sqlite != null) {
      return sqlite(this);
    }
    return orElse();
  }
}

abstract class SQLITE implements DatabaseConfig {
  const factory SQLITE({required final SqliteDbConfiguration config}) =
      _$SQLITE;

  SqliteDbConfiguration get config;

  @JsonKey(ignore: true)
  _$$SQLITECopyWith<_$SQLITE> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SLEDCopyWith<$Res> {
  factory _$$SLEDCopyWith(_$SLED value, $Res Function(_$SLED) then) =
      __$$SLEDCopyWithImpl<$Res>;

  @useResult
  $Res call({SledDbConfiguration config});
}

/// @nodoc
class __$$SLEDCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$SLED>
    implements _$$SLEDCopyWith<$Res> {
  __$$SLEDCopyWithImpl(_$SLED _value, $Res Function(_$SLED) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$SLED(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as SledDbConfiguration,
    ));
  }
}

/// @nodoc

class _$SLED implements SLED {
  const _$SLED({required this.config});

  @override
  final SledDbConfiguration config;

  @override
  String toString() {
    return 'DatabaseConfig.sled(config: $config)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SLED &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SLEDCopyWith<_$SLED> get copyWith =>
      __$$SLEDCopyWithImpl<_$SLED>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() memory,
    required TResult Function(SqliteDbConfiguration config) sqlite,
    required TResult Function(SledDbConfiguration config) sled,
  }) {
    return sled(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? memory,
    TResult? Function(SqliteDbConfiguration config)? sqlite,
    TResult? Function(SledDbConfiguration config)? sled,
  }) {
    return sled?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? memory,
    TResult Function(SqliteDbConfiguration config)? sqlite,
    TResult Function(SledDbConfiguration config)? sled,
    required TResult orElse(),
  }) {
    if (sled != null) {
      return sled(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MEMORY value) memory,
    required TResult Function(SQLITE value) sqlite,
    required TResult Function(SLED value) sled,
  }) {
    return sled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MEMORY value)? memory,
    TResult? Function(SQLITE value)? sqlite,
    TResult? Function(SLED value)? sled,
  }) {
    return sled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MEMORY value)? memory,
    TResult Function(SQLITE value)? sqlite,
    TResult Function(SLED value)? sled,
    required TResult orElse(),
  }) {
    if (sled != null) {
      return sled(this);
    }
    return orElse();
  }
}

abstract class SLED implements DatabaseConfig {
  const factory SLED({required final SledDbConfiguration config}) = _$SLED;

  SledDbConfiguration get config;

  @JsonKey(ignore: true)
  _$$SLEDCopyWith<_$SLED> get copyWith => throw _privateConstructorUsedError;
}
