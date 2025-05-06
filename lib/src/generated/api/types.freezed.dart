// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddressIndex {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressIndex);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddressIndex()';
}


}

/// @nodoc
class $AddressIndexCopyWith<$Res>  {
$AddressIndexCopyWith(AddressIndex _, $Res Function(AddressIndex) __);
}


/// @nodoc


class AddressIndex_Increase extends AddressIndex {
  const AddressIndex_Increase(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressIndex_Increase);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddressIndex.increase()';
}


}




/// @nodoc


class AddressIndex_LastUnused extends AddressIndex {
  const AddressIndex_LastUnused(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressIndex_LastUnused);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddressIndex.lastUnused()';
}


}




/// @nodoc


class AddressIndex_Peek extends AddressIndex {
  const AddressIndex_Peek({required this.index}): super._();
  

 final  int index;

/// Create a copy of AddressIndex
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressIndex_PeekCopyWith<AddressIndex_Peek> get copyWith => _$AddressIndex_PeekCopyWithImpl<AddressIndex_Peek>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressIndex_Peek&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'AddressIndex.peek(index: $index)';
}


}

/// @nodoc
abstract mixin class $AddressIndex_PeekCopyWith<$Res> implements $AddressIndexCopyWith<$Res> {
  factory $AddressIndex_PeekCopyWith(AddressIndex_Peek value, $Res Function(AddressIndex_Peek) _then) = _$AddressIndex_PeekCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$AddressIndex_PeekCopyWithImpl<$Res>
    implements $AddressIndex_PeekCopyWith<$Res> {
  _$AddressIndex_PeekCopyWithImpl(this._self, this._then);

  final AddressIndex_Peek _self;
  final $Res Function(AddressIndex_Peek) _then;

/// Create a copy of AddressIndex
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(AddressIndex_Peek(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class AddressIndex_Reset extends AddressIndex {
  const AddressIndex_Reset({required this.index}): super._();
  

 final  int index;

/// Create a copy of AddressIndex
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressIndex_ResetCopyWith<AddressIndex_Reset> get copyWith => _$AddressIndex_ResetCopyWithImpl<AddressIndex_Reset>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressIndex_Reset&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'AddressIndex.reset(index: $index)';
}


}

/// @nodoc
abstract mixin class $AddressIndex_ResetCopyWith<$Res> implements $AddressIndexCopyWith<$Res> {
  factory $AddressIndex_ResetCopyWith(AddressIndex_Reset value, $Res Function(AddressIndex_Reset) _then) = _$AddressIndex_ResetCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$AddressIndex_ResetCopyWithImpl<$Res>
    implements $AddressIndex_ResetCopyWith<$Res> {
  _$AddressIndex_ResetCopyWithImpl(this._self, this._then);

  final AddressIndex_Reset _self;
  final $Res Function(AddressIndex_Reset) _then;

/// Create a copy of AddressIndex
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(AddressIndex_Reset(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$DatabaseConfig {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseConfig);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DatabaseConfig()';
}


}

/// @nodoc
class $DatabaseConfigCopyWith<$Res>  {
$DatabaseConfigCopyWith(DatabaseConfig _, $Res Function(DatabaseConfig) __);
}


/// @nodoc


class DatabaseConfig_Memory extends DatabaseConfig {
  const DatabaseConfig_Memory(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseConfig_Memory);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DatabaseConfig.memory()';
}


}




/// @nodoc


class DatabaseConfig_Sqlite extends DatabaseConfig {
  const DatabaseConfig_Sqlite({required this.config}): super._();
  

 final  SqliteDbConfiguration config;

/// Create a copy of DatabaseConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabaseConfig_SqliteCopyWith<DatabaseConfig_Sqlite> get copyWith => _$DatabaseConfig_SqliteCopyWithImpl<DatabaseConfig_Sqlite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseConfig_Sqlite&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,config);

@override
String toString() {
  return 'DatabaseConfig.sqlite(config: $config)';
}


}

/// @nodoc
abstract mixin class $DatabaseConfig_SqliteCopyWith<$Res> implements $DatabaseConfigCopyWith<$Res> {
  factory $DatabaseConfig_SqliteCopyWith(DatabaseConfig_Sqlite value, $Res Function(DatabaseConfig_Sqlite) _then) = _$DatabaseConfig_SqliteCopyWithImpl;
@useResult
$Res call({
 SqliteDbConfiguration config
});




}
/// @nodoc
class _$DatabaseConfig_SqliteCopyWithImpl<$Res>
    implements $DatabaseConfig_SqliteCopyWith<$Res> {
  _$DatabaseConfig_SqliteCopyWithImpl(this._self, this._then);

  final DatabaseConfig_Sqlite _self;
  final $Res Function(DatabaseConfig_Sqlite) _then;

/// Create a copy of DatabaseConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,}) {
  return _then(DatabaseConfig_Sqlite(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as SqliteDbConfiguration,
  ));
}


}

/// @nodoc


class DatabaseConfig_Sled extends DatabaseConfig {
  const DatabaseConfig_Sled({required this.config}): super._();
  

 final  SledDbConfiguration config;

/// Create a copy of DatabaseConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabaseConfig_SledCopyWith<DatabaseConfig_Sled> get copyWith => _$DatabaseConfig_SledCopyWithImpl<DatabaseConfig_Sled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseConfig_Sled&&(identical(other.config, config) || other.config == config));
}


@override
int get hashCode => Object.hash(runtimeType,config);

@override
String toString() {
  return 'DatabaseConfig.sled(config: $config)';
}


}

/// @nodoc
abstract mixin class $DatabaseConfig_SledCopyWith<$Res> implements $DatabaseConfigCopyWith<$Res> {
  factory $DatabaseConfig_SledCopyWith(DatabaseConfig_Sled value, $Res Function(DatabaseConfig_Sled) _then) = _$DatabaseConfig_SledCopyWithImpl;
@useResult
$Res call({
 SledDbConfiguration config
});




}
/// @nodoc
class _$DatabaseConfig_SledCopyWithImpl<$Res>
    implements $DatabaseConfig_SledCopyWith<$Res> {
  _$DatabaseConfig_SledCopyWithImpl(this._self, this._then);

  final DatabaseConfig_Sled _self;
  final $Res Function(DatabaseConfig_Sled) _then;

/// Create a copy of DatabaseConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? config = null,}) {
  return _then(DatabaseConfig_Sled(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as SledDbConfiguration,
  ));
}


}

/// @nodoc
mixin _$LockTime {

 int get field0;
/// Create a copy of LockTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockTimeCopyWith<LockTime> get copyWith => _$LockTimeCopyWithImpl<LockTime>(this as LockTime, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockTime&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'LockTime(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $LockTimeCopyWith<$Res>  {
  factory $LockTimeCopyWith(LockTime value, $Res Function(LockTime) _then) = _$LockTimeCopyWithImpl;
@useResult
$Res call({
 int field0
});




}
/// @nodoc
class _$LockTimeCopyWithImpl<$Res>
    implements $LockTimeCopyWith<$Res> {
  _$LockTimeCopyWithImpl(this._self, this._then);

  final LockTime _self;
  final $Res Function(LockTime) _then;

/// Create a copy of LockTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field0 = null,}) {
  return _then(_self.copyWith(
field0: null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class LockTime_Blocks extends LockTime {
  const LockTime_Blocks(this.field0): super._();
  

@override final  int field0;

/// Create a copy of LockTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockTime_BlocksCopyWith<LockTime_Blocks> get copyWith => _$LockTime_BlocksCopyWithImpl<LockTime_Blocks>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockTime_Blocks&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'LockTime.blocks(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $LockTime_BlocksCopyWith<$Res> implements $LockTimeCopyWith<$Res> {
  factory $LockTime_BlocksCopyWith(LockTime_Blocks value, $Res Function(LockTime_Blocks) _then) = _$LockTime_BlocksCopyWithImpl;
@override @useResult
$Res call({
 int field0
});




}
/// @nodoc
class _$LockTime_BlocksCopyWithImpl<$Res>
    implements $LockTime_BlocksCopyWith<$Res> {
  _$LockTime_BlocksCopyWithImpl(this._self, this._then);

  final LockTime_Blocks _self;
  final $Res Function(LockTime_Blocks) _then;

/// Create a copy of LockTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(LockTime_Blocks(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class LockTime_Seconds extends LockTime {
  const LockTime_Seconds(this.field0): super._();
  

@override final  int field0;

/// Create a copy of LockTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockTime_SecondsCopyWith<LockTime_Seconds> get copyWith => _$LockTime_SecondsCopyWithImpl<LockTime_Seconds>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockTime_Seconds&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'LockTime.seconds(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $LockTime_SecondsCopyWith<$Res> implements $LockTimeCopyWith<$Res> {
  factory $LockTime_SecondsCopyWith(LockTime_Seconds value, $Res Function(LockTime_Seconds) _then) = _$LockTime_SecondsCopyWithImpl;
@override @useResult
$Res call({
 int field0
});




}
/// @nodoc
class _$LockTime_SecondsCopyWithImpl<$Res>
    implements $LockTime_SecondsCopyWith<$Res> {
  _$LockTime_SecondsCopyWithImpl(this._self, this._then);

  final LockTime_Seconds _self;
  final $Res Function(LockTime_Seconds) _then;

/// Create a copy of LockTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(LockTime_Seconds(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Payload {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payload);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Payload()';
}


}

/// @nodoc
class $PayloadCopyWith<$Res>  {
$PayloadCopyWith(Payload _, $Res Function(Payload) __);
}


/// @nodoc


class Payload_PubkeyHash extends Payload {
  const Payload_PubkeyHash({required this.pubkeyHash}): super._();
  

 final  String pubkeyHash;

/// Create a copy of Payload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Payload_PubkeyHashCopyWith<Payload_PubkeyHash> get copyWith => _$Payload_PubkeyHashCopyWithImpl<Payload_PubkeyHash>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payload_PubkeyHash&&(identical(other.pubkeyHash, pubkeyHash) || other.pubkeyHash == pubkeyHash));
}


@override
int get hashCode => Object.hash(runtimeType,pubkeyHash);

@override
String toString() {
  return 'Payload.pubkeyHash(pubkeyHash: $pubkeyHash)';
}


}

/// @nodoc
abstract mixin class $Payload_PubkeyHashCopyWith<$Res> implements $PayloadCopyWith<$Res> {
  factory $Payload_PubkeyHashCopyWith(Payload_PubkeyHash value, $Res Function(Payload_PubkeyHash) _then) = _$Payload_PubkeyHashCopyWithImpl;
@useResult
$Res call({
 String pubkeyHash
});




}
/// @nodoc
class _$Payload_PubkeyHashCopyWithImpl<$Res>
    implements $Payload_PubkeyHashCopyWith<$Res> {
  _$Payload_PubkeyHashCopyWithImpl(this._self, this._then);

  final Payload_PubkeyHash _self;
  final $Res Function(Payload_PubkeyHash) _then;

/// Create a copy of Payload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pubkeyHash = null,}) {
  return _then(Payload_PubkeyHash(
pubkeyHash: null == pubkeyHash ? _self.pubkeyHash : pubkeyHash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Payload_ScriptHash extends Payload {
  const Payload_ScriptHash({required this.scriptHash}): super._();
  

 final  String scriptHash;

/// Create a copy of Payload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Payload_ScriptHashCopyWith<Payload_ScriptHash> get copyWith => _$Payload_ScriptHashCopyWithImpl<Payload_ScriptHash>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payload_ScriptHash&&(identical(other.scriptHash, scriptHash) || other.scriptHash == scriptHash));
}


@override
int get hashCode => Object.hash(runtimeType,scriptHash);

@override
String toString() {
  return 'Payload.scriptHash(scriptHash: $scriptHash)';
}


}

/// @nodoc
abstract mixin class $Payload_ScriptHashCopyWith<$Res> implements $PayloadCopyWith<$Res> {
  factory $Payload_ScriptHashCopyWith(Payload_ScriptHash value, $Res Function(Payload_ScriptHash) _then) = _$Payload_ScriptHashCopyWithImpl;
@useResult
$Res call({
 String scriptHash
});




}
/// @nodoc
class _$Payload_ScriptHashCopyWithImpl<$Res>
    implements $Payload_ScriptHashCopyWith<$Res> {
  _$Payload_ScriptHashCopyWithImpl(this._self, this._then);

  final Payload_ScriptHash _self;
  final $Res Function(Payload_ScriptHash) _then;

/// Create a copy of Payload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scriptHash = null,}) {
  return _then(Payload_ScriptHash(
scriptHash: null == scriptHash ? _self.scriptHash : scriptHash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Payload_WitnessProgram extends Payload {
  const Payload_WitnessProgram({required this.version, required this.program}): super._();
  

/// The witness program version.
 final  WitnessVersion version;
/// The witness program.
 final  Uint8List program;

/// Create a copy of Payload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Payload_WitnessProgramCopyWith<Payload_WitnessProgram> get copyWith => _$Payload_WitnessProgramCopyWithImpl<Payload_WitnessProgram>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payload_WitnessProgram&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.program, program));
}


@override
int get hashCode => Object.hash(runtimeType,version,const DeepCollectionEquality().hash(program));

@override
String toString() {
  return 'Payload.witnessProgram(version: $version, program: $program)';
}


}

/// @nodoc
abstract mixin class $Payload_WitnessProgramCopyWith<$Res> implements $PayloadCopyWith<$Res> {
  factory $Payload_WitnessProgramCopyWith(Payload_WitnessProgram value, $Res Function(Payload_WitnessProgram) _then) = _$Payload_WitnessProgramCopyWithImpl;
@useResult
$Res call({
 WitnessVersion version, Uint8List program
});




}
/// @nodoc
class _$Payload_WitnessProgramCopyWithImpl<$Res>
    implements $Payload_WitnessProgramCopyWith<$Res> {
  _$Payload_WitnessProgramCopyWithImpl(this._self, this._then);

  final Payload_WitnessProgram _self;
  final $Res Function(Payload_WitnessProgram) _then;

/// Create a copy of Payload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? version = null,Object? program = null,}) {
  return _then(Payload_WitnessProgram(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as WitnessVersion,program: null == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc
mixin _$PkOrF {

 String get value;
/// Create a copy of PkOrF
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PkOrFCopyWith<PkOrF> get copyWith => _$PkOrFCopyWithImpl<PkOrF>(this as PkOrF, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PkOrF&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PkOrF(value: $value)';
}


}

/// @nodoc
abstract mixin class $PkOrFCopyWith<$Res>  {
  factory $PkOrFCopyWith(PkOrF value, $Res Function(PkOrF) _then) = _$PkOrFCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PkOrFCopyWithImpl<$Res>
    implements $PkOrFCopyWith<$Res> {
  _$PkOrFCopyWithImpl(this._self, this._then);

  final PkOrF _self;
  final $Res Function(PkOrF) _then;

/// Create a copy of PkOrF
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class PkOrF_Pubkey extends PkOrF {
  const PkOrF_Pubkey({required this.value}): super._();
  

@override final  String value;

/// Create a copy of PkOrF
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PkOrF_PubkeyCopyWith<PkOrF_Pubkey> get copyWith => _$PkOrF_PubkeyCopyWithImpl<PkOrF_Pubkey>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PkOrF_Pubkey&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PkOrF.pubkey(value: $value)';
}


}

/// @nodoc
abstract mixin class $PkOrF_PubkeyCopyWith<$Res> implements $PkOrFCopyWith<$Res> {
  factory $PkOrF_PubkeyCopyWith(PkOrF_Pubkey value, $Res Function(PkOrF_Pubkey) _then) = _$PkOrF_PubkeyCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PkOrF_PubkeyCopyWithImpl<$Res>
    implements $PkOrF_PubkeyCopyWith<$Res> {
  _$PkOrF_PubkeyCopyWithImpl(this._self, this._then);

  final PkOrF_Pubkey _self;
  final $Res Function(PkOrF_Pubkey) _then;

/// Create a copy of PkOrF
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PkOrF_Pubkey(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PkOrF_XOnlyPubkey extends PkOrF {
  const PkOrF_XOnlyPubkey({required this.value}): super._();
  

@override final  String value;

/// Create a copy of PkOrF
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PkOrF_XOnlyPubkeyCopyWith<PkOrF_XOnlyPubkey> get copyWith => _$PkOrF_XOnlyPubkeyCopyWithImpl<PkOrF_XOnlyPubkey>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PkOrF_XOnlyPubkey&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PkOrF.xOnlyPubkey(value: $value)';
}


}

/// @nodoc
abstract mixin class $PkOrF_XOnlyPubkeyCopyWith<$Res> implements $PkOrFCopyWith<$Res> {
  factory $PkOrF_XOnlyPubkeyCopyWith(PkOrF_XOnlyPubkey value, $Res Function(PkOrF_XOnlyPubkey) _then) = _$PkOrF_XOnlyPubkeyCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PkOrF_XOnlyPubkeyCopyWithImpl<$Res>
    implements $PkOrF_XOnlyPubkeyCopyWith<$Res> {
  _$PkOrF_XOnlyPubkeyCopyWithImpl(this._self, this._then);

  final PkOrF_XOnlyPubkey _self;
  final $Res Function(PkOrF_XOnlyPubkey) _then;

/// Create a copy of PkOrF
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PkOrF_XOnlyPubkey(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PkOrF_Fingerprint extends PkOrF {
  const PkOrF_Fingerprint({required this.value}): super._();
  

@override final  String value;

/// Create a copy of PkOrF
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PkOrF_FingerprintCopyWith<PkOrF_Fingerprint> get copyWith => _$PkOrF_FingerprintCopyWithImpl<PkOrF_Fingerprint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PkOrF_Fingerprint&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PkOrF.fingerprint(value: $value)';
}


}

/// @nodoc
abstract mixin class $PkOrF_FingerprintCopyWith<$Res> implements $PkOrFCopyWith<$Res> {
  factory $PkOrF_FingerprintCopyWith(PkOrF_Fingerprint value, $Res Function(PkOrF_Fingerprint) _then) = _$PkOrF_FingerprintCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class _$PkOrF_FingerprintCopyWithImpl<$Res>
    implements $PkOrF_FingerprintCopyWith<$Res> {
  _$PkOrF_FingerprintCopyWithImpl(this._self, this._then);

  final PkOrF_Fingerprint _self;
  final $Res Function(PkOrF_Fingerprint) _then;

/// Create a copy of PkOrF
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PkOrF_Fingerprint(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RbfValue {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RbfValue);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RbfValue()';
}


}

/// @nodoc
class $RbfValueCopyWith<$Res>  {
$RbfValueCopyWith(RbfValue _, $Res Function(RbfValue) __);
}


/// @nodoc


class RbfValue_RbfDefault extends RbfValue {
  const RbfValue_RbfDefault(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RbfValue_RbfDefault);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RbfValue.rbfDefault()';
}


}




/// @nodoc


class RbfValue_Value extends RbfValue {
  const RbfValue_Value(this.field0): super._();
  

 final  int field0;

/// Create a copy of RbfValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RbfValue_ValueCopyWith<RbfValue_Value> get copyWith => _$RbfValue_ValueCopyWithImpl<RbfValue_Value>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RbfValue_Value&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RbfValue.value(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RbfValue_ValueCopyWith<$Res> implements $RbfValueCopyWith<$Res> {
  factory $RbfValue_ValueCopyWith(RbfValue_Value value, $Res Function(RbfValue_Value) _then) = _$RbfValue_ValueCopyWithImpl;
@useResult
$Res call({
 int field0
});




}
/// @nodoc
class _$RbfValue_ValueCopyWithImpl<$Res>
    implements $RbfValue_ValueCopyWith<$Res> {
  _$RbfValue_ValueCopyWithImpl(this._self, this._then);

  final RbfValue_Value _self;
  final $Res Function(RbfValue_Value) _then;

/// Create a copy of RbfValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RbfValue_Value(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Satisfaction {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Satisfaction);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Satisfaction()';
}


}

/// @nodoc
class $SatisfactionCopyWith<$Res>  {
$SatisfactionCopyWith(Satisfaction _, $Res Function(Satisfaction) __);
}


/// @nodoc


class Satisfaction_Partial extends Satisfaction {
  const Satisfaction_Partial({required this.n, required this.m, required this.items, this.sorted, required final  Map<int, List<Condition>> conditions}): _conditions = conditions,super._();
  

 final  BigInt n;
 final  BigInt m;
 final  Uint64List items;
 final  bool? sorted;
 final  Map<int, List<Condition>> _conditions;
 Map<int, List<Condition>> get conditions {
  if (_conditions is EqualUnmodifiableMapView) return _conditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_conditions);
}


/// Create a copy of Satisfaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Satisfaction_PartialCopyWith<Satisfaction_Partial> get copyWith => _$Satisfaction_PartialCopyWithImpl<Satisfaction_Partial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Satisfaction_Partial&&(identical(other.n, n) || other.n == n)&&(identical(other.m, m) || other.m == m)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.sorted, sorted) || other.sorted == sorted)&&const DeepCollectionEquality().equals(other._conditions, _conditions));
}


@override
int get hashCode => Object.hash(runtimeType,n,m,const DeepCollectionEquality().hash(items),sorted,const DeepCollectionEquality().hash(_conditions));

@override
String toString() {
  return 'Satisfaction.partial(n: $n, m: $m, items: $items, sorted: $sorted, conditions: $conditions)';
}


}

/// @nodoc
abstract mixin class $Satisfaction_PartialCopyWith<$Res> implements $SatisfactionCopyWith<$Res> {
  factory $Satisfaction_PartialCopyWith(Satisfaction_Partial value, $Res Function(Satisfaction_Partial) _then) = _$Satisfaction_PartialCopyWithImpl;
@useResult
$Res call({
 BigInt n, BigInt m, Uint64List items, bool? sorted, Map<int, List<Condition>> conditions
});




}
/// @nodoc
class _$Satisfaction_PartialCopyWithImpl<$Res>
    implements $Satisfaction_PartialCopyWith<$Res> {
  _$Satisfaction_PartialCopyWithImpl(this._self, this._then);

  final Satisfaction_Partial _self;
  final $Res Function(Satisfaction_Partial) _then;

/// Create a copy of Satisfaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? n = null,Object? m = null,Object? items = null,Object? sorted = freezed,Object? conditions = null,}) {
  return _then(Satisfaction_Partial(
n: null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as BigInt,m: null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as BigInt,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as Uint64List,sorted: freezed == sorted ? _self.sorted : sorted // ignore: cast_nullable_to_non_nullable
as bool?,conditions: null == conditions ? _self._conditions : conditions // ignore: cast_nullable_to_non_nullable
as Map<int, List<Condition>>,
  ));
}


}

/// @nodoc


class Satisfaction_PartialComplete extends Satisfaction {
  const Satisfaction_PartialComplete({required this.n, required this.m, required this.items, this.sorted, required final  Map<Uint32List, List<Condition>> conditions}): _conditions = conditions,super._();
  

 final  BigInt n;
 final  BigInt m;
 final  Uint64List items;
 final  bool? sorted;
 final  Map<Uint32List, List<Condition>> _conditions;
 Map<Uint32List, List<Condition>> get conditions {
  if (_conditions is EqualUnmodifiableMapView) return _conditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_conditions);
}


/// Create a copy of Satisfaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Satisfaction_PartialCompleteCopyWith<Satisfaction_PartialComplete> get copyWith => _$Satisfaction_PartialCompleteCopyWithImpl<Satisfaction_PartialComplete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Satisfaction_PartialComplete&&(identical(other.n, n) || other.n == n)&&(identical(other.m, m) || other.m == m)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.sorted, sorted) || other.sorted == sorted)&&const DeepCollectionEquality().equals(other._conditions, _conditions));
}


@override
int get hashCode => Object.hash(runtimeType,n,m,const DeepCollectionEquality().hash(items),sorted,const DeepCollectionEquality().hash(_conditions));

@override
String toString() {
  return 'Satisfaction.partialComplete(n: $n, m: $m, items: $items, sorted: $sorted, conditions: $conditions)';
}


}

/// @nodoc
abstract mixin class $Satisfaction_PartialCompleteCopyWith<$Res> implements $SatisfactionCopyWith<$Res> {
  factory $Satisfaction_PartialCompleteCopyWith(Satisfaction_PartialComplete value, $Res Function(Satisfaction_PartialComplete) _then) = _$Satisfaction_PartialCompleteCopyWithImpl;
@useResult
$Res call({
 BigInt n, BigInt m, Uint64List items, bool? sorted, Map<Uint32List, List<Condition>> conditions
});




}
/// @nodoc
class _$Satisfaction_PartialCompleteCopyWithImpl<$Res>
    implements $Satisfaction_PartialCompleteCopyWith<$Res> {
  _$Satisfaction_PartialCompleteCopyWithImpl(this._self, this._then);

  final Satisfaction_PartialComplete _self;
  final $Res Function(Satisfaction_PartialComplete) _then;

/// Create a copy of Satisfaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? n = null,Object? m = null,Object? items = null,Object? sorted = freezed,Object? conditions = null,}) {
  return _then(Satisfaction_PartialComplete(
n: null == n ? _self.n : n // ignore: cast_nullable_to_non_nullable
as BigInt,m: null == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as BigInt,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as Uint64List,sorted: freezed == sorted ? _self.sorted : sorted // ignore: cast_nullable_to_non_nullable
as bool?,conditions: null == conditions ? _self._conditions : conditions // ignore: cast_nullable_to_non_nullable
as Map<Uint32List, List<Condition>>,
  ));
}


}

/// @nodoc


class Satisfaction_Complete extends Satisfaction {
  const Satisfaction_Complete({required this.condition}): super._();
  

 final  Condition condition;

/// Create a copy of Satisfaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Satisfaction_CompleteCopyWith<Satisfaction_Complete> get copyWith => _$Satisfaction_CompleteCopyWithImpl<Satisfaction_Complete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Satisfaction_Complete&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,condition);

@override
String toString() {
  return 'Satisfaction.complete(condition: $condition)';
}


}

/// @nodoc
abstract mixin class $Satisfaction_CompleteCopyWith<$Res> implements $SatisfactionCopyWith<$Res> {
  factory $Satisfaction_CompleteCopyWith(Satisfaction_Complete value, $Res Function(Satisfaction_Complete) _then) = _$Satisfaction_CompleteCopyWithImpl;
@useResult
$Res call({
 Condition condition
});




}
/// @nodoc
class _$Satisfaction_CompleteCopyWithImpl<$Res>
    implements $Satisfaction_CompleteCopyWith<$Res> {
  _$Satisfaction_CompleteCopyWithImpl(this._self, this._then);

  final Satisfaction_Complete _self;
  final $Res Function(Satisfaction_Complete) _then;

/// Create a copy of Satisfaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? condition = null,}) {
  return _then(Satisfaction_Complete(
condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as Condition,
  ));
}


}

/// @nodoc


class Satisfaction_None extends Satisfaction {
  const Satisfaction_None({required this.msg}): super._();
  

 final  String msg;

/// Create a copy of Satisfaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Satisfaction_NoneCopyWith<Satisfaction_None> get copyWith => _$Satisfaction_NoneCopyWithImpl<Satisfaction_None>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Satisfaction_None&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'Satisfaction.none(msg: $msg)';
}


}

/// @nodoc
abstract mixin class $Satisfaction_NoneCopyWith<$Res> implements $SatisfactionCopyWith<$Res> {
  factory $Satisfaction_NoneCopyWith(Satisfaction_None value, $Res Function(Satisfaction_None) _then) = _$Satisfaction_NoneCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class _$Satisfaction_NoneCopyWithImpl<$Res>
    implements $Satisfaction_NoneCopyWith<$Res> {
  _$Satisfaction_NoneCopyWithImpl(this._self, this._then);

  final Satisfaction_None _self;
  final $Res Function(Satisfaction_None) _then;

/// Create a copy of Satisfaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(Satisfaction_None(
msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SatisfiableItem {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SatisfiableItem()';
}


}

/// @nodoc
class $SatisfiableItemCopyWith<$Res>  {
$SatisfiableItemCopyWith(SatisfiableItem _, $Res Function(SatisfiableItem) __);
}


/// @nodoc


class SatisfiableItem_EcdsaSignature extends SatisfiableItem {
  const SatisfiableItem_EcdsaSignature({required this.key}): super._();
  

 final  PkOrF key;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_EcdsaSignatureCopyWith<SatisfiableItem_EcdsaSignature> get copyWith => _$SatisfiableItem_EcdsaSignatureCopyWithImpl<SatisfiableItem_EcdsaSignature>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_EcdsaSignature&&(identical(other.key, key) || other.key == key));
}


@override
int get hashCode => Object.hash(runtimeType,key);

@override
String toString() {
  return 'SatisfiableItem.ecdsaSignature(key: $key)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_EcdsaSignatureCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_EcdsaSignatureCopyWith(SatisfiableItem_EcdsaSignature value, $Res Function(SatisfiableItem_EcdsaSignature) _then) = _$SatisfiableItem_EcdsaSignatureCopyWithImpl;
@useResult
$Res call({
 PkOrF key
});


$PkOrFCopyWith<$Res> get key;

}
/// @nodoc
class _$SatisfiableItem_EcdsaSignatureCopyWithImpl<$Res>
    implements $SatisfiableItem_EcdsaSignatureCopyWith<$Res> {
  _$SatisfiableItem_EcdsaSignatureCopyWithImpl(this._self, this._then);

  final SatisfiableItem_EcdsaSignature _self;
  final $Res Function(SatisfiableItem_EcdsaSignature) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? key = null,}) {
  return _then(SatisfiableItem_EcdsaSignature(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as PkOrF,
  ));
}

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PkOrFCopyWith<$Res> get key {
  
  return $PkOrFCopyWith<$Res>(_self.key, (value) {
    return _then(_self.copyWith(key: value));
  });
}
}

/// @nodoc


class SatisfiableItem_SchnorrSignature extends SatisfiableItem {
  const SatisfiableItem_SchnorrSignature({required this.key}): super._();
  

 final  PkOrF key;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_SchnorrSignatureCopyWith<SatisfiableItem_SchnorrSignature> get copyWith => _$SatisfiableItem_SchnorrSignatureCopyWithImpl<SatisfiableItem_SchnorrSignature>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_SchnorrSignature&&(identical(other.key, key) || other.key == key));
}


@override
int get hashCode => Object.hash(runtimeType,key);

@override
String toString() {
  return 'SatisfiableItem.schnorrSignature(key: $key)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_SchnorrSignatureCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_SchnorrSignatureCopyWith(SatisfiableItem_SchnorrSignature value, $Res Function(SatisfiableItem_SchnorrSignature) _then) = _$SatisfiableItem_SchnorrSignatureCopyWithImpl;
@useResult
$Res call({
 PkOrF key
});


$PkOrFCopyWith<$Res> get key;

}
/// @nodoc
class _$SatisfiableItem_SchnorrSignatureCopyWithImpl<$Res>
    implements $SatisfiableItem_SchnorrSignatureCopyWith<$Res> {
  _$SatisfiableItem_SchnorrSignatureCopyWithImpl(this._self, this._then);

  final SatisfiableItem_SchnorrSignature _self;
  final $Res Function(SatisfiableItem_SchnorrSignature) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? key = null,}) {
  return _then(SatisfiableItem_SchnorrSignature(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as PkOrF,
  ));
}

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PkOrFCopyWith<$Res> get key {
  
  return $PkOrFCopyWith<$Res>(_self.key, (value) {
    return _then(_self.copyWith(key: value));
  });
}
}

/// @nodoc


class SatisfiableItem_Sha256Preimage extends SatisfiableItem {
  const SatisfiableItem_Sha256Preimage({required this.hash}): super._();
  

 final  String hash;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_Sha256PreimageCopyWith<SatisfiableItem_Sha256Preimage> get copyWith => _$SatisfiableItem_Sha256PreimageCopyWithImpl<SatisfiableItem_Sha256Preimage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_Sha256Preimage&&(identical(other.hash, hash) || other.hash == hash));
}


@override
int get hashCode => Object.hash(runtimeType,hash);

@override
String toString() {
  return 'SatisfiableItem.sha256Preimage(hash: $hash)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_Sha256PreimageCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_Sha256PreimageCopyWith(SatisfiableItem_Sha256Preimage value, $Res Function(SatisfiableItem_Sha256Preimage) _then) = _$SatisfiableItem_Sha256PreimageCopyWithImpl;
@useResult
$Res call({
 String hash
});




}
/// @nodoc
class _$SatisfiableItem_Sha256PreimageCopyWithImpl<$Res>
    implements $SatisfiableItem_Sha256PreimageCopyWith<$Res> {
  _$SatisfiableItem_Sha256PreimageCopyWithImpl(this._self, this._then);

  final SatisfiableItem_Sha256Preimage _self;
  final $Res Function(SatisfiableItem_Sha256Preimage) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hash = null,}) {
  return _then(SatisfiableItem_Sha256Preimage(
hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SatisfiableItem_Hash256Preimage extends SatisfiableItem {
  const SatisfiableItem_Hash256Preimage({required this.hash}): super._();
  

 final  String hash;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_Hash256PreimageCopyWith<SatisfiableItem_Hash256Preimage> get copyWith => _$SatisfiableItem_Hash256PreimageCopyWithImpl<SatisfiableItem_Hash256Preimage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_Hash256Preimage&&(identical(other.hash, hash) || other.hash == hash));
}


@override
int get hashCode => Object.hash(runtimeType,hash);

@override
String toString() {
  return 'SatisfiableItem.hash256Preimage(hash: $hash)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_Hash256PreimageCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_Hash256PreimageCopyWith(SatisfiableItem_Hash256Preimage value, $Res Function(SatisfiableItem_Hash256Preimage) _then) = _$SatisfiableItem_Hash256PreimageCopyWithImpl;
@useResult
$Res call({
 String hash
});




}
/// @nodoc
class _$SatisfiableItem_Hash256PreimageCopyWithImpl<$Res>
    implements $SatisfiableItem_Hash256PreimageCopyWith<$Res> {
  _$SatisfiableItem_Hash256PreimageCopyWithImpl(this._self, this._then);

  final SatisfiableItem_Hash256Preimage _self;
  final $Res Function(SatisfiableItem_Hash256Preimage) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hash = null,}) {
  return _then(SatisfiableItem_Hash256Preimage(
hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SatisfiableItem_Ripemd160Preimage extends SatisfiableItem {
  const SatisfiableItem_Ripemd160Preimage({required this.hash}): super._();
  

 final  String hash;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_Ripemd160PreimageCopyWith<SatisfiableItem_Ripemd160Preimage> get copyWith => _$SatisfiableItem_Ripemd160PreimageCopyWithImpl<SatisfiableItem_Ripemd160Preimage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_Ripemd160Preimage&&(identical(other.hash, hash) || other.hash == hash));
}


@override
int get hashCode => Object.hash(runtimeType,hash);

@override
String toString() {
  return 'SatisfiableItem.ripemd160Preimage(hash: $hash)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_Ripemd160PreimageCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_Ripemd160PreimageCopyWith(SatisfiableItem_Ripemd160Preimage value, $Res Function(SatisfiableItem_Ripemd160Preimage) _then) = _$SatisfiableItem_Ripemd160PreimageCopyWithImpl;
@useResult
$Res call({
 String hash
});




}
/// @nodoc
class _$SatisfiableItem_Ripemd160PreimageCopyWithImpl<$Res>
    implements $SatisfiableItem_Ripemd160PreimageCopyWith<$Res> {
  _$SatisfiableItem_Ripemd160PreimageCopyWithImpl(this._self, this._then);

  final SatisfiableItem_Ripemd160Preimage _self;
  final $Res Function(SatisfiableItem_Ripemd160Preimage) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hash = null,}) {
  return _then(SatisfiableItem_Ripemd160Preimage(
hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SatisfiableItem_Hash160Preimage extends SatisfiableItem {
  const SatisfiableItem_Hash160Preimage({required this.hash}): super._();
  

 final  String hash;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_Hash160PreimageCopyWith<SatisfiableItem_Hash160Preimage> get copyWith => _$SatisfiableItem_Hash160PreimageCopyWithImpl<SatisfiableItem_Hash160Preimage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_Hash160Preimage&&(identical(other.hash, hash) || other.hash == hash));
}


@override
int get hashCode => Object.hash(runtimeType,hash);

@override
String toString() {
  return 'SatisfiableItem.hash160Preimage(hash: $hash)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_Hash160PreimageCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_Hash160PreimageCopyWith(SatisfiableItem_Hash160Preimage value, $Res Function(SatisfiableItem_Hash160Preimage) _then) = _$SatisfiableItem_Hash160PreimageCopyWithImpl;
@useResult
$Res call({
 String hash
});




}
/// @nodoc
class _$SatisfiableItem_Hash160PreimageCopyWithImpl<$Res>
    implements $SatisfiableItem_Hash160PreimageCopyWith<$Res> {
  _$SatisfiableItem_Hash160PreimageCopyWithImpl(this._self, this._then);

  final SatisfiableItem_Hash160Preimage _self;
  final $Res Function(SatisfiableItem_Hash160Preimage) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? hash = null,}) {
  return _then(SatisfiableItem_Hash160Preimage(
hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SatisfiableItem_AbsoluteTimelock extends SatisfiableItem {
  const SatisfiableItem_AbsoluteTimelock({required this.value}): super._();
  

 final  LockTime value;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_AbsoluteTimelockCopyWith<SatisfiableItem_AbsoluteTimelock> get copyWith => _$SatisfiableItem_AbsoluteTimelockCopyWithImpl<SatisfiableItem_AbsoluteTimelock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_AbsoluteTimelock&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SatisfiableItem.absoluteTimelock(value: $value)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_AbsoluteTimelockCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_AbsoluteTimelockCopyWith(SatisfiableItem_AbsoluteTimelock value, $Res Function(SatisfiableItem_AbsoluteTimelock) _then) = _$SatisfiableItem_AbsoluteTimelockCopyWithImpl;
@useResult
$Res call({
 LockTime value
});


$LockTimeCopyWith<$Res> get value;

}
/// @nodoc
class _$SatisfiableItem_AbsoluteTimelockCopyWithImpl<$Res>
    implements $SatisfiableItem_AbsoluteTimelockCopyWith<$Res> {
  _$SatisfiableItem_AbsoluteTimelockCopyWithImpl(this._self, this._then);

  final SatisfiableItem_AbsoluteTimelock _self;
  final $Res Function(SatisfiableItem_AbsoluteTimelock) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SatisfiableItem_AbsoluteTimelock(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as LockTime,
  ));
}

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LockTimeCopyWith<$Res> get value {
  
  return $LockTimeCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

/// @nodoc


class SatisfiableItem_RelativeTimelock extends SatisfiableItem {
  const SatisfiableItem_RelativeTimelock({required this.value}): super._();
  

 final  int value;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_RelativeTimelockCopyWith<SatisfiableItem_RelativeTimelock> get copyWith => _$SatisfiableItem_RelativeTimelockCopyWithImpl<SatisfiableItem_RelativeTimelock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_RelativeTimelock&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SatisfiableItem.relativeTimelock(value: $value)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_RelativeTimelockCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_RelativeTimelockCopyWith(SatisfiableItem_RelativeTimelock value, $Res Function(SatisfiableItem_RelativeTimelock) _then) = _$SatisfiableItem_RelativeTimelockCopyWithImpl;
@useResult
$Res call({
 int value
});




}
/// @nodoc
class _$SatisfiableItem_RelativeTimelockCopyWithImpl<$Res>
    implements $SatisfiableItem_RelativeTimelockCopyWith<$Res> {
  _$SatisfiableItem_RelativeTimelockCopyWithImpl(this._self, this._then);

  final SatisfiableItem_RelativeTimelock _self;
  final $Res Function(SatisfiableItem_RelativeTimelock) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(SatisfiableItem_RelativeTimelock(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SatisfiableItem_Multisig extends SatisfiableItem {
  const SatisfiableItem_Multisig({required final  List<PkOrF> keys, required this.threshold}): _keys = keys,super._();
  

 final  List<PkOrF> _keys;
 List<PkOrF> get keys {
  if (_keys is EqualUnmodifiableListView) return _keys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keys);
}

 final  BigInt threshold;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_MultisigCopyWith<SatisfiableItem_Multisig> get copyWith => _$SatisfiableItem_MultisigCopyWithImpl<SatisfiableItem_Multisig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_Multisig&&const DeepCollectionEquality().equals(other._keys, _keys)&&(identical(other.threshold, threshold) || other.threshold == threshold));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_keys),threshold);

@override
String toString() {
  return 'SatisfiableItem.multisig(keys: $keys, threshold: $threshold)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_MultisigCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_MultisigCopyWith(SatisfiableItem_Multisig value, $Res Function(SatisfiableItem_Multisig) _then) = _$SatisfiableItem_MultisigCopyWithImpl;
@useResult
$Res call({
 List<PkOrF> keys, BigInt threshold
});




}
/// @nodoc
class _$SatisfiableItem_MultisigCopyWithImpl<$Res>
    implements $SatisfiableItem_MultisigCopyWith<$Res> {
  _$SatisfiableItem_MultisigCopyWithImpl(this._self, this._then);

  final SatisfiableItem_Multisig _self;
  final $Res Function(SatisfiableItem_Multisig) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? keys = null,Object? threshold = null,}) {
  return _then(SatisfiableItem_Multisig(
keys: null == keys ? _self._keys : keys // ignore: cast_nullable_to_non_nullable
as List<PkOrF>,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}


}

/// @nodoc


class SatisfiableItem_Thresh extends SatisfiableItem {
  const SatisfiableItem_Thresh({required final  List<BdkPolicy> items, required this.threshold}): _items = items,super._();
  

 final  List<BdkPolicy> _items;
 List<BdkPolicy> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  BigInt threshold;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SatisfiableItem_ThreshCopyWith<SatisfiableItem_Thresh> get copyWith => _$SatisfiableItem_ThreshCopyWithImpl<SatisfiableItem_Thresh>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SatisfiableItem_Thresh&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.threshold, threshold) || other.threshold == threshold));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),threshold);

@override
String toString() {
  return 'SatisfiableItem.thresh(items: $items, threshold: $threshold)';
}


}

/// @nodoc
abstract mixin class $SatisfiableItem_ThreshCopyWith<$Res> implements $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItem_ThreshCopyWith(SatisfiableItem_Thresh value, $Res Function(SatisfiableItem_Thresh) _then) = _$SatisfiableItem_ThreshCopyWithImpl;
@useResult
$Res call({
 List<BdkPolicy> items, BigInt threshold
});




}
/// @nodoc
class _$SatisfiableItem_ThreshCopyWithImpl<$Res>
    implements $SatisfiableItem_ThreshCopyWith<$Res> {
  _$SatisfiableItem_ThreshCopyWithImpl(this._self, this._then);

  final SatisfiableItem_Thresh _self;
  final $Res Function(SatisfiableItem_Thresh) _then;

/// Create a copy of SatisfiableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? threshold = null,}) {
  return _then(SatisfiableItem_Thresh(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<BdkPolicy>,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}


}

// dart format on
