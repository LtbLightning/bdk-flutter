// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Payload {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pubkeyHash) pubkeyHash,
    required TResult Function(String scriptHash) scriptHash,
    required TResult Function(WitnessVersion version, Uint8List program)
        witnessProgram,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pubkeyHash)? pubkeyHash,
    TResult? Function(String scriptHash)? scriptHash,
    TResult? Function(WitnessVersion version, Uint8List program)?
        witnessProgram,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pubkeyHash)? pubkeyHash,
    TResult Function(String scriptHash)? scriptHash,
    TResult Function(WitnessVersion version, Uint8List program)? witnessProgram,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Payload_PubkeyHash value) pubkeyHash,
    required TResult Function(Payload_ScriptHash value) scriptHash,
    required TResult Function(Payload_WitnessProgram value) witnessProgram,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Payload_PubkeyHash value)? pubkeyHash,
    TResult? Function(Payload_ScriptHash value)? scriptHash,
    TResult? Function(Payload_WitnessProgram value)? witnessProgram,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Payload_PubkeyHash value)? pubkeyHash,
    TResult Function(Payload_ScriptHash value)? scriptHash,
    TResult Function(Payload_WitnessProgram value)? witnessProgram,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayloadCopyWith<$Res> {
  factory $PayloadCopyWith(Payload value, $Res Function(Payload) then) =
      _$PayloadCopyWithImpl<$Res, Payload>;
}

/// @nodoc
class _$PayloadCopyWithImpl<$Res, $Val extends Payload>
    implements $PayloadCopyWith<$Res> {
  _$PayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$Payload_PubkeyHashImplCopyWith<$Res> {
  factory _$$Payload_PubkeyHashImplCopyWith(_$Payload_PubkeyHashImpl value,
          $Res Function(_$Payload_PubkeyHashImpl) then) =
      __$$Payload_PubkeyHashImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String pubkeyHash});
}

/// @nodoc
class __$$Payload_PubkeyHashImplCopyWithImpl<$Res>
    extends _$PayloadCopyWithImpl<$Res, _$Payload_PubkeyHashImpl>
    implements _$$Payload_PubkeyHashImplCopyWith<$Res> {
  __$$Payload_PubkeyHashImplCopyWithImpl(_$Payload_PubkeyHashImpl _value,
      $Res Function(_$Payload_PubkeyHashImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pubkeyHash = null,
  }) {
    return _then(_$Payload_PubkeyHashImpl(
      pubkeyHash: null == pubkeyHash
          ? _value.pubkeyHash
          : pubkeyHash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Payload_PubkeyHashImpl implements Payload_PubkeyHash {
  const _$Payload_PubkeyHashImpl({required this.pubkeyHash});

  @override
  final String pubkeyHash;

  @override
  String toString() {
    return 'Payload.pubkeyHash(pubkeyHash: $pubkeyHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Payload_PubkeyHashImpl &&
            (identical(other.pubkeyHash, pubkeyHash) ||
                other.pubkeyHash == pubkeyHash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pubkeyHash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Payload_PubkeyHashImplCopyWith<_$Payload_PubkeyHashImpl> get copyWith =>
      __$$Payload_PubkeyHashImplCopyWithImpl<_$Payload_PubkeyHashImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pubkeyHash) pubkeyHash,
    required TResult Function(String scriptHash) scriptHash,
    required TResult Function(WitnessVersion version, Uint8List program)
        witnessProgram,
  }) {
    return pubkeyHash(this.pubkeyHash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pubkeyHash)? pubkeyHash,
    TResult? Function(String scriptHash)? scriptHash,
    TResult? Function(WitnessVersion version, Uint8List program)?
        witnessProgram,
  }) {
    return pubkeyHash?.call(this.pubkeyHash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pubkeyHash)? pubkeyHash,
    TResult Function(String scriptHash)? scriptHash,
    TResult Function(WitnessVersion version, Uint8List program)? witnessProgram,
    required TResult orElse(),
  }) {
    if (pubkeyHash != null) {
      return pubkeyHash(this.pubkeyHash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Payload_PubkeyHash value) pubkeyHash,
    required TResult Function(Payload_ScriptHash value) scriptHash,
    required TResult Function(Payload_WitnessProgram value) witnessProgram,
  }) {
    return pubkeyHash(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Payload_PubkeyHash value)? pubkeyHash,
    TResult? Function(Payload_ScriptHash value)? scriptHash,
    TResult? Function(Payload_WitnessProgram value)? witnessProgram,
  }) {
    return pubkeyHash?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Payload_PubkeyHash value)? pubkeyHash,
    TResult Function(Payload_ScriptHash value)? scriptHash,
    TResult Function(Payload_WitnessProgram value)? witnessProgram,
    required TResult orElse(),
  }) {
    if (pubkeyHash != null) {
      return pubkeyHash(this);
    }
    return orElse();
  }
}

abstract class Payload_PubkeyHash implements Payload {
  const factory Payload_PubkeyHash({required final String pubkeyHash}) =
      _$Payload_PubkeyHashImpl;

  String get pubkeyHash;
  @JsonKey(ignore: true)
  _$$Payload_PubkeyHashImplCopyWith<_$Payload_PubkeyHashImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Payload_ScriptHashImplCopyWith<$Res> {
  factory _$$Payload_ScriptHashImplCopyWith(_$Payload_ScriptHashImpl value,
          $Res Function(_$Payload_ScriptHashImpl) then) =
      __$$Payload_ScriptHashImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String scriptHash});
}

/// @nodoc
class __$$Payload_ScriptHashImplCopyWithImpl<$Res>
    extends _$PayloadCopyWithImpl<$Res, _$Payload_ScriptHashImpl>
    implements _$$Payload_ScriptHashImplCopyWith<$Res> {
  __$$Payload_ScriptHashImplCopyWithImpl(_$Payload_ScriptHashImpl _value,
      $Res Function(_$Payload_ScriptHashImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scriptHash = null,
  }) {
    return _then(_$Payload_ScriptHashImpl(
      scriptHash: null == scriptHash
          ? _value.scriptHash
          : scriptHash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Payload_ScriptHashImpl implements Payload_ScriptHash {
  const _$Payload_ScriptHashImpl({required this.scriptHash});

  @override
  final String scriptHash;

  @override
  String toString() {
    return 'Payload.scriptHash(scriptHash: $scriptHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Payload_ScriptHashImpl &&
            (identical(other.scriptHash, scriptHash) ||
                other.scriptHash == scriptHash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, scriptHash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Payload_ScriptHashImplCopyWith<_$Payload_ScriptHashImpl> get copyWith =>
      __$$Payload_ScriptHashImplCopyWithImpl<_$Payload_ScriptHashImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pubkeyHash) pubkeyHash,
    required TResult Function(String scriptHash) scriptHash,
    required TResult Function(WitnessVersion version, Uint8List program)
        witnessProgram,
  }) {
    return scriptHash(this.scriptHash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pubkeyHash)? pubkeyHash,
    TResult? Function(String scriptHash)? scriptHash,
    TResult? Function(WitnessVersion version, Uint8List program)?
        witnessProgram,
  }) {
    return scriptHash?.call(this.scriptHash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pubkeyHash)? pubkeyHash,
    TResult Function(String scriptHash)? scriptHash,
    TResult Function(WitnessVersion version, Uint8List program)? witnessProgram,
    required TResult orElse(),
  }) {
    if (scriptHash != null) {
      return scriptHash(this.scriptHash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Payload_PubkeyHash value) pubkeyHash,
    required TResult Function(Payload_ScriptHash value) scriptHash,
    required TResult Function(Payload_WitnessProgram value) witnessProgram,
  }) {
    return scriptHash(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Payload_PubkeyHash value)? pubkeyHash,
    TResult? Function(Payload_ScriptHash value)? scriptHash,
    TResult? Function(Payload_WitnessProgram value)? witnessProgram,
  }) {
    return scriptHash?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Payload_PubkeyHash value)? pubkeyHash,
    TResult Function(Payload_ScriptHash value)? scriptHash,
    TResult Function(Payload_WitnessProgram value)? witnessProgram,
    required TResult orElse(),
  }) {
    if (scriptHash != null) {
      return scriptHash(this);
    }
    return orElse();
  }
}

abstract class Payload_ScriptHash implements Payload {
  const factory Payload_ScriptHash({required final String scriptHash}) =
      _$Payload_ScriptHashImpl;

  String get scriptHash;
  @JsonKey(ignore: true)
  _$$Payload_ScriptHashImplCopyWith<_$Payload_ScriptHashImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Payload_WitnessProgramImplCopyWith<$Res> {
  factory _$$Payload_WitnessProgramImplCopyWith(
          _$Payload_WitnessProgramImpl value,
          $Res Function(_$Payload_WitnessProgramImpl) then) =
      __$$Payload_WitnessProgramImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WitnessVersion version, Uint8List program});
}

/// @nodoc
class __$$Payload_WitnessProgramImplCopyWithImpl<$Res>
    extends _$PayloadCopyWithImpl<$Res, _$Payload_WitnessProgramImpl>
    implements _$$Payload_WitnessProgramImplCopyWith<$Res> {
  __$$Payload_WitnessProgramImplCopyWithImpl(
      _$Payload_WitnessProgramImpl _value,
      $Res Function(_$Payload_WitnessProgramImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? program = null,
  }) {
    return _then(_$Payload_WitnessProgramImpl(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as WitnessVersion,
      program: null == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$Payload_WitnessProgramImpl implements Payload_WitnessProgram {
  const _$Payload_WitnessProgramImpl(
      {required this.version, required this.program});

  /// The witness program version.
  @override
  final WitnessVersion version;

  /// The witness program.
  @override
  final Uint8List program;

  @override
  String toString() {
    return 'Payload.witnessProgram(version: $version, program: $program)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Payload_WitnessProgramImpl &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other.program, program));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, version, const DeepCollectionEquality().hash(program));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Payload_WitnessProgramImplCopyWith<_$Payload_WitnessProgramImpl>
      get copyWith => __$$Payload_WitnessProgramImplCopyWithImpl<
          _$Payload_WitnessProgramImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pubkeyHash) pubkeyHash,
    required TResult Function(String scriptHash) scriptHash,
    required TResult Function(WitnessVersion version, Uint8List program)
        witnessProgram,
  }) {
    return witnessProgram(version, program);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pubkeyHash)? pubkeyHash,
    TResult? Function(String scriptHash)? scriptHash,
    TResult? Function(WitnessVersion version, Uint8List program)?
        witnessProgram,
  }) {
    return witnessProgram?.call(version, program);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pubkeyHash)? pubkeyHash,
    TResult Function(String scriptHash)? scriptHash,
    TResult Function(WitnessVersion version, Uint8List program)? witnessProgram,
    required TResult orElse(),
  }) {
    if (witnessProgram != null) {
      return witnessProgram(version, program);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Payload_PubkeyHash value) pubkeyHash,
    required TResult Function(Payload_ScriptHash value) scriptHash,
    required TResult Function(Payload_WitnessProgram value) witnessProgram,
  }) {
    return witnessProgram(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Payload_PubkeyHash value)? pubkeyHash,
    TResult? Function(Payload_ScriptHash value)? scriptHash,
    TResult? Function(Payload_WitnessProgram value)? witnessProgram,
  }) {
    return witnessProgram?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Payload_PubkeyHash value)? pubkeyHash,
    TResult Function(Payload_ScriptHash value)? scriptHash,
    TResult Function(Payload_WitnessProgram value)? witnessProgram,
    required TResult orElse(),
  }) {
    if (witnessProgram != null) {
      return witnessProgram(this);
    }
    return orElse();
  }
}

abstract class Payload_WitnessProgram implements Payload {
  const factory Payload_WitnessProgram(
      {required final WitnessVersion version,
      required final Uint8List program}) = _$Payload_WitnessProgramImpl;

  /// The witness program version.
  WitnessVersion get version;

  /// The witness program.
  Uint8List get program;
  @JsonKey(ignore: true)
  _$$Payload_WitnessProgramImplCopyWith<_$Payload_WitnessProgramImpl>
      get copyWith => throw _privateConstructorUsedError;
}
