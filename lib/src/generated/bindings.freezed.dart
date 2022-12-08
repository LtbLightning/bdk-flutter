// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bindings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BlockchainConfig {
  Object get config => throw _privateConstructorUsedError;
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
    required TResult Function(BlockchainConfig_Electrum value) electrum,
    required TResult Function(BlockchainConfig_Esplora value) esplora,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BlockchainConfig_Electrum value)? electrum,
    TResult? Function(BlockchainConfig_Esplora value)? esplora,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlockchainConfig_Electrum value)? electrum,
    TResult Function(BlockchainConfig_Esplora value)? esplora,
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
abstract class _$$BlockchainConfig_ElectrumCopyWith<$Res> {
  factory _$$BlockchainConfig_ElectrumCopyWith(
          _$BlockchainConfig_Electrum value,
          $Res Function(_$BlockchainConfig_Electrum) then) =
      __$$BlockchainConfig_ElectrumCopyWithImpl<$Res>;
  @useResult
  $Res call({ElectrumConfig config});
}

/// @nodoc
class __$$BlockchainConfig_ElectrumCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res, _$BlockchainConfig_Electrum>
    implements _$$BlockchainConfig_ElectrumCopyWith<$Res> {
  __$$BlockchainConfig_ElectrumCopyWithImpl(_$BlockchainConfig_Electrum _value,
      $Res Function(_$BlockchainConfig_Electrum) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$BlockchainConfig_Electrum(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as ElectrumConfig,
    ));
  }
}

/// @nodoc

class _$BlockchainConfig_Electrum implements BlockchainConfig_Electrum {
  const _$BlockchainConfig_Electrum({required this.config});

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
            other is _$BlockchainConfig_Electrum &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockchainConfig_ElectrumCopyWith<_$BlockchainConfig_Electrum>
      get copyWith => __$$BlockchainConfig_ElectrumCopyWithImpl<
          _$BlockchainConfig_Electrum>(this, _$identity);

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
    required TResult Function(BlockchainConfig_Electrum value) electrum,
    required TResult Function(BlockchainConfig_Esplora value) esplora,
  }) {
    return electrum(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BlockchainConfig_Electrum value)? electrum,
    TResult? Function(BlockchainConfig_Esplora value)? esplora,
  }) {
    return electrum?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlockchainConfig_Electrum value)? electrum,
    TResult Function(BlockchainConfig_Esplora value)? esplora,
    required TResult orElse(),
  }) {
    if (electrum != null) {
      return electrum(this);
    }
    return orElse();
  }
}

abstract class BlockchainConfig_Electrum implements BlockchainConfig {
  const factory BlockchainConfig_Electrum(
      {required final ElectrumConfig config}) = _$BlockchainConfig_Electrum;

  @override
  ElectrumConfig get config;
  @JsonKey(ignore: true)
  _$$BlockchainConfig_ElectrumCopyWith<_$BlockchainConfig_Electrum>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockchainConfig_EsploraCopyWith<$Res> {
  factory _$$BlockchainConfig_EsploraCopyWith(_$BlockchainConfig_Esplora value,
          $Res Function(_$BlockchainConfig_Esplora) then) =
      __$$BlockchainConfig_EsploraCopyWithImpl<$Res>;
  @useResult
  $Res call({EsploraConfig config});
}

/// @nodoc
class __$$BlockchainConfig_EsploraCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res, _$BlockchainConfig_Esplora>
    implements _$$BlockchainConfig_EsploraCopyWith<$Res> {
  __$$BlockchainConfig_EsploraCopyWithImpl(_$BlockchainConfig_Esplora _value,
      $Res Function(_$BlockchainConfig_Esplora) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$BlockchainConfig_Esplora(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as EsploraConfig,
    ));
  }
}

/// @nodoc

class _$BlockchainConfig_Esplora implements BlockchainConfig_Esplora {
  const _$BlockchainConfig_Esplora({required this.config});

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
            other is _$BlockchainConfig_Esplora &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockchainConfig_EsploraCopyWith<_$BlockchainConfig_Esplora>
      get copyWith =>
          __$$BlockchainConfig_EsploraCopyWithImpl<_$BlockchainConfig_Esplora>(
              this, _$identity);

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
    required TResult Function(BlockchainConfig_Electrum value) electrum,
    required TResult Function(BlockchainConfig_Esplora value) esplora,
  }) {
    return esplora(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BlockchainConfig_Electrum value)? electrum,
    TResult? Function(BlockchainConfig_Esplora value)? esplora,
  }) {
    return esplora?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlockchainConfig_Electrum value)? electrum,
    TResult Function(BlockchainConfig_Esplora value)? esplora,
    required TResult orElse(),
  }) {
    if (esplora != null) {
      return esplora(this);
    }
    return orElse();
  }
}

abstract class BlockchainConfig_Esplora implements BlockchainConfig {
  const factory BlockchainConfig_Esplora(
      {required final EsploraConfig config}) = _$BlockchainConfig_Esplora;

  @override
  EsploraConfig get config;
  @JsonKey(ignore: true)
  _$$BlockchainConfig_EsploraCopyWith<_$BlockchainConfig_Esplora>
      get copyWith => throw _privateConstructorUsedError;
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
    required TResult Function(DatabaseConfig_Memory value) memory,
    required TResult Function(DatabaseConfig_Sqlite value) sqlite,
    required TResult Function(DatabaseConfig_Sled value) sled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseConfig_Memory value)? memory,
    TResult? Function(DatabaseConfig_Sqlite value)? sqlite,
    TResult? Function(DatabaseConfig_Sled value)? sled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseConfig_Memory value)? memory,
    TResult Function(DatabaseConfig_Sqlite value)? sqlite,
    TResult Function(DatabaseConfig_Sled value)? sled,
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
abstract class _$$DatabaseConfig_MemoryCopyWith<$Res> {
  factory _$$DatabaseConfig_MemoryCopyWith(_$DatabaseConfig_Memory value,
          $Res Function(_$DatabaseConfig_Memory) then) =
      __$$DatabaseConfig_MemoryCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DatabaseConfig_MemoryCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$DatabaseConfig_Memory>
    implements _$$DatabaseConfig_MemoryCopyWith<$Res> {
  __$$DatabaseConfig_MemoryCopyWithImpl(_$DatabaseConfig_Memory _value,
      $Res Function(_$DatabaseConfig_Memory) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DatabaseConfig_Memory implements DatabaseConfig_Memory {
  const _$DatabaseConfig_Memory();

  @override
  String toString() {
    return 'DatabaseConfig.memory()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DatabaseConfig_Memory);
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
    required TResult Function(DatabaseConfig_Memory value) memory,
    required TResult Function(DatabaseConfig_Sqlite value) sqlite,
    required TResult Function(DatabaseConfig_Sled value) sled,
  }) {
    return memory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseConfig_Memory value)? memory,
    TResult? Function(DatabaseConfig_Sqlite value)? sqlite,
    TResult? Function(DatabaseConfig_Sled value)? sled,
  }) {
    return memory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseConfig_Memory value)? memory,
    TResult Function(DatabaseConfig_Sqlite value)? sqlite,
    TResult Function(DatabaseConfig_Sled value)? sled,
    required TResult orElse(),
  }) {
    if (memory != null) {
      return memory(this);
    }
    return orElse();
  }
}

abstract class DatabaseConfig_Memory implements DatabaseConfig {
  const factory DatabaseConfig_Memory() = _$DatabaseConfig_Memory;
}

/// @nodoc
abstract class _$$DatabaseConfig_SqliteCopyWith<$Res> {
  factory _$$DatabaseConfig_SqliteCopyWith(_$DatabaseConfig_Sqlite value,
          $Res Function(_$DatabaseConfig_Sqlite) then) =
      __$$DatabaseConfig_SqliteCopyWithImpl<$Res>;
  @useResult
  $Res call({SqliteDbConfiguration config});
}

/// @nodoc
class __$$DatabaseConfig_SqliteCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$DatabaseConfig_Sqlite>
    implements _$$DatabaseConfig_SqliteCopyWith<$Res> {
  __$$DatabaseConfig_SqliteCopyWithImpl(_$DatabaseConfig_Sqlite _value,
      $Res Function(_$DatabaseConfig_Sqlite) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$DatabaseConfig_Sqlite(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as SqliteDbConfiguration,
    ));
  }
}

/// @nodoc

class _$DatabaseConfig_Sqlite implements DatabaseConfig_Sqlite {
  const _$DatabaseConfig_Sqlite({required this.config});

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
            other is _$DatabaseConfig_Sqlite &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseConfig_SqliteCopyWith<_$DatabaseConfig_Sqlite> get copyWith =>
      __$$DatabaseConfig_SqliteCopyWithImpl<_$DatabaseConfig_Sqlite>(
          this, _$identity);

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
    required TResult Function(DatabaseConfig_Memory value) memory,
    required TResult Function(DatabaseConfig_Sqlite value) sqlite,
    required TResult Function(DatabaseConfig_Sled value) sled,
  }) {
    return sqlite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseConfig_Memory value)? memory,
    TResult? Function(DatabaseConfig_Sqlite value)? sqlite,
    TResult? Function(DatabaseConfig_Sled value)? sled,
  }) {
    return sqlite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseConfig_Memory value)? memory,
    TResult Function(DatabaseConfig_Sqlite value)? sqlite,
    TResult Function(DatabaseConfig_Sled value)? sled,
    required TResult orElse(),
  }) {
    if (sqlite != null) {
      return sqlite(this);
    }
    return orElse();
  }
}

abstract class DatabaseConfig_Sqlite implements DatabaseConfig {
  const factory DatabaseConfig_Sqlite(
      {required final SqliteDbConfiguration config}) = _$DatabaseConfig_Sqlite;

  SqliteDbConfiguration get config;
  @JsonKey(ignore: true)
  _$$DatabaseConfig_SqliteCopyWith<_$DatabaseConfig_Sqlite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseConfig_SledCopyWith<$Res> {
  factory _$$DatabaseConfig_SledCopyWith(_$DatabaseConfig_Sled value,
          $Res Function(_$DatabaseConfig_Sled) then) =
      __$$DatabaseConfig_SledCopyWithImpl<$Res>;
  @useResult
  $Res call({SledDbConfiguration config});
}

/// @nodoc
class __$$DatabaseConfig_SledCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$DatabaseConfig_Sled>
    implements _$$DatabaseConfig_SledCopyWith<$Res> {
  __$$DatabaseConfig_SledCopyWithImpl(
      _$DatabaseConfig_Sled _value, $Res Function(_$DatabaseConfig_Sled) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$DatabaseConfig_Sled(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as SledDbConfiguration,
    ));
  }
}

/// @nodoc

class _$DatabaseConfig_Sled implements DatabaseConfig_Sled {
  const _$DatabaseConfig_Sled({required this.config});

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
            other is _$DatabaseConfig_Sled &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseConfig_SledCopyWith<_$DatabaseConfig_Sled> get copyWith =>
      __$$DatabaseConfig_SledCopyWithImpl<_$DatabaseConfig_Sled>(
          this, _$identity);

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
    required TResult Function(DatabaseConfig_Memory value) memory,
    required TResult Function(DatabaseConfig_Sqlite value) sqlite,
    required TResult Function(DatabaseConfig_Sled value) sled,
  }) {
    return sled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DatabaseConfig_Memory value)? memory,
    TResult? Function(DatabaseConfig_Sqlite value)? sqlite,
    TResult? Function(DatabaseConfig_Sled value)? sled,
  }) {
    return sled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DatabaseConfig_Memory value)? memory,
    TResult Function(DatabaseConfig_Sqlite value)? sqlite,
    TResult Function(DatabaseConfig_Sled value)? sled,
    required TResult orElse(),
  }) {
    if (sled != null) {
      return sled(this);
    }
    return orElse();
  }
}

abstract class DatabaseConfig_Sled implements DatabaseConfig {
  const factory DatabaseConfig_Sled(
      {required final SledDbConfiguration config}) = _$DatabaseConfig_Sled;

  SledDbConfiguration get config;
  @JsonKey(ignore: true)
  _$$DatabaseConfig_SledCopyWith<_$DatabaseConfig_Sled> get copyWith =>
      throw _privateConstructorUsedError;
}
