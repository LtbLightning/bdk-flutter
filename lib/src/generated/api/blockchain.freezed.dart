// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blockchain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Auth {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String username, String password) userPass,
    required TResult Function(String file) cookie,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String file)? cookie,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String username, String password)? userPass,
    TResult Function(String file)? cookie,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Auth_None value) none,
    required TResult Function(Auth_UserPass value) userPass,
    required TResult Function(Auth_Cookie value) cookie,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Auth_None value)? none,
    TResult? Function(Auth_UserPass value)? userPass,
    TResult? Function(Auth_Cookie value)? cookie,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Auth_None value)? none,
    TResult Function(Auth_UserPass value)? userPass,
    TResult Function(Auth_Cookie value)? cookie,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthCopyWith<$Res> {
  factory $AuthCopyWith(Auth value, $Res Function(Auth) then) =
      _$AuthCopyWithImpl<$Res, Auth>;
}

/// @nodoc
class _$AuthCopyWithImpl<$Res, $Val extends Auth>
    implements $AuthCopyWith<$Res> {
  _$AuthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$Auth_NoneImplCopyWith<$Res> {
  factory _$$Auth_NoneImplCopyWith(
          _$Auth_NoneImpl value, $Res Function(_$Auth_NoneImpl) then) =
      __$$Auth_NoneImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$Auth_NoneImplCopyWithImpl<$Res>
    extends _$AuthCopyWithImpl<$Res, _$Auth_NoneImpl>
    implements _$$Auth_NoneImplCopyWith<$Res> {
  __$$Auth_NoneImplCopyWithImpl(
      _$Auth_NoneImpl _value, $Res Function(_$Auth_NoneImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Auth_NoneImpl extends Auth_None {
  const _$Auth_NoneImpl() : super._();

  @override
  String toString() {
    return 'Auth.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Auth_NoneImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String username, String password) userPass,
    required TResult Function(String file) cookie,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String file)? cookie,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String username, String password)? userPass,
    TResult Function(String file)? cookie,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Auth_None value) none,
    required TResult Function(Auth_UserPass value) userPass,
    required TResult Function(Auth_Cookie value) cookie,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Auth_None value)? none,
    TResult? Function(Auth_UserPass value)? userPass,
    TResult? Function(Auth_Cookie value)? cookie,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Auth_None value)? none,
    TResult Function(Auth_UserPass value)? userPass,
    TResult Function(Auth_Cookie value)? cookie,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class Auth_None extends Auth {
  const factory Auth_None() = _$Auth_NoneImpl;
  const Auth_None._() : super._();
}

/// @nodoc
abstract class _$$Auth_UserPassImplCopyWith<$Res> {
  factory _$$Auth_UserPassImplCopyWith(
          _$Auth_UserPassImpl value, $Res Function(_$Auth_UserPassImpl) then) =
      __$$Auth_UserPassImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$Auth_UserPassImplCopyWithImpl<$Res>
    extends _$AuthCopyWithImpl<$Res, _$Auth_UserPassImpl>
    implements _$$Auth_UserPassImplCopyWith<$Res> {
  __$$Auth_UserPassImplCopyWithImpl(
      _$Auth_UserPassImpl _value, $Res Function(_$Auth_UserPassImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$Auth_UserPassImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Auth_UserPassImpl extends Auth_UserPass {
  const _$Auth_UserPassImpl({required this.username, required this.password})
      : super._();

  /// Username
  @override
  final String username;

  /// Password
  @override
  final String password;

  @override
  String toString() {
    return 'Auth.userPass(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Auth_UserPassImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Auth_UserPassImplCopyWith<_$Auth_UserPassImpl> get copyWith =>
      __$$Auth_UserPassImplCopyWithImpl<_$Auth_UserPassImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String username, String password) userPass,
    required TResult Function(String file) cookie,
  }) {
    return userPass(username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String file)? cookie,
  }) {
    return userPass?.call(username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String username, String password)? userPass,
    TResult Function(String file)? cookie,
    required TResult orElse(),
  }) {
    if (userPass != null) {
      return userPass(username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Auth_None value) none,
    required TResult Function(Auth_UserPass value) userPass,
    required TResult Function(Auth_Cookie value) cookie,
  }) {
    return userPass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Auth_None value)? none,
    TResult? Function(Auth_UserPass value)? userPass,
    TResult? Function(Auth_Cookie value)? cookie,
  }) {
    return userPass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Auth_None value)? none,
    TResult Function(Auth_UserPass value)? userPass,
    TResult Function(Auth_Cookie value)? cookie,
    required TResult orElse(),
  }) {
    if (userPass != null) {
      return userPass(this);
    }
    return orElse();
  }
}

abstract class Auth_UserPass extends Auth {
  const factory Auth_UserPass(
      {required final String username,
      required final String password}) = _$Auth_UserPassImpl;
  const Auth_UserPass._() : super._();

  /// Username
  String get username;

  /// Password
  String get password;
  @JsonKey(ignore: true)
  _$$Auth_UserPassImplCopyWith<_$Auth_UserPassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Auth_CookieImplCopyWith<$Res> {
  factory _$$Auth_CookieImplCopyWith(
          _$Auth_CookieImpl value, $Res Function(_$Auth_CookieImpl) then) =
      __$$Auth_CookieImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String file});
}

/// @nodoc
class __$$Auth_CookieImplCopyWithImpl<$Res>
    extends _$AuthCopyWithImpl<$Res, _$Auth_CookieImpl>
    implements _$$Auth_CookieImplCopyWith<$Res> {
  __$$Auth_CookieImplCopyWithImpl(
      _$Auth_CookieImpl _value, $Res Function(_$Auth_CookieImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = null,
  }) {
    return _then(_$Auth_CookieImpl(
      file: null == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Auth_CookieImpl extends Auth_Cookie {
  const _$Auth_CookieImpl({required this.file}) : super._();

  /// Cookie file
  @override
  final String file;

  @override
  String toString() {
    return 'Auth.cookie(file: $file)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Auth_CookieImpl &&
            (identical(other.file, file) || other.file == file));
  }

  @override
  int get hashCode => Object.hash(runtimeType, file);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Auth_CookieImplCopyWith<_$Auth_CookieImpl> get copyWith =>
      __$$Auth_CookieImplCopyWithImpl<_$Auth_CookieImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(String username, String password) userPass,
    required TResult Function(String file) cookie,
  }) {
    return cookie(file);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(String username, String password)? userPass,
    TResult? Function(String file)? cookie,
  }) {
    return cookie?.call(file);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(String username, String password)? userPass,
    TResult Function(String file)? cookie,
    required TResult orElse(),
  }) {
    if (cookie != null) {
      return cookie(file);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Auth_None value) none,
    required TResult Function(Auth_UserPass value) userPass,
    required TResult Function(Auth_Cookie value) cookie,
  }) {
    return cookie(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Auth_None value)? none,
    TResult? Function(Auth_UserPass value)? userPass,
    TResult? Function(Auth_Cookie value)? cookie,
  }) {
    return cookie?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Auth_None value)? none,
    TResult Function(Auth_UserPass value)? userPass,
    TResult Function(Auth_Cookie value)? cookie,
    required TResult orElse(),
  }) {
    if (cookie != null) {
      return cookie(this);
    }
    return orElse();
  }
}

abstract class Auth_Cookie extends Auth {
  const factory Auth_Cookie({required final String file}) = _$Auth_CookieImpl;
  const Auth_Cookie._() : super._();

  /// Cookie file
  String get file;
  @JsonKey(ignore: true)
  _$$Auth_CookieImplCopyWith<_$Auth_CookieImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BlockchainConfig {
  Object get config => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ElectrumConfig config) electrum,
    required TResult Function(EsploraConfig config) esplora,
    required TResult Function(RpcConfig config) rpc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ElectrumConfig config)? electrum,
    TResult? Function(EsploraConfig config)? esplora,
    TResult? Function(RpcConfig config)? rpc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
    TResult Function(RpcConfig config)? rpc,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BlockchainConfig_Electrum value) electrum,
    required TResult Function(BlockchainConfig_Esplora value) esplora,
    required TResult Function(BlockchainConfig_Rpc value) rpc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BlockchainConfig_Electrum value)? electrum,
    TResult? Function(BlockchainConfig_Esplora value)? esplora,
    TResult? Function(BlockchainConfig_Rpc value)? rpc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlockchainConfig_Electrum value)? electrum,
    TResult Function(BlockchainConfig_Esplora value)? esplora,
    TResult Function(BlockchainConfig_Rpc value)? rpc,
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
abstract class _$$BlockchainConfig_ElectrumImplCopyWith<$Res> {
  factory _$$BlockchainConfig_ElectrumImplCopyWith(
          _$BlockchainConfig_ElectrumImpl value,
          $Res Function(_$BlockchainConfig_ElectrumImpl) then) =
      __$$BlockchainConfig_ElectrumImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ElectrumConfig config});
}

/// @nodoc
class __$$BlockchainConfig_ElectrumImplCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res,
        _$BlockchainConfig_ElectrumImpl>
    implements _$$BlockchainConfig_ElectrumImplCopyWith<$Res> {
  __$$BlockchainConfig_ElectrumImplCopyWithImpl(
      _$BlockchainConfig_ElectrumImpl _value,
      $Res Function(_$BlockchainConfig_ElectrumImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$BlockchainConfig_ElectrumImpl(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as ElectrumConfig,
    ));
  }
}

/// @nodoc

class _$BlockchainConfig_ElectrumImpl extends BlockchainConfig_Electrum {
  const _$BlockchainConfig_ElectrumImpl({required this.config}) : super._();

  @override
  final ElectrumConfig config;

  @override
  String toString() {
    return 'BlockchainConfig.electrum(config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockchainConfig_ElectrumImpl &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockchainConfig_ElectrumImplCopyWith<_$BlockchainConfig_ElectrumImpl>
      get copyWith => __$$BlockchainConfig_ElectrumImplCopyWithImpl<
          _$BlockchainConfig_ElectrumImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ElectrumConfig config) electrum,
    required TResult Function(EsploraConfig config) esplora,
    required TResult Function(RpcConfig config) rpc,
  }) {
    return electrum(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ElectrumConfig config)? electrum,
    TResult? Function(EsploraConfig config)? esplora,
    TResult? Function(RpcConfig config)? rpc,
  }) {
    return electrum?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
    TResult Function(RpcConfig config)? rpc,
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
    required TResult Function(BlockchainConfig_Rpc value) rpc,
  }) {
    return electrum(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BlockchainConfig_Electrum value)? electrum,
    TResult? Function(BlockchainConfig_Esplora value)? esplora,
    TResult? Function(BlockchainConfig_Rpc value)? rpc,
  }) {
    return electrum?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlockchainConfig_Electrum value)? electrum,
    TResult Function(BlockchainConfig_Esplora value)? esplora,
    TResult Function(BlockchainConfig_Rpc value)? rpc,
    required TResult orElse(),
  }) {
    if (electrum != null) {
      return electrum(this);
    }
    return orElse();
  }
}

abstract class BlockchainConfig_Electrum extends BlockchainConfig {
  const factory BlockchainConfig_Electrum(
      {required final ElectrumConfig config}) = _$BlockchainConfig_ElectrumImpl;
  const BlockchainConfig_Electrum._() : super._();

  @override
  ElectrumConfig get config;
  @JsonKey(ignore: true)
  _$$BlockchainConfig_ElectrumImplCopyWith<_$BlockchainConfig_ElectrumImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockchainConfig_EsploraImplCopyWith<$Res> {
  factory _$$BlockchainConfig_EsploraImplCopyWith(
          _$BlockchainConfig_EsploraImpl value,
          $Res Function(_$BlockchainConfig_EsploraImpl) then) =
      __$$BlockchainConfig_EsploraImplCopyWithImpl<$Res>;
  @useResult
  $Res call({EsploraConfig config});
}

/// @nodoc
class __$$BlockchainConfig_EsploraImplCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res, _$BlockchainConfig_EsploraImpl>
    implements _$$BlockchainConfig_EsploraImplCopyWith<$Res> {
  __$$BlockchainConfig_EsploraImplCopyWithImpl(
      _$BlockchainConfig_EsploraImpl _value,
      $Res Function(_$BlockchainConfig_EsploraImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$BlockchainConfig_EsploraImpl(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as EsploraConfig,
    ));
  }
}

/// @nodoc

class _$BlockchainConfig_EsploraImpl extends BlockchainConfig_Esplora {
  const _$BlockchainConfig_EsploraImpl({required this.config}) : super._();

  @override
  final EsploraConfig config;

  @override
  String toString() {
    return 'BlockchainConfig.esplora(config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockchainConfig_EsploraImpl &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockchainConfig_EsploraImplCopyWith<_$BlockchainConfig_EsploraImpl>
      get copyWith => __$$BlockchainConfig_EsploraImplCopyWithImpl<
          _$BlockchainConfig_EsploraImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ElectrumConfig config) electrum,
    required TResult Function(EsploraConfig config) esplora,
    required TResult Function(RpcConfig config) rpc,
  }) {
    return esplora(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ElectrumConfig config)? electrum,
    TResult? Function(EsploraConfig config)? esplora,
    TResult? Function(RpcConfig config)? rpc,
  }) {
    return esplora?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
    TResult Function(RpcConfig config)? rpc,
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
    required TResult Function(BlockchainConfig_Rpc value) rpc,
  }) {
    return esplora(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BlockchainConfig_Electrum value)? electrum,
    TResult? Function(BlockchainConfig_Esplora value)? esplora,
    TResult? Function(BlockchainConfig_Rpc value)? rpc,
  }) {
    return esplora?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlockchainConfig_Electrum value)? electrum,
    TResult Function(BlockchainConfig_Esplora value)? esplora,
    TResult Function(BlockchainConfig_Rpc value)? rpc,
    required TResult orElse(),
  }) {
    if (esplora != null) {
      return esplora(this);
    }
    return orElse();
  }
}

abstract class BlockchainConfig_Esplora extends BlockchainConfig {
  const factory BlockchainConfig_Esplora(
      {required final EsploraConfig config}) = _$BlockchainConfig_EsploraImpl;
  const BlockchainConfig_Esplora._() : super._();

  @override
  EsploraConfig get config;
  @JsonKey(ignore: true)
  _$$BlockchainConfig_EsploraImplCopyWith<_$BlockchainConfig_EsploraImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockchainConfig_RpcImplCopyWith<$Res> {
  factory _$$BlockchainConfig_RpcImplCopyWith(_$BlockchainConfig_RpcImpl value,
          $Res Function(_$BlockchainConfig_RpcImpl) then) =
      __$$BlockchainConfig_RpcImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RpcConfig config});
}

/// @nodoc
class __$$BlockchainConfig_RpcImplCopyWithImpl<$Res>
    extends _$BlockchainConfigCopyWithImpl<$Res, _$BlockchainConfig_RpcImpl>
    implements _$$BlockchainConfig_RpcImplCopyWith<$Res> {
  __$$BlockchainConfig_RpcImplCopyWithImpl(_$BlockchainConfig_RpcImpl _value,
      $Res Function(_$BlockchainConfig_RpcImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? config = null,
  }) {
    return _then(_$BlockchainConfig_RpcImpl(
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as RpcConfig,
    ));
  }
}

/// @nodoc

class _$BlockchainConfig_RpcImpl extends BlockchainConfig_Rpc {
  const _$BlockchainConfig_RpcImpl({required this.config}) : super._();

  @override
  final RpcConfig config;

  @override
  String toString() {
    return 'BlockchainConfig.rpc(config: $config)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockchainConfig_RpcImpl &&
            (identical(other.config, config) || other.config == config));
  }

  @override
  int get hashCode => Object.hash(runtimeType, config);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockchainConfig_RpcImplCopyWith<_$BlockchainConfig_RpcImpl>
      get copyWith =>
          __$$BlockchainConfig_RpcImplCopyWithImpl<_$BlockchainConfig_RpcImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ElectrumConfig config) electrum,
    required TResult Function(EsploraConfig config) esplora,
    required TResult Function(RpcConfig config) rpc,
  }) {
    return rpc(config);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ElectrumConfig config)? electrum,
    TResult? Function(EsploraConfig config)? esplora,
    TResult? Function(RpcConfig config)? rpc,
  }) {
    return rpc?.call(config);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ElectrumConfig config)? electrum,
    TResult Function(EsploraConfig config)? esplora,
    TResult Function(RpcConfig config)? rpc,
    required TResult orElse(),
  }) {
    if (rpc != null) {
      return rpc(config);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BlockchainConfig_Electrum value) electrum,
    required TResult Function(BlockchainConfig_Esplora value) esplora,
    required TResult Function(BlockchainConfig_Rpc value) rpc,
  }) {
    return rpc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BlockchainConfig_Electrum value)? electrum,
    TResult? Function(BlockchainConfig_Esplora value)? esplora,
    TResult? Function(BlockchainConfig_Rpc value)? rpc,
  }) {
    return rpc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlockchainConfig_Electrum value)? electrum,
    TResult Function(BlockchainConfig_Esplora value)? esplora,
    TResult Function(BlockchainConfig_Rpc value)? rpc,
    required TResult orElse(),
  }) {
    if (rpc != null) {
      return rpc(this);
    }
    return orElse();
  }
}

abstract class BlockchainConfig_Rpc extends BlockchainConfig {
  const factory BlockchainConfig_Rpc({required final RpcConfig config}) =
      _$BlockchainConfig_RpcImpl;
  const BlockchainConfig_Rpc._() : super._();

  @override
  RpcConfig get config;
  @JsonKey(ignore: true)
  _$$BlockchainConfig_RpcImplCopyWith<_$BlockchainConfig_RpcImpl>
      get copyWith => throw _privateConstructorUsedError;
}
