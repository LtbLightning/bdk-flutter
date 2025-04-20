// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blockchain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Auth {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Auth);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Auth()';
}


}

/// @nodoc
class $AuthCopyWith<$Res>  {
$AuthCopyWith(Auth _, $Res Function(Auth) __);
}


/// @nodoc


class Auth_None extends Auth {
  const Auth_None(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Auth_None);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Auth.none()';
}


}




/// @nodoc


class Auth_UserPass extends Auth {
  const Auth_UserPass({required this.username, required this.password}): super._();
  

/// Username
 final  String username;
/// Password
 final  String password;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Auth_UserPassCopyWith<Auth_UserPass> get copyWith => _$Auth_UserPassCopyWithImpl<Auth_UserPass>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Auth_UserPass&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,username,password);

@override
String toString() {
  return 'Auth.userPass(username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class $Auth_UserPassCopyWith<$Res> implements $AuthCopyWith<$Res> {
  factory $Auth_UserPassCopyWith(Auth_UserPass value, $Res Function(Auth_UserPass) _then) = _$Auth_UserPassCopyWithImpl;
@useResult
$Res call({
 String username, String password
});




}
/// @nodoc
class _$Auth_UserPassCopyWithImpl<$Res>
    implements $Auth_UserPassCopyWith<$Res> {
  _$Auth_UserPassCopyWithImpl(this._self, this._then);

  final Auth_UserPass _self;
  final $Res Function(Auth_UserPass) _then;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,}) {
  return _then(Auth_UserPass(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Auth_Cookie extends Auth {
  const Auth_Cookie({required this.file}): super._();
  

/// Cookie file
 final  String file;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Auth_CookieCopyWith<Auth_Cookie> get copyWith => _$Auth_CookieCopyWithImpl<Auth_Cookie>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Auth_Cookie&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'Auth.cookie(file: $file)';
}


}

/// @nodoc
abstract mixin class $Auth_CookieCopyWith<$Res> implements $AuthCopyWith<$Res> {
  factory $Auth_CookieCopyWith(Auth_Cookie value, $Res Function(Auth_Cookie) _then) = _$Auth_CookieCopyWithImpl;
@useResult
$Res call({
 String file
});




}
/// @nodoc
class _$Auth_CookieCopyWithImpl<$Res>
    implements $Auth_CookieCopyWith<$Res> {
  _$Auth_CookieCopyWithImpl(this._self, this._then);

  final Auth_Cookie _self;
  final $Res Function(Auth_Cookie) _then;

/// Create a copy of Auth
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,}) {
  return _then(Auth_Cookie(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BlockchainConfig {

 Object get config;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockchainConfig&&const DeepCollectionEquality().equals(other.config, config));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(config));

@override
String toString() {
  return 'BlockchainConfig(config: $config)';
}


}

/// @nodoc
class $BlockchainConfigCopyWith<$Res>  {
$BlockchainConfigCopyWith(BlockchainConfig _, $Res Function(BlockchainConfig) __);
}


/// @nodoc


class BlockchainConfig_Electrum extends BlockchainConfig {
  const BlockchainConfig_Electrum({required this.config}): super._();
  

@override final  ElectrumConfig config;

/// Create a copy of BlockchainConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockchainConfig_ElectrumCopyWith<BlockchainConfig_Electrum> get copyWith => _$BlockchainConfig_ElectrumCopyWithImpl<BlockchainConfig_Electrum>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockchainConfig_Electrum&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,config);

@override
String toString() {
  return 'BlockchainConfig.electrum(config: $config)';
}


}

/// @nodoc
abstract mixin class $BlockchainConfig_ElectrumCopyWith<$Res> implements $BlockchainConfigCopyWith<$Res> {
  factory $BlockchainConfig_ElectrumCopyWith(BlockchainConfig_Electrum value, $Res Function(BlockchainConfig_Electrum) _then) = _$BlockchainConfig_ElectrumCopyWithImpl;
@useResult
$Res call({
 ElectrumConfig config
});




}
/// @nodoc
class _$BlockchainConfig_ElectrumCopyWithImpl<$Res>
    implements $BlockchainConfig_ElectrumCopyWith<$Res> {
  _$BlockchainConfig_ElectrumCopyWithImpl(this._self, this._then);

  final BlockchainConfig_Electrum _self;
  final $Res Function(BlockchainConfig_Electrum) _then;

/// Create a copy of BlockchainConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,}) {
  return _then(BlockchainConfig_Electrum(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ElectrumConfig,
  ));
}


}

/// @nodoc


class BlockchainConfig_Esplora extends BlockchainConfig {
  const BlockchainConfig_Esplora({required this.config}): super._();
  

@override final  EsploraConfig config;

/// Create a copy of BlockchainConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockchainConfig_EsploraCopyWith<BlockchainConfig_Esplora> get copyWith => _$BlockchainConfig_EsploraCopyWithImpl<BlockchainConfig_Esplora>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockchainConfig_Esplora&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,config);

@override
String toString() {
  return 'BlockchainConfig.esplora(config: $config)';
}


}

/// @nodoc
abstract mixin class $BlockchainConfig_EsploraCopyWith<$Res> implements $BlockchainConfigCopyWith<$Res> {
  factory $BlockchainConfig_EsploraCopyWith(BlockchainConfig_Esplora value, $Res Function(BlockchainConfig_Esplora) _then) = _$BlockchainConfig_EsploraCopyWithImpl;
@useResult
$Res call({
 EsploraConfig config
});




}
/// @nodoc
class _$BlockchainConfig_EsploraCopyWithImpl<$Res>
    implements $BlockchainConfig_EsploraCopyWith<$Res> {
  _$BlockchainConfig_EsploraCopyWithImpl(this._self, this._then);

  final BlockchainConfig_Esplora _self;
  final $Res Function(BlockchainConfig_Esplora) _then;

/// Create a copy of BlockchainConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,}) {
  return _then(BlockchainConfig_Esplora(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as EsploraConfig,
  ));
}


}

/// @nodoc


class BlockchainConfig_Rpc extends BlockchainConfig {
  const BlockchainConfig_Rpc({required this.config}): super._();
  

@override final  RpcConfig config;

/// Create a copy of BlockchainConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockchainConfig_RpcCopyWith<BlockchainConfig_Rpc> get copyWith => _$BlockchainConfig_RpcCopyWithImpl<BlockchainConfig_Rpc>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockchainConfig_Rpc&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,config);

@override
String toString() {
  return 'BlockchainConfig.rpc(config: $config)';
}


}

/// @nodoc
abstract mixin class $BlockchainConfig_RpcCopyWith<$Res> implements $BlockchainConfigCopyWith<$Res> {
  factory $BlockchainConfig_RpcCopyWith(BlockchainConfig_Rpc value, $Res Function(BlockchainConfig_Rpc) _then) = _$BlockchainConfig_RpcCopyWithImpl;
@useResult
$Res call({
 RpcConfig config
});




}
/// @nodoc
class _$BlockchainConfig_RpcCopyWithImpl<$Res>
    implements $BlockchainConfig_RpcCopyWith<$Res> {
  _$BlockchainConfig_RpcCopyWithImpl(this._self, this._then);

  final BlockchainConfig_Rpc _self;
  final $Res Function(BlockchainConfig_Rpc) _then;

/// Create a copy of BlockchainConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,}) {
  return _then(BlockchainConfig_Rpc(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as RpcConfig,
  ));
}


}

// dart format on
