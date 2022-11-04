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
    required TResult Function(Electrum value) electrum,
    required TResult Function(Esplora value) esplora,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Electrum value)? electrum,
    TResult? Function(Esplora value)? esplora,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Electrum value)? electrum,
    TResult Function(Esplora value)? esplora,
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
abstract class _$$ElectrumCopyWith<$Res> {
  factory _$$ElectrumCopyWith(
          _$Electrum value, $Res Function(_$Electrum) then) =
      __$$ElectrumCopyWithImpl<$Res>;
  @useResult
  $Res call({ElectrumConfig config});
}

/// @nodoc
class __$$ElectrumCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res, _$Electrum>
    implements _$$ElectrumCopyWith<$Res> {
  __$$ElectrumCopyWithImpl(_$Electrum _value, $Res Function(_$Electrum) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$Electrum(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as ElectrumConfig,
    ));
  }
}

/// @nodoc

class _$Electrum implements Electrum {
  const _$Electrum({required this.config});

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
            other is _$Electrum &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectrumCopyWith<_$Electrum> get copyWith =>
      __$$ElectrumCopyWithImpl<_$Electrum>(this, _$identity);

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
    required TResult Function(Electrum value) electrum,
    required TResult Function(Esplora value) esplora,
  }) {
    return electrum(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Electrum value)? electrum,
    TResult? Function(Esplora value)? esplora,
  }) {
    return electrum?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Electrum value)? electrum,
    TResult Function(Esplora value)? esplora,
    required TResult orElse(),
  }) {
    if (electrum != null) {
      return electrum(this);
    }
    return orElse();
  }
}

abstract class Electrum implements BlockchainConfig {
  const factory Electrum({required final ElectrumConfig config}) = _$Electrum;

  ElectrumConfig get config;
  @JsonKey(ignore: true)
  _$$ElectrumCopyWith<_$Electrum> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EsploraCopyWith<$Res> {
  factory _$$EsploraCopyWith(_$Esplora value, $Res Function(_$Esplora) then) =
      __$$EsploraCopyWithImpl<$Res>;
  @useResult
  $Res call({EsploraConfig config});
}

/// @nodoc
class __$$EsploraCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res, _$Esplora>
    implements _$$EsploraCopyWith<$Res> {
  __$$EsploraCopyWithImpl(_$Esplora _value, $Res Function(_$Esplora) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$Esplora(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as EsploraConfig,
    ));
  }
}

/// @nodoc

class _$Esplora implements Esplora {
  const _$Esplora({required this.config});

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
            other is _$Esplora &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EsploraCopyWith<_$Esplora> get copyWith =>
      __$$EsploraCopyWithImpl<_$Esplora>(this, _$identity);

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
    required TResult Function(Electrum value) electrum,
    required TResult Function(Esplora value) esplora,
  }) {
    return esplora(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Electrum value)? electrum,
    TResult? Function(Esplora value)? esplora,
  }) {
    return esplora?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Electrum value)? electrum,
    TResult Function(Esplora value)? esplora,
    required TResult orElse(),
  }) {
    if (esplora != null) {
      return esplora(this);
    }
    return orElse();
  }
}

abstract class Esplora implements BlockchainConfig {
  const factory Esplora({required final EsploraConfig config}) = _$Esplora;

  EsploraConfig get config;
  @JsonKey(ignore: true)
  _$$EsploraCopyWith<_$Esplora> get copyWith =>
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
    required TResult Function(Memory value) memory,
    required TResult Function(Sqlite value) sqlite,
    required TResult Function(Sled value) sled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Memory value)? memory,
    TResult? Function(Sqlite value)? sqlite,
    TResult? Function(Sled value)? sled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Memory value)? memory,
    TResult Function(Sqlite value)? sqlite,
    TResult Function(Sled value)? sled,
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
abstract class _$$MemoryCopyWith<$Res> {
  factory _$$MemoryCopyWith(_$Memory value, $Res Function(_$Memory) then) =
      __$$MemoryCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MemoryCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$Memory>
    implements _$$MemoryCopyWith<$Res> {
  __$$MemoryCopyWithImpl(_$Memory _value, $Res Function(_$Memory) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Memory implements Memory {
  const _$Memory();

  @override
  String toString() {
    return 'DatabaseConfig.memory()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Memory);
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
    required TResult Function(Memory value) memory,
    required TResult Function(Sqlite value) sqlite,
    required TResult Function(Sled value) sled,
  }) {
    return memory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Memory value)? memory,
    TResult? Function(Sqlite value)? sqlite,
    TResult? Function(Sled value)? sled,
  }) {
    return memory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Memory value)? memory,
    TResult Function(Sqlite value)? sqlite,
    TResult Function(Sled value)? sled,
    required TResult orElse(),
  }) {
    if (memory != null) {
      return memory(this);
    }
    return orElse();
  }
}

abstract class Memory implements DatabaseConfig {
  const factory Memory() = _$Memory;
}

/// @nodoc
abstract class _$$SqliteCopyWith<$Res> {
  factory _$$SqliteCopyWith(_$Sqlite value, $Res Function(_$Sqlite) then) =
      __$$SqliteCopyWithImpl<$Res>;
  @useResult
  $Res call({SqliteDbConfiguration config});
}

/// @nodoc
class __$$SqliteCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$Sqlite>
    implements _$$SqliteCopyWith<$Res> {
  __$$SqliteCopyWithImpl(_$Sqlite _value, $Res Function(_$Sqlite) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$Sqlite(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as SqliteDbConfiguration,
    ));
  }
}

/// @nodoc

class _$Sqlite implements Sqlite {
  const _$Sqlite({required this.config});

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
            other is _$Sqlite &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SqliteCopyWith<_$Sqlite> get copyWith =>
      __$$SqliteCopyWithImpl<_$Sqlite>(this, _$identity);

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
    required TResult Function(Memory value) memory,
    required TResult Function(Sqlite value) sqlite,
    required TResult Function(Sled value) sled,
  }) {
    return sqlite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Memory value)? memory,
    TResult? Function(Sqlite value)? sqlite,
    TResult? Function(Sled value)? sled,
  }) {
    return sqlite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Memory value)? memory,
    TResult Function(Sqlite value)? sqlite,
    TResult Function(Sled value)? sled,
    required TResult orElse(),
  }) {
    if (sqlite != null) {
      return sqlite(this);
    }
    return orElse();
  }
}

abstract class Sqlite implements DatabaseConfig {
  const factory Sqlite({required final SqliteDbConfiguration config}) =
      _$Sqlite;

  SqliteDbConfiguration get config;
  @JsonKey(ignore: true)
  _$$SqliteCopyWith<_$Sqlite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SledCopyWith<$Res> {
  factory _$$SledCopyWith(_$Sled value, $Res Function(_$Sled) then) =
      __$$SledCopyWithImpl<$Res>;
  @useResult
  $Res call({SledDbConfiguration config});
}

/// @nodoc
class __$$SledCopyWithImpl<$Res>
    extends _$DatabaseConfigCopyWithImpl<$Res, _$Sled>
    implements _$$SledCopyWith<$Res> {
  __$$SledCopyWithImpl(_$Sled _value, $Res Function(_$Sled) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$Sled(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as SledDbConfiguration,
    ));
  }
}

/// @nodoc

class _$Sled implements Sled {
  const _$Sled({required this.config});

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
            other is _$Sled &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SledCopyWith<_$Sled> get copyWith =>
      __$$SledCopyWithImpl<_$Sled>(this, _$identity);

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
    required TResult Function(Memory value) memory,
    required TResult Function(Sqlite value) sqlite,
    required TResult Function(Sled value) sled,
  }) {
    return sled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Memory value)? memory,
    TResult? Function(Sqlite value)? sqlite,
    TResult? Function(Sled value)? sled,
  }) {
    return sled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Memory value)? memory,
    TResult Function(Sqlite value)? sqlite,
    TResult Function(Sled value)? sled,
    required TResult orElse(),
  }) {
    if (sled != null) {
      return sled(this);
    }
    return orElse();
  }
}

abstract class Sled implements DatabaseConfig {
  const factory Sled({required final SledDbConfiguration config}) = _$Sled;

  SledDbConfiguration get config;
  @JsonKey(ignore: true)
  _$$SledCopyWith<_$Sled> get copyWith => throw _privateConstructorUsedError;
}
