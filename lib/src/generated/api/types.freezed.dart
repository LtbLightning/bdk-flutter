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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChainPosition {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfirmationBlockTime confirmationBlockTime)
        confirmed,
    required TResult Function(BigInt timestamp) unconfirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfirmationBlockTime confirmationBlockTime)? confirmed,
    TResult? Function(BigInt timestamp)? unconfirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfirmationBlockTime confirmationBlockTime)? confirmed,
    TResult Function(BigInt timestamp)? unconfirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChainPosition_Confirmed value) confirmed,
    required TResult Function(ChainPosition_Unconfirmed value) unconfirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChainPosition_Confirmed value)? confirmed,
    TResult? Function(ChainPosition_Unconfirmed value)? unconfirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChainPosition_Confirmed value)? confirmed,
    TResult Function(ChainPosition_Unconfirmed value)? unconfirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChainPositionCopyWith<$Res> {
  factory $ChainPositionCopyWith(
          ChainPosition value, $Res Function(ChainPosition) then) =
      _$ChainPositionCopyWithImpl<$Res, ChainPosition>;
}

/// @nodoc
class _$ChainPositionCopyWithImpl<$Res, $Val extends ChainPosition>
    implements $ChainPositionCopyWith<$Res> {
  _$ChainPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChainPosition_ConfirmedImplCopyWith<$Res> {
  factory _$$ChainPosition_ConfirmedImplCopyWith(
          _$ChainPosition_ConfirmedImpl value,
          $Res Function(_$ChainPosition_ConfirmedImpl) then) =
      __$$ChainPosition_ConfirmedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ConfirmationBlockTime confirmationBlockTime});
}

/// @nodoc
class __$$ChainPosition_ConfirmedImplCopyWithImpl<$Res>
    extends _$ChainPositionCopyWithImpl<$Res, _$ChainPosition_ConfirmedImpl>
    implements _$$ChainPosition_ConfirmedImplCopyWith<$Res> {
  __$$ChainPosition_ConfirmedImplCopyWithImpl(
      _$ChainPosition_ConfirmedImpl _value,
      $Res Function(_$ChainPosition_ConfirmedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confirmationBlockTime = null,
  }) {
    return _then(_$ChainPosition_ConfirmedImpl(
      confirmationBlockTime: null == confirmationBlockTime
          ? _value.confirmationBlockTime
          : confirmationBlockTime // ignore: cast_nullable_to_non_nullable
              as ConfirmationBlockTime,
    ));
  }
}

/// @nodoc

class _$ChainPosition_ConfirmedImpl extends ChainPosition_Confirmed {
  const _$ChainPosition_ConfirmedImpl({required this.confirmationBlockTime})
      : super._();

  @override
  final ConfirmationBlockTime confirmationBlockTime;

  @override
  String toString() {
    return 'ChainPosition.confirmed(confirmationBlockTime: $confirmationBlockTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChainPosition_ConfirmedImpl &&
            (identical(other.confirmationBlockTime, confirmationBlockTime) ||
                other.confirmationBlockTime == confirmationBlockTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confirmationBlockTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChainPosition_ConfirmedImplCopyWith<_$ChainPosition_ConfirmedImpl>
      get copyWith => __$$ChainPosition_ConfirmedImplCopyWithImpl<
          _$ChainPosition_ConfirmedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfirmationBlockTime confirmationBlockTime)
        confirmed,
    required TResult Function(BigInt timestamp) unconfirmed,
  }) {
    return confirmed(confirmationBlockTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfirmationBlockTime confirmationBlockTime)? confirmed,
    TResult? Function(BigInt timestamp)? unconfirmed,
  }) {
    return confirmed?.call(confirmationBlockTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfirmationBlockTime confirmationBlockTime)? confirmed,
    TResult Function(BigInt timestamp)? unconfirmed,
    required TResult orElse(),
  }) {
    if (confirmed != null) {
      return confirmed(confirmationBlockTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChainPosition_Confirmed value) confirmed,
    required TResult Function(ChainPosition_Unconfirmed value) unconfirmed,
  }) {
    return confirmed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChainPosition_Confirmed value)? confirmed,
    TResult? Function(ChainPosition_Unconfirmed value)? unconfirmed,
  }) {
    return confirmed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChainPosition_Confirmed value)? confirmed,
    TResult Function(ChainPosition_Unconfirmed value)? unconfirmed,
    required TResult orElse(),
  }) {
    if (confirmed != null) {
      return confirmed(this);
    }
    return orElse();
  }
}

abstract class ChainPosition_Confirmed extends ChainPosition {
  const factory ChainPosition_Confirmed(
          {required final ConfirmationBlockTime confirmationBlockTime}) =
      _$ChainPosition_ConfirmedImpl;
  const ChainPosition_Confirmed._() : super._();

  ConfirmationBlockTime get confirmationBlockTime;
  @JsonKey(ignore: true)
  _$$ChainPosition_ConfirmedImplCopyWith<_$ChainPosition_ConfirmedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChainPosition_UnconfirmedImplCopyWith<$Res> {
  factory _$$ChainPosition_UnconfirmedImplCopyWith(
          _$ChainPosition_UnconfirmedImpl value,
          $Res Function(_$ChainPosition_UnconfirmedImpl) then) =
      __$$ChainPosition_UnconfirmedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BigInt timestamp});
}

/// @nodoc
class __$$ChainPosition_UnconfirmedImplCopyWithImpl<$Res>
    extends _$ChainPositionCopyWithImpl<$Res, _$ChainPosition_UnconfirmedImpl>
    implements _$$ChainPosition_UnconfirmedImplCopyWith<$Res> {
  __$$ChainPosition_UnconfirmedImplCopyWithImpl(
      _$ChainPosition_UnconfirmedImpl _value,
      $Res Function(_$ChainPosition_UnconfirmedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
  }) {
    return _then(_$ChainPosition_UnconfirmedImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc

class _$ChainPosition_UnconfirmedImpl extends ChainPosition_Unconfirmed {
  const _$ChainPosition_UnconfirmedImpl({required this.timestamp}) : super._();

  @override
  final BigInt timestamp;

  @override
  String toString() {
    return 'ChainPosition.unconfirmed(timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChainPosition_UnconfirmedImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChainPosition_UnconfirmedImplCopyWith<_$ChainPosition_UnconfirmedImpl>
      get copyWith => __$$ChainPosition_UnconfirmedImplCopyWithImpl<
          _$ChainPosition_UnconfirmedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ConfirmationBlockTime confirmationBlockTime)
        confirmed,
    required TResult Function(BigInt timestamp) unconfirmed,
  }) {
    return unconfirmed(timestamp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ConfirmationBlockTime confirmationBlockTime)? confirmed,
    TResult? Function(BigInt timestamp)? unconfirmed,
  }) {
    return unconfirmed?.call(timestamp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ConfirmationBlockTime confirmationBlockTime)? confirmed,
    TResult Function(BigInt timestamp)? unconfirmed,
    required TResult orElse(),
  }) {
    if (unconfirmed != null) {
      return unconfirmed(timestamp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChainPosition_Confirmed value) confirmed,
    required TResult Function(ChainPosition_Unconfirmed value) unconfirmed,
  }) {
    return unconfirmed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChainPosition_Confirmed value)? confirmed,
    TResult? Function(ChainPosition_Unconfirmed value)? unconfirmed,
  }) {
    return unconfirmed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChainPosition_Confirmed value)? confirmed,
    TResult Function(ChainPosition_Unconfirmed value)? unconfirmed,
    required TResult orElse(),
  }) {
    if (unconfirmed != null) {
      return unconfirmed(this);
    }
    return orElse();
  }
}

abstract class ChainPosition_Unconfirmed extends ChainPosition {
  const factory ChainPosition_Unconfirmed({required final BigInt timestamp}) =
      _$ChainPosition_UnconfirmedImpl;
  const ChainPosition_Unconfirmed._() : super._();

  BigInt get timestamp;
  @JsonKey(ignore: true)
  _$$ChainPosition_UnconfirmedImplCopyWith<_$ChainPosition_UnconfirmedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LockTime {
  int get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) blocks,
    required TResult Function(int field0) seconds,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? blocks,
    TResult? Function(int field0)? seconds,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? blocks,
    TResult Function(int field0)? seconds,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LockTime_Blocks value) blocks,
    required TResult Function(LockTime_Seconds value) seconds,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LockTime_Blocks value)? blocks,
    TResult? Function(LockTime_Seconds value)? seconds,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LockTime_Blocks value)? blocks,
    TResult Function(LockTime_Seconds value)? seconds,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LockTimeCopyWith<LockTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LockTimeCopyWith<$Res> {
  factory $LockTimeCopyWith(LockTime value, $Res Function(LockTime) then) =
      _$LockTimeCopyWithImpl<$Res, LockTime>;
  @useResult
  $Res call({int field0});
}

/// @nodoc
class _$LockTimeCopyWithImpl<$Res, $Val extends LockTime>
    implements $LockTimeCopyWith<$Res> {
  _$LockTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_value.copyWith(
      field0: null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LockTime_BlocksImplCopyWith<$Res>
    implements $LockTimeCopyWith<$Res> {
  factory _$$LockTime_BlocksImplCopyWith(_$LockTime_BlocksImpl value,
          $Res Function(_$LockTime_BlocksImpl) then) =
      __$$LockTime_BlocksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int field0});
}

/// @nodoc
class __$$LockTime_BlocksImplCopyWithImpl<$Res>
    extends _$LockTimeCopyWithImpl<$Res, _$LockTime_BlocksImpl>
    implements _$$LockTime_BlocksImplCopyWith<$Res> {
  __$$LockTime_BlocksImplCopyWithImpl(
      _$LockTime_BlocksImpl _value, $Res Function(_$LockTime_BlocksImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$LockTime_BlocksImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LockTime_BlocksImpl extends LockTime_Blocks {
  const _$LockTime_BlocksImpl(this.field0) : super._();

  @override
  final int field0;

  @override
  String toString() {
    return 'LockTime.blocks(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LockTime_BlocksImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LockTime_BlocksImplCopyWith<_$LockTime_BlocksImpl> get copyWith =>
      __$$LockTime_BlocksImplCopyWithImpl<_$LockTime_BlocksImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) blocks,
    required TResult Function(int field0) seconds,
  }) {
    return blocks(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? blocks,
    TResult? Function(int field0)? seconds,
  }) {
    return blocks?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? blocks,
    TResult Function(int field0)? seconds,
    required TResult orElse(),
  }) {
    if (blocks != null) {
      return blocks(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LockTime_Blocks value) blocks,
    required TResult Function(LockTime_Seconds value) seconds,
  }) {
    return blocks(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LockTime_Blocks value)? blocks,
    TResult? Function(LockTime_Seconds value)? seconds,
  }) {
    return blocks?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LockTime_Blocks value)? blocks,
    TResult Function(LockTime_Seconds value)? seconds,
    required TResult orElse(),
  }) {
    if (blocks != null) {
      return blocks(this);
    }
    return orElse();
  }
}

abstract class LockTime_Blocks extends LockTime {
  const factory LockTime_Blocks(final int field0) = _$LockTime_BlocksImpl;
  const LockTime_Blocks._() : super._();

  @override
  int get field0;
  @override
  @JsonKey(ignore: true)
  _$$LockTime_BlocksImplCopyWith<_$LockTime_BlocksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LockTime_SecondsImplCopyWith<$Res>
    implements $LockTimeCopyWith<$Res> {
  factory _$$LockTime_SecondsImplCopyWith(_$LockTime_SecondsImpl value,
          $Res Function(_$LockTime_SecondsImpl) then) =
      __$$LockTime_SecondsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int field0});
}

/// @nodoc
class __$$LockTime_SecondsImplCopyWithImpl<$Res>
    extends _$LockTimeCopyWithImpl<$Res, _$LockTime_SecondsImpl>
    implements _$$LockTime_SecondsImplCopyWith<$Res> {
  __$$LockTime_SecondsImplCopyWithImpl(_$LockTime_SecondsImpl _value,
      $Res Function(_$LockTime_SecondsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$LockTime_SecondsImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LockTime_SecondsImpl extends LockTime_Seconds {
  const _$LockTime_SecondsImpl(this.field0) : super._();

  @override
  final int field0;

  @override
  String toString() {
    return 'LockTime.seconds(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LockTime_SecondsImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LockTime_SecondsImplCopyWith<_$LockTime_SecondsImpl> get copyWith =>
      __$$LockTime_SecondsImplCopyWithImpl<_$LockTime_SecondsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int field0) blocks,
    required TResult Function(int field0) seconds,
  }) {
    return seconds(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int field0)? blocks,
    TResult? Function(int field0)? seconds,
  }) {
    return seconds?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int field0)? blocks,
    TResult Function(int field0)? seconds,
    required TResult orElse(),
  }) {
    if (seconds != null) {
      return seconds(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LockTime_Blocks value) blocks,
    required TResult Function(LockTime_Seconds value) seconds,
  }) {
    return seconds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LockTime_Blocks value)? blocks,
    TResult? Function(LockTime_Seconds value)? seconds,
  }) {
    return seconds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LockTime_Blocks value)? blocks,
    TResult Function(LockTime_Seconds value)? seconds,
    required TResult orElse(),
  }) {
    if (seconds != null) {
      return seconds(this);
    }
    return orElse();
  }
}

abstract class LockTime_Seconds extends LockTime {
  const factory LockTime_Seconds(final int field0) = _$LockTime_SecondsImpl;
  const LockTime_Seconds._() : super._();

  @override
  int get field0;
  @override
  @JsonKey(ignore: true)
  _$$LockTime_SecondsImplCopyWith<_$LockTime_SecondsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RbfValue {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() rbfDefault,
    required TResult Function(int field0) value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? rbfDefault,
    TResult? Function(int field0)? value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? rbfDefault,
    TResult Function(int field0)? value,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RbfValue_RbfDefault value) rbfDefault,
    required TResult Function(RbfValue_Value value) value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RbfValue_RbfDefault value)? rbfDefault,
    TResult? Function(RbfValue_Value value)? value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RbfValue_RbfDefault value)? rbfDefault,
    TResult Function(RbfValue_Value value)? value,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RbfValueCopyWith<$Res> {
  factory $RbfValueCopyWith(RbfValue value, $Res Function(RbfValue) then) =
      _$RbfValueCopyWithImpl<$Res, RbfValue>;
}

/// @nodoc
class _$RbfValueCopyWithImpl<$Res, $Val extends RbfValue>
    implements $RbfValueCopyWith<$Res> {
  _$RbfValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RbfValue_RbfDefaultImplCopyWith<$Res> {
  factory _$$RbfValue_RbfDefaultImplCopyWith(_$RbfValue_RbfDefaultImpl value,
          $Res Function(_$RbfValue_RbfDefaultImpl) then) =
      __$$RbfValue_RbfDefaultImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RbfValue_RbfDefaultImplCopyWithImpl<$Res>
    extends _$RbfValueCopyWithImpl<$Res, _$RbfValue_RbfDefaultImpl>
    implements _$$RbfValue_RbfDefaultImplCopyWith<$Res> {
  __$$RbfValue_RbfDefaultImplCopyWithImpl(_$RbfValue_RbfDefaultImpl _value,
      $Res Function(_$RbfValue_RbfDefaultImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RbfValue_RbfDefaultImpl extends RbfValue_RbfDefault {
  const _$RbfValue_RbfDefaultImpl() : super._();

  @override
  String toString() {
    return 'RbfValue.rbfDefault()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RbfValue_RbfDefaultImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() rbfDefault,
    required TResult Function(int field0) value,
  }) {
    return rbfDefault();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? rbfDefault,
    TResult? Function(int field0)? value,
  }) {
    return rbfDefault?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? rbfDefault,
    TResult Function(int field0)? value,
    required TResult orElse(),
  }) {
    if (rbfDefault != null) {
      return rbfDefault();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RbfValue_RbfDefault value) rbfDefault,
    required TResult Function(RbfValue_Value value) value,
  }) {
    return rbfDefault(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RbfValue_RbfDefault value)? rbfDefault,
    TResult? Function(RbfValue_Value value)? value,
  }) {
    return rbfDefault?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RbfValue_RbfDefault value)? rbfDefault,
    TResult Function(RbfValue_Value value)? value,
    required TResult orElse(),
  }) {
    if (rbfDefault != null) {
      return rbfDefault(this);
    }
    return orElse();
  }
}

abstract class RbfValue_RbfDefault extends RbfValue {
  const factory RbfValue_RbfDefault() = _$RbfValue_RbfDefaultImpl;
  const RbfValue_RbfDefault._() : super._();
}

/// @nodoc
abstract class _$$RbfValue_ValueImplCopyWith<$Res> {
  factory _$$RbfValue_ValueImplCopyWith(_$RbfValue_ValueImpl value,
          $Res Function(_$RbfValue_ValueImpl) then) =
      __$$RbfValue_ValueImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int field0});
}

/// @nodoc
class __$$RbfValue_ValueImplCopyWithImpl<$Res>
    extends _$RbfValueCopyWithImpl<$Res, _$RbfValue_ValueImpl>
    implements _$$RbfValue_ValueImplCopyWith<$Res> {
  __$$RbfValue_ValueImplCopyWithImpl(
      _$RbfValue_ValueImpl _value, $Res Function(_$RbfValue_ValueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$RbfValue_ValueImpl(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RbfValue_ValueImpl extends RbfValue_Value {
  const _$RbfValue_ValueImpl(this.field0) : super._();

  @override
  final int field0;

  @override
  String toString() {
    return 'RbfValue.value(field0: $field0)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RbfValue_ValueImpl &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RbfValue_ValueImplCopyWith<_$RbfValue_ValueImpl> get copyWith =>
      __$$RbfValue_ValueImplCopyWithImpl<_$RbfValue_ValueImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() rbfDefault,
    required TResult Function(int field0) value,
  }) {
    return value(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? rbfDefault,
    TResult? Function(int field0)? value,
  }) {
    return value?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? rbfDefault,
    TResult Function(int field0)? value,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RbfValue_RbfDefault value) rbfDefault,
    required TResult Function(RbfValue_Value value) value,
  }) {
    return value(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RbfValue_RbfDefault value)? rbfDefault,
    TResult? Function(RbfValue_Value value)? value,
  }) {
    return value?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RbfValue_RbfDefault value)? rbfDefault,
    TResult Function(RbfValue_Value value)? value,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(this);
    }
    return orElse();
  }
}

abstract class RbfValue_Value extends RbfValue {
  const factory RbfValue_Value(final int field0) = _$RbfValue_ValueImpl;
  const RbfValue_Value._() : super._();

  int get field0;
  @JsonKey(ignore: true)
  _$$RbfValue_ValueImplCopyWith<_$RbfValue_ValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Satisfaction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<int, List<Condition>> conditions)
        partial,
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<Uint32List, List<Condition>> conditions)
        partialComplete,
    required TResult Function(Condition condition) complete,
    required TResult Function(String msg) none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult? Function(Condition condition)? complete,
    TResult? Function(String msg)? none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult Function(Condition condition)? complete,
    TResult Function(String msg)? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Satisfaction_Partial value) partial,
    required TResult Function(Satisfaction_PartialComplete value)
        partialComplete,
    required TResult Function(Satisfaction_Complete value) complete,
    required TResult Function(Satisfaction_None value) none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Satisfaction_Partial value)? partial,
    TResult? Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult? Function(Satisfaction_Complete value)? complete,
    TResult? Function(Satisfaction_None value)? none,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Satisfaction_Partial value)? partial,
    TResult Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult Function(Satisfaction_Complete value)? complete,
    TResult Function(Satisfaction_None value)? none,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SatisfactionCopyWith<$Res> {
  factory $SatisfactionCopyWith(
          Satisfaction value, $Res Function(Satisfaction) then) =
      _$SatisfactionCopyWithImpl<$Res, Satisfaction>;
}

/// @nodoc
class _$SatisfactionCopyWithImpl<$Res, $Val extends Satisfaction>
    implements $SatisfactionCopyWith<$Res> {
  _$SatisfactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$Satisfaction_PartialImplCopyWith<$Res> {
  factory _$$Satisfaction_PartialImplCopyWith(_$Satisfaction_PartialImpl value,
          $Res Function(_$Satisfaction_PartialImpl) then) =
      __$$Satisfaction_PartialImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BigInt n,
      BigInt m,
      Uint64List items,
      bool? sorted,
      Map<int, List<Condition>> conditions});
}

/// @nodoc
class __$$Satisfaction_PartialImplCopyWithImpl<$Res>
    extends _$SatisfactionCopyWithImpl<$Res, _$Satisfaction_PartialImpl>
    implements _$$Satisfaction_PartialImplCopyWith<$Res> {
  __$$Satisfaction_PartialImplCopyWithImpl(_$Satisfaction_PartialImpl _value,
      $Res Function(_$Satisfaction_PartialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? n = null,
    Object? m = null,
    Object? items = null,
    Object? sorted = freezed,
    Object? conditions = null,
  }) {
    return _then(_$Satisfaction_PartialImpl(
      n: null == n
          ? _value.n
          : n // ignore: cast_nullable_to_non_nullable
              as BigInt,
      m: null == m
          ? _value.m
          : m // ignore: cast_nullable_to_non_nullable
              as BigInt,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as Uint64List,
      sorted: freezed == sorted
          ? _value.sorted
          : sorted // ignore: cast_nullable_to_non_nullable
              as bool?,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as Map<int, List<Condition>>,
    ));
  }
}

/// @nodoc

class _$Satisfaction_PartialImpl extends Satisfaction_Partial {
  const _$Satisfaction_PartialImpl(
      {required this.n,
      required this.m,
      required this.items,
      this.sorted,
      required final Map<int, List<Condition>> conditions})
      : _conditions = conditions,
        super._();

  @override
  final BigInt n;
  @override
  final BigInt m;
  @override
  final Uint64List items;
  @override
  final bool? sorted;
  final Map<int, List<Condition>> _conditions;
  @override
  Map<int, List<Condition>> get conditions {
    if (_conditions is EqualUnmodifiableMapView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_conditions);
  }

  @override
  String toString() {
    return 'Satisfaction.partial(n: $n, m: $m, items: $items, sorted: $sorted, conditions: $conditions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Satisfaction_PartialImpl &&
            (identical(other.n, n) || other.n == n) &&
            (identical(other.m, m) || other.m == m) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.sorted, sorted) || other.sorted == sorted) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      n,
      m,
      const DeepCollectionEquality().hash(items),
      sorted,
      const DeepCollectionEquality().hash(_conditions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Satisfaction_PartialImplCopyWith<_$Satisfaction_PartialImpl>
      get copyWith =>
          __$$Satisfaction_PartialImplCopyWithImpl<_$Satisfaction_PartialImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<int, List<Condition>> conditions)
        partial,
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<Uint32List, List<Condition>> conditions)
        partialComplete,
    required TResult Function(Condition condition) complete,
    required TResult Function(String msg) none,
  }) {
    return partial(n, m, items, sorted, conditions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult? Function(Condition condition)? complete,
    TResult? Function(String msg)? none,
  }) {
    return partial?.call(n, m, items, sorted, conditions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult Function(Condition condition)? complete,
    TResult Function(String msg)? none,
    required TResult orElse(),
  }) {
    if (partial != null) {
      return partial(n, m, items, sorted, conditions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Satisfaction_Partial value) partial,
    required TResult Function(Satisfaction_PartialComplete value)
        partialComplete,
    required TResult Function(Satisfaction_Complete value) complete,
    required TResult Function(Satisfaction_None value) none,
  }) {
    return partial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Satisfaction_Partial value)? partial,
    TResult? Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult? Function(Satisfaction_Complete value)? complete,
    TResult? Function(Satisfaction_None value)? none,
  }) {
    return partial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Satisfaction_Partial value)? partial,
    TResult Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult Function(Satisfaction_Complete value)? complete,
    TResult Function(Satisfaction_None value)? none,
    required TResult orElse(),
  }) {
    if (partial != null) {
      return partial(this);
    }
    return orElse();
  }
}

abstract class Satisfaction_Partial extends Satisfaction {
  const factory Satisfaction_Partial(
          {required final BigInt n,
          required final BigInt m,
          required final Uint64List items,
          final bool? sorted,
          required final Map<int, List<Condition>> conditions}) =
      _$Satisfaction_PartialImpl;
  const Satisfaction_Partial._() : super._();

  BigInt get n;
  BigInt get m;
  Uint64List get items;
  bool? get sorted;
  Map<int, List<Condition>> get conditions;
  @JsonKey(ignore: true)
  _$$Satisfaction_PartialImplCopyWith<_$Satisfaction_PartialImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Satisfaction_PartialCompleteImplCopyWith<$Res> {
  factory _$$Satisfaction_PartialCompleteImplCopyWith(
          _$Satisfaction_PartialCompleteImpl value,
          $Res Function(_$Satisfaction_PartialCompleteImpl) then) =
      __$$Satisfaction_PartialCompleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BigInt n,
      BigInt m,
      Uint64List items,
      bool? sorted,
      Map<Uint32List, List<Condition>> conditions});
}

/// @nodoc
class __$$Satisfaction_PartialCompleteImplCopyWithImpl<$Res>
    extends _$SatisfactionCopyWithImpl<$Res, _$Satisfaction_PartialCompleteImpl>
    implements _$$Satisfaction_PartialCompleteImplCopyWith<$Res> {
  __$$Satisfaction_PartialCompleteImplCopyWithImpl(
      _$Satisfaction_PartialCompleteImpl _value,
      $Res Function(_$Satisfaction_PartialCompleteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? n = null,
    Object? m = null,
    Object? items = null,
    Object? sorted = freezed,
    Object? conditions = null,
  }) {
    return _then(_$Satisfaction_PartialCompleteImpl(
      n: null == n
          ? _value.n
          : n // ignore: cast_nullable_to_non_nullable
              as BigInt,
      m: null == m
          ? _value.m
          : m // ignore: cast_nullable_to_non_nullable
              as BigInt,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as Uint64List,
      sorted: freezed == sorted
          ? _value.sorted
          : sorted // ignore: cast_nullable_to_non_nullable
              as bool?,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as Map<Uint32List, List<Condition>>,
    ));
  }
}

/// @nodoc

class _$Satisfaction_PartialCompleteImpl extends Satisfaction_PartialComplete {
  const _$Satisfaction_PartialCompleteImpl(
      {required this.n,
      required this.m,
      required this.items,
      this.sorted,
      required final Map<Uint32List, List<Condition>> conditions})
      : _conditions = conditions,
        super._();

  @override
  final BigInt n;
  @override
  final BigInt m;
  @override
  final Uint64List items;
  @override
  final bool? sorted;
  final Map<Uint32List, List<Condition>> _conditions;
  @override
  Map<Uint32List, List<Condition>> get conditions {
    if (_conditions is EqualUnmodifiableMapView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_conditions);
  }

  @override
  String toString() {
    return 'Satisfaction.partialComplete(n: $n, m: $m, items: $items, sorted: $sorted, conditions: $conditions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Satisfaction_PartialCompleteImpl &&
            (identical(other.n, n) || other.n == n) &&
            (identical(other.m, m) || other.m == m) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.sorted, sorted) || other.sorted == sorted) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      n,
      m,
      const DeepCollectionEquality().hash(items),
      sorted,
      const DeepCollectionEquality().hash(_conditions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Satisfaction_PartialCompleteImplCopyWith<
          _$Satisfaction_PartialCompleteImpl>
      get copyWith => __$$Satisfaction_PartialCompleteImplCopyWithImpl<
          _$Satisfaction_PartialCompleteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<int, List<Condition>> conditions)
        partial,
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<Uint32List, List<Condition>> conditions)
        partialComplete,
    required TResult Function(Condition condition) complete,
    required TResult Function(String msg) none,
  }) {
    return partialComplete(n, m, items, sorted, conditions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult? Function(Condition condition)? complete,
    TResult? Function(String msg)? none,
  }) {
    return partialComplete?.call(n, m, items, sorted, conditions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult Function(Condition condition)? complete,
    TResult Function(String msg)? none,
    required TResult orElse(),
  }) {
    if (partialComplete != null) {
      return partialComplete(n, m, items, sorted, conditions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Satisfaction_Partial value) partial,
    required TResult Function(Satisfaction_PartialComplete value)
        partialComplete,
    required TResult Function(Satisfaction_Complete value) complete,
    required TResult Function(Satisfaction_None value) none,
  }) {
    return partialComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Satisfaction_Partial value)? partial,
    TResult? Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult? Function(Satisfaction_Complete value)? complete,
    TResult? Function(Satisfaction_None value)? none,
  }) {
    return partialComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Satisfaction_Partial value)? partial,
    TResult Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult Function(Satisfaction_Complete value)? complete,
    TResult Function(Satisfaction_None value)? none,
    required TResult orElse(),
  }) {
    if (partialComplete != null) {
      return partialComplete(this);
    }
    return orElse();
  }
}

abstract class Satisfaction_PartialComplete extends Satisfaction {
  const factory Satisfaction_PartialComplete(
          {required final BigInt n,
          required final BigInt m,
          required final Uint64List items,
          final bool? sorted,
          required final Map<Uint32List, List<Condition>> conditions}) =
      _$Satisfaction_PartialCompleteImpl;
  const Satisfaction_PartialComplete._() : super._();

  BigInt get n;
  BigInt get m;
  Uint64List get items;
  bool? get sorted;
  Map<Uint32List, List<Condition>> get conditions;
  @JsonKey(ignore: true)
  _$$Satisfaction_PartialCompleteImplCopyWith<
          _$Satisfaction_PartialCompleteImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Satisfaction_CompleteImplCopyWith<$Res> {
  factory _$$Satisfaction_CompleteImplCopyWith(
          _$Satisfaction_CompleteImpl value,
          $Res Function(_$Satisfaction_CompleteImpl) then) =
      __$$Satisfaction_CompleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Condition condition});
}

/// @nodoc
class __$$Satisfaction_CompleteImplCopyWithImpl<$Res>
    extends _$SatisfactionCopyWithImpl<$Res, _$Satisfaction_CompleteImpl>
    implements _$$Satisfaction_CompleteImplCopyWith<$Res> {
  __$$Satisfaction_CompleteImplCopyWithImpl(_$Satisfaction_CompleteImpl _value,
      $Res Function(_$Satisfaction_CompleteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? condition = null,
  }) {
    return _then(_$Satisfaction_CompleteImpl(
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as Condition,
    ));
  }
}

/// @nodoc

class _$Satisfaction_CompleteImpl extends Satisfaction_Complete {
  const _$Satisfaction_CompleteImpl({required this.condition}) : super._();

  @override
  final Condition condition;

  @override
  String toString() {
    return 'Satisfaction.complete(condition: $condition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Satisfaction_CompleteImpl &&
            (identical(other.condition, condition) ||
                other.condition == condition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, condition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Satisfaction_CompleteImplCopyWith<_$Satisfaction_CompleteImpl>
      get copyWith => __$$Satisfaction_CompleteImplCopyWithImpl<
          _$Satisfaction_CompleteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<int, List<Condition>> conditions)
        partial,
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<Uint32List, List<Condition>> conditions)
        partialComplete,
    required TResult Function(Condition condition) complete,
    required TResult Function(String msg) none,
  }) {
    return complete(condition);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult? Function(Condition condition)? complete,
    TResult? Function(String msg)? none,
  }) {
    return complete?.call(condition);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult Function(Condition condition)? complete,
    TResult Function(String msg)? none,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(condition);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Satisfaction_Partial value) partial,
    required TResult Function(Satisfaction_PartialComplete value)
        partialComplete,
    required TResult Function(Satisfaction_Complete value) complete,
    required TResult Function(Satisfaction_None value) none,
  }) {
    return complete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Satisfaction_Partial value)? partial,
    TResult? Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult? Function(Satisfaction_Complete value)? complete,
    TResult? Function(Satisfaction_None value)? none,
  }) {
    return complete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Satisfaction_Partial value)? partial,
    TResult Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult Function(Satisfaction_Complete value)? complete,
    TResult Function(Satisfaction_None value)? none,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class Satisfaction_Complete extends Satisfaction {
  const factory Satisfaction_Complete({required final Condition condition}) =
      _$Satisfaction_CompleteImpl;
  const Satisfaction_Complete._() : super._();

  Condition get condition;
  @JsonKey(ignore: true)
  _$$Satisfaction_CompleteImplCopyWith<_$Satisfaction_CompleteImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Satisfaction_NoneImplCopyWith<$Res> {
  factory _$$Satisfaction_NoneImplCopyWith(_$Satisfaction_NoneImpl value,
          $Res Function(_$Satisfaction_NoneImpl) then) =
      __$$Satisfaction_NoneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String msg});
}

/// @nodoc
class __$$Satisfaction_NoneImplCopyWithImpl<$Res>
    extends _$SatisfactionCopyWithImpl<$Res, _$Satisfaction_NoneImpl>
    implements _$$Satisfaction_NoneImplCopyWith<$Res> {
  __$$Satisfaction_NoneImplCopyWithImpl(_$Satisfaction_NoneImpl _value,
      $Res Function(_$Satisfaction_NoneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = null,
  }) {
    return _then(_$Satisfaction_NoneImpl(
      msg: null == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Satisfaction_NoneImpl extends Satisfaction_None {
  const _$Satisfaction_NoneImpl({required this.msg}) : super._();

  @override
  final String msg;

  @override
  String toString() {
    return 'Satisfaction.none(msg: $msg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Satisfaction_NoneImpl &&
            (identical(other.msg, msg) || other.msg == msg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, msg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Satisfaction_NoneImplCopyWith<_$Satisfaction_NoneImpl> get copyWith =>
      __$$Satisfaction_NoneImplCopyWithImpl<_$Satisfaction_NoneImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<int, List<Condition>> conditions)
        partial,
    required TResult Function(BigInt n, BigInt m, Uint64List items,
            bool? sorted, Map<Uint32List, List<Condition>> conditions)
        partialComplete,
    required TResult Function(Condition condition) complete,
    required TResult Function(String msg) none,
  }) {
    return none(msg);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult? Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult? Function(Condition condition)? complete,
    TResult? Function(String msg)? none,
  }) {
    return none?.call(msg);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<int, List<Condition>> conditions)?
        partial,
    TResult Function(BigInt n, BigInt m, Uint64List items, bool? sorted,
            Map<Uint32List, List<Condition>> conditions)?
        partialComplete,
    TResult Function(Condition condition)? complete,
    TResult Function(String msg)? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Satisfaction_Partial value) partial,
    required TResult Function(Satisfaction_PartialComplete value)
        partialComplete,
    required TResult Function(Satisfaction_Complete value) complete,
    required TResult Function(Satisfaction_None value) none,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Satisfaction_Partial value)? partial,
    TResult? Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult? Function(Satisfaction_Complete value)? complete,
    TResult? Function(Satisfaction_None value)? none,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Satisfaction_Partial value)? partial,
    TResult Function(Satisfaction_PartialComplete value)? partialComplete,
    TResult Function(Satisfaction_Complete value)? complete,
    TResult Function(Satisfaction_None value)? none,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class Satisfaction_None extends Satisfaction {
  const factory Satisfaction_None({required final String msg}) =
      _$Satisfaction_NoneImpl;
  const Satisfaction_None._() : super._();

  String get msg;
  @JsonKey(ignore: true)
  _$$Satisfaction_NoneImplCopyWith<_$Satisfaction_NoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SatisfiableItem {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SatisfiableItemCopyWith<$Res> {
  factory $SatisfiableItemCopyWith(
          SatisfiableItem value, $Res Function(SatisfiableItem) then) =
      _$SatisfiableItemCopyWithImpl<$Res, SatisfiableItem>;
}

/// @nodoc
class _$SatisfiableItemCopyWithImpl<$Res, $Val extends SatisfiableItem>
    implements $SatisfiableItemCopyWith<$Res> {
  _$SatisfiableItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SatisfiableItem_EcdsaSignatureImplCopyWith<$Res> {
  factory _$$SatisfiableItem_EcdsaSignatureImplCopyWith(
          _$SatisfiableItem_EcdsaSignatureImpl value,
          $Res Function(_$SatisfiableItem_EcdsaSignatureImpl) then) =
      __$$SatisfiableItem_EcdsaSignatureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PkOrF key});

  $PkOrFCopyWith<$Res> get key;
}

/// @nodoc
class __$$SatisfiableItem_EcdsaSignatureImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res,
        _$SatisfiableItem_EcdsaSignatureImpl>
    implements _$$SatisfiableItem_EcdsaSignatureImplCopyWith<$Res> {
  __$$SatisfiableItem_EcdsaSignatureImplCopyWithImpl(
      _$SatisfiableItem_EcdsaSignatureImpl _value,
      $Res Function(_$SatisfiableItem_EcdsaSignatureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_$SatisfiableItem_EcdsaSignatureImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as PkOrF,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PkOrFCopyWith<$Res> get key {
    return $PkOrFCopyWith<$Res>(_value.key, (value) {
      return _then(_value.copyWith(key: value));
    });
  }
}

/// @nodoc

class _$SatisfiableItem_EcdsaSignatureImpl
    extends SatisfiableItem_EcdsaSignature {
  const _$SatisfiableItem_EcdsaSignatureImpl({required this.key}) : super._();

  @override
  final PkOrF key;

  @override
  String toString() {
    return 'SatisfiableItem.ecdsaSignature(key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_EcdsaSignatureImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_EcdsaSignatureImplCopyWith<
          _$SatisfiableItem_EcdsaSignatureImpl>
      get copyWith => __$$SatisfiableItem_EcdsaSignatureImplCopyWithImpl<
          _$SatisfiableItem_EcdsaSignatureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return ecdsaSignature(key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return ecdsaSignature?.call(key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (ecdsaSignature != null) {
      return ecdsaSignature(key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return ecdsaSignature(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return ecdsaSignature?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (ecdsaSignature != null) {
      return ecdsaSignature(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_EcdsaSignature extends SatisfiableItem {
  const factory SatisfiableItem_EcdsaSignature({required final PkOrF key}) =
      _$SatisfiableItem_EcdsaSignatureImpl;
  const SatisfiableItem_EcdsaSignature._() : super._();

  PkOrF get key;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_EcdsaSignatureImplCopyWith<
          _$SatisfiableItem_EcdsaSignatureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_SchnorrSignatureImplCopyWith<$Res> {
  factory _$$SatisfiableItem_SchnorrSignatureImplCopyWith(
          _$SatisfiableItem_SchnorrSignatureImpl value,
          $Res Function(_$SatisfiableItem_SchnorrSignatureImpl) then) =
      __$$SatisfiableItem_SchnorrSignatureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PkOrF key});

  $PkOrFCopyWith<$Res> get key;
}

/// @nodoc
class __$$SatisfiableItem_SchnorrSignatureImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res,
        _$SatisfiableItem_SchnorrSignatureImpl>
    implements _$$SatisfiableItem_SchnorrSignatureImplCopyWith<$Res> {
  __$$SatisfiableItem_SchnorrSignatureImplCopyWithImpl(
      _$SatisfiableItem_SchnorrSignatureImpl _value,
      $Res Function(_$SatisfiableItem_SchnorrSignatureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_$SatisfiableItem_SchnorrSignatureImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as PkOrF,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PkOrFCopyWith<$Res> get key {
    return $PkOrFCopyWith<$Res>(_value.key, (value) {
      return _then(_value.copyWith(key: value));
    });
  }
}

/// @nodoc

class _$SatisfiableItem_SchnorrSignatureImpl
    extends SatisfiableItem_SchnorrSignature {
  const _$SatisfiableItem_SchnorrSignatureImpl({required this.key}) : super._();

  @override
  final PkOrF key;

  @override
  String toString() {
    return 'SatisfiableItem.schnorrSignature(key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_SchnorrSignatureImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_SchnorrSignatureImplCopyWith<
          _$SatisfiableItem_SchnorrSignatureImpl>
      get copyWith => __$$SatisfiableItem_SchnorrSignatureImplCopyWithImpl<
          _$SatisfiableItem_SchnorrSignatureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return schnorrSignature(key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return schnorrSignature?.call(key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (schnorrSignature != null) {
      return schnorrSignature(key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return schnorrSignature(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return schnorrSignature?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (schnorrSignature != null) {
      return schnorrSignature(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_SchnorrSignature extends SatisfiableItem {
  const factory SatisfiableItem_SchnorrSignature({required final PkOrF key}) =
      _$SatisfiableItem_SchnorrSignatureImpl;
  const SatisfiableItem_SchnorrSignature._() : super._();

  PkOrF get key;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_SchnorrSignatureImplCopyWith<
          _$SatisfiableItem_SchnorrSignatureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_Sha256PreimageImplCopyWith<$Res> {
  factory _$$SatisfiableItem_Sha256PreimageImplCopyWith(
          _$SatisfiableItem_Sha256PreimageImpl value,
          $Res Function(_$SatisfiableItem_Sha256PreimageImpl) then) =
      __$$SatisfiableItem_Sha256PreimageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hash});
}

/// @nodoc
class __$$SatisfiableItem_Sha256PreimageImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res,
        _$SatisfiableItem_Sha256PreimageImpl>
    implements _$$SatisfiableItem_Sha256PreimageImplCopyWith<$Res> {
  __$$SatisfiableItem_Sha256PreimageImplCopyWithImpl(
      _$SatisfiableItem_Sha256PreimageImpl _value,
      $Res Function(_$SatisfiableItem_Sha256PreimageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
  }) {
    return _then(_$SatisfiableItem_Sha256PreimageImpl(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SatisfiableItem_Sha256PreimageImpl
    extends SatisfiableItem_Sha256Preimage {
  const _$SatisfiableItem_Sha256PreimageImpl({required this.hash}) : super._();

  @override
  final String hash;

  @override
  String toString() {
    return 'SatisfiableItem.sha256Preimage(hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_Sha256PreimageImpl &&
            (identical(other.hash, hash) || other.hash == hash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_Sha256PreimageImplCopyWith<
          _$SatisfiableItem_Sha256PreimageImpl>
      get copyWith => __$$SatisfiableItem_Sha256PreimageImplCopyWithImpl<
          _$SatisfiableItem_Sha256PreimageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return sha256Preimage(hash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return sha256Preimage?.call(hash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (sha256Preimage != null) {
      return sha256Preimage(hash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return sha256Preimage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return sha256Preimage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (sha256Preimage != null) {
      return sha256Preimage(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_Sha256Preimage extends SatisfiableItem {
  const factory SatisfiableItem_Sha256Preimage({required final String hash}) =
      _$SatisfiableItem_Sha256PreimageImpl;
  const SatisfiableItem_Sha256Preimage._() : super._();

  String get hash;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_Sha256PreimageImplCopyWith<
          _$SatisfiableItem_Sha256PreimageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_Hash256PreimageImplCopyWith<$Res> {
  factory _$$SatisfiableItem_Hash256PreimageImplCopyWith(
          _$SatisfiableItem_Hash256PreimageImpl value,
          $Res Function(_$SatisfiableItem_Hash256PreimageImpl) then) =
      __$$SatisfiableItem_Hash256PreimageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hash});
}

/// @nodoc
class __$$SatisfiableItem_Hash256PreimageImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res,
        _$SatisfiableItem_Hash256PreimageImpl>
    implements _$$SatisfiableItem_Hash256PreimageImplCopyWith<$Res> {
  __$$SatisfiableItem_Hash256PreimageImplCopyWithImpl(
      _$SatisfiableItem_Hash256PreimageImpl _value,
      $Res Function(_$SatisfiableItem_Hash256PreimageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
  }) {
    return _then(_$SatisfiableItem_Hash256PreimageImpl(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SatisfiableItem_Hash256PreimageImpl
    extends SatisfiableItem_Hash256Preimage {
  const _$SatisfiableItem_Hash256PreimageImpl({required this.hash}) : super._();

  @override
  final String hash;

  @override
  String toString() {
    return 'SatisfiableItem.hash256Preimage(hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_Hash256PreimageImpl &&
            (identical(other.hash, hash) || other.hash == hash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_Hash256PreimageImplCopyWith<
          _$SatisfiableItem_Hash256PreimageImpl>
      get copyWith => __$$SatisfiableItem_Hash256PreimageImplCopyWithImpl<
          _$SatisfiableItem_Hash256PreimageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return hash256Preimage(hash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return hash256Preimage?.call(hash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (hash256Preimage != null) {
      return hash256Preimage(hash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return hash256Preimage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return hash256Preimage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (hash256Preimage != null) {
      return hash256Preimage(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_Hash256Preimage extends SatisfiableItem {
  const factory SatisfiableItem_Hash256Preimage({required final String hash}) =
      _$SatisfiableItem_Hash256PreimageImpl;
  const SatisfiableItem_Hash256Preimage._() : super._();

  String get hash;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_Hash256PreimageImplCopyWith<
          _$SatisfiableItem_Hash256PreimageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_Ripemd160PreimageImplCopyWith<$Res> {
  factory _$$SatisfiableItem_Ripemd160PreimageImplCopyWith(
          _$SatisfiableItem_Ripemd160PreimageImpl value,
          $Res Function(_$SatisfiableItem_Ripemd160PreimageImpl) then) =
      __$$SatisfiableItem_Ripemd160PreimageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hash});
}

/// @nodoc
class __$$SatisfiableItem_Ripemd160PreimageImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res,
        _$SatisfiableItem_Ripemd160PreimageImpl>
    implements _$$SatisfiableItem_Ripemd160PreimageImplCopyWith<$Res> {
  __$$SatisfiableItem_Ripemd160PreimageImplCopyWithImpl(
      _$SatisfiableItem_Ripemd160PreimageImpl _value,
      $Res Function(_$SatisfiableItem_Ripemd160PreimageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
  }) {
    return _then(_$SatisfiableItem_Ripemd160PreimageImpl(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SatisfiableItem_Ripemd160PreimageImpl
    extends SatisfiableItem_Ripemd160Preimage {
  const _$SatisfiableItem_Ripemd160PreimageImpl({required this.hash})
      : super._();

  @override
  final String hash;

  @override
  String toString() {
    return 'SatisfiableItem.ripemd160Preimage(hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_Ripemd160PreimageImpl &&
            (identical(other.hash, hash) || other.hash == hash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_Ripemd160PreimageImplCopyWith<
          _$SatisfiableItem_Ripemd160PreimageImpl>
      get copyWith => __$$SatisfiableItem_Ripemd160PreimageImplCopyWithImpl<
          _$SatisfiableItem_Ripemd160PreimageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return ripemd160Preimage(hash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return ripemd160Preimage?.call(hash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (ripemd160Preimage != null) {
      return ripemd160Preimage(hash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return ripemd160Preimage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return ripemd160Preimage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (ripemd160Preimage != null) {
      return ripemd160Preimage(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_Ripemd160Preimage extends SatisfiableItem {
  const factory SatisfiableItem_Ripemd160Preimage(
      {required final String hash}) = _$SatisfiableItem_Ripemd160PreimageImpl;
  const SatisfiableItem_Ripemd160Preimage._() : super._();

  String get hash;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_Ripemd160PreimageImplCopyWith<
          _$SatisfiableItem_Ripemd160PreimageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_Hash160PreimageImplCopyWith<$Res> {
  factory _$$SatisfiableItem_Hash160PreimageImplCopyWith(
          _$SatisfiableItem_Hash160PreimageImpl value,
          $Res Function(_$SatisfiableItem_Hash160PreimageImpl) then) =
      __$$SatisfiableItem_Hash160PreimageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String hash});
}

/// @nodoc
class __$$SatisfiableItem_Hash160PreimageImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res,
        _$SatisfiableItem_Hash160PreimageImpl>
    implements _$$SatisfiableItem_Hash160PreimageImplCopyWith<$Res> {
  __$$SatisfiableItem_Hash160PreimageImplCopyWithImpl(
      _$SatisfiableItem_Hash160PreimageImpl _value,
      $Res Function(_$SatisfiableItem_Hash160PreimageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
  }) {
    return _then(_$SatisfiableItem_Hash160PreimageImpl(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SatisfiableItem_Hash160PreimageImpl
    extends SatisfiableItem_Hash160Preimage {
  const _$SatisfiableItem_Hash160PreimageImpl({required this.hash}) : super._();

  @override
  final String hash;

  @override
  String toString() {
    return 'SatisfiableItem.hash160Preimage(hash: $hash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_Hash160PreimageImpl &&
            (identical(other.hash, hash) || other.hash == hash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_Hash160PreimageImplCopyWith<
          _$SatisfiableItem_Hash160PreimageImpl>
      get copyWith => __$$SatisfiableItem_Hash160PreimageImplCopyWithImpl<
          _$SatisfiableItem_Hash160PreimageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return hash160Preimage(hash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return hash160Preimage?.call(hash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (hash160Preimage != null) {
      return hash160Preimage(hash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return hash160Preimage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return hash160Preimage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (hash160Preimage != null) {
      return hash160Preimage(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_Hash160Preimage extends SatisfiableItem {
  const factory SatisfiableItem_Hash160Preimage({required final String hash}) =
      _$SatisfiableItem_Hash160PreimageImpl;
  const SatisfiableItem_Hash160Preimage._() : super._();

  String get hash;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_Hash160PreimageImplCopyWith<
          _$SatisfiableItem_Hash160PreimageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_AbsoluteTimelockImplCopyWith<$Res> {
  factory _$$SatisfiableItem_AbsoluteTimelockImplCopyWith(
          _$SatisfiableItem_AbsoluteTimelockImpl value,
          $Res Function(_$SatisfiableItem_AbsoluteTimelockImpl) then) =
      __$$SatisfiableItem_AbsoluteTimelockImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LockTime value});

  $LockTimeCopyWith<$Res> get value;
}

/// @nodoc
class __$$SatisfiableItem_AbsoluteTimelockImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res,
        _$SatisfiableItem_AbsoluteTimelockImpl>
    implements _$$SatisfiableItem_AbsoluteTimelockImplCopyWith<$Res> {
  __$$SatisfiableItem_AbsoluteTimelockImplCopyWithImpl(
      _$SatisfiableItem_AbsoluteTimelockImpl _value,
      $Res Function(_$SatisfiableItem_AbsoluteTimelockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SatisfiableItem_AbsoluteTimelockImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as LockTime,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $LockTimeCopyWith<$Res> get value {
    return $LockTimeCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc

class _$SatisfiableItem_AbsoluteTimelockImpl
    extends SatisfiableItem_AbsoluteTimelock {
  const _$SatisfiableItem_AbsoluteTimelockImpl({required this.value})
      : super._();

  @override
  final LockTime value;

  @override
  String toString() {
    return 'SatisfiableItem.absoluteTimelock(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_AbsoluteTimelockImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_AbsoluteTimelockImplCopyWith<
          _$SatisfiableItem_AbsoluteTimelockImpl>
      get copyWith => __$$SatisfiableItem_AbsoluteTimelockImplCopyWithImpl<
          _$SatisfiableItem_AbsoluteTimelockImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return absoluteTimelock(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return absoluteTimelock?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (absoluteTimelock != null) {
      return absoluteTimelock(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return absoluteTimelock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return absoluteTimelock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (absoluteTimelock != null) {
      return absoluteTimelock(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_AbsoluteTimelock extends SatisfiableItem {
  const factory SatisfiableItem_AbsoluteTimelock(
      {required final LockTime value}) = _$SatisfiableItem_AbsoluteTimelockImpl;
  const SatisfiableItem_AbsoluteTimelock._() : super._();

  LockTime get value;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_AbsoluteTimelockImplCopyWith<
          _$SatisfiableItem_AbsoluteTimelockImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_RelativeTimelockImplCopyWith<$Res> {
  factory _$$SatisfiableItem_RelativeTimelockImplCopyWith(
          _$SatisfiableItem_RelativeTimelockImpl value,
          $Res Function(_$SatisfiableItem_RelativeTimelockImpl) then) =
      __$$SatisfiableItem_RelativeTimelockImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int value});
}

/// @nodoc
class __$$SatisfiableItem_RelativeTimelockImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res,
        _$SatisfiableItem_RelativeTimelockImpl>
    implements _$$SatisfiableItem_RelativeTimelockImplCopyWith<$Res> {
  __$$SatisfiableItem_RelativeTimelockImplCopyWithImpl(
      _$SatisfiableItem_RelativeTimelockImpl _value,
      $Res Function(_$SatisfiableItem_RelativeTimelockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SatisfiableItem_RelativeTimelockImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SatisfiableItem_RelativeTimelockImpl
    extends SatisfiableItem_RelativeTimelock {
  const _$SatisfiableItem_RelativeTimelockImpl({required this.value})
      : super._();

  @override
  final int value;

  @override
  String toString() {
    return 'SatisfiableItem.relativeTimelock(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_RelativeTimelockImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_RelativeTimelockImplCopyWith<
          _$SatisfiableItem_RelativeTimelockImpl>
      get copyWith => __$$SatisfiableItem_RelativeTimelockImplCopyWithImpl<
          _$SatisfiableItem_RelativeTimelockImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return relativeTimelock(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return relativeTimelock?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (relativeTimelock != null) {
      return relativeTimelock(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return relativeTimelock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return relativeTimelock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (relativeTimelock != null) {
      return relativeTimelock(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_RelativeTimelock extends SatisfiableItem {
  const factory SatisfiableItem_RelativeTimelock({required final int value}) =
      _$SatisfiableItem_RelativeTimelockImpl;
  const SatisfiableItem_RelativeTimelock._() : super._();

  int get value;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_RelativeTimelockImplCopyWith<
          _$SatisfiableItem_RelativeTimelockImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_MultisigImplCopyWith<$Res> {
  factory _$$SatisfiableItem_MultisigImplCopyWith(
          _$SatisfiableItem_MultisigImpl value,
          $Res Function(_$SatisfiableItem_MultisigImpl) then) =
      __$$SatisfiableItem_MultisigImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PkOrF> keys, BigInt threshold});
}

/// @nodoc
class __$$SatisfiableItem_MultisigImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res, _$SatisfiableItem_MultisigImpl>
    implements _$$SatisfiableItem_MultisigImplCopyWith<$Res> {
  __$$SatisfiableItem_MultisigImplCopyWithImpl(
      _$SatisfiableItem_MultisigImpl _value,
      $Res Function(_$SatisfiableItem_MultisigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keys = null,
    Object? threshold = null,
  }) {
    return _then(_$SatisfiableItem_MultisigImpl(
      keys: null == keys
          ? _value._keys
          : keys // ignore: cast_nullable_to_non_nullable
              as List<PkOrF>,
      threshold: null == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc

class _$SatisfiableItem_MultisigImpl extends SatisfiableItem_Multisig {
  const _$SatisfiableItem_MultisigImpl(
      {required final List<PkOrF> keys, required this.threshold})
      : _keys = keys,
        super._();

  final List<PkOrF> _keys;
  @override
  List<PkOrF> get keys {
    if (_keys is EqualUnmodifiableListView) return _keys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keys);
  }

  @override
  final BigInt threshold;

  @override
  String toString() {
    return 'SatisfiableItem.multisig(keys: $keys, threshold: $threshold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_MultisigImpl &&
            const DeepCollectionEquality().equals(other._keys, _keys) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_keys), threshold);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_MultisigImplCopyWith<_$SatisfiableItem_MultisigImpl>
      get copyWith => __$$SatisfiableItem_MultisigImplCopyWithImpl<
          _$SatisfiableItem_MultisigImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return multisig(keys, threshold);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return multisig?.call(keys, threshold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (multisig != null) {
      return multisig(keys, threshold);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return multisig(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return multisig?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (multisig != null) {
      return multisig(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_Multisig extends SatisfiableItem {
  const factory SatisfiableItem_Multisig(
      {required final List<PkOrF> keys,
      required final BigInt threshold}) = _$SatisfiableItem_MultisigImpl;
  const SatisfiableItem_Multisig._() : super._();

  List<PkOrF> get keys;
  BigInt get threshold;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_MultisigImplCopyWith<_$SatisfiableItem_MultisigImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SatisfiableItem_ThreshImplCopyWith<$Res> {
  factory _$$SatisfiableItem_ThreshImplCopyWith(
          _$SatisfiableItem_ThreshImpl value,
          $Res Function(_$SatisfiableItem_ThreshImpl) then) =
      __$$SatisfiableItem_ThreshImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BdkPolicy> items, BigInt threshold});
}

/// @nodoc
class __$$SatisfiableItem_ThreshImplCopyWithImpl<$Res>
    extends _$SatisfiableItemCopyWithImpl<$Res, _$SatisfiableItem_ThreshImpl>
    implements _$$SatisfiableItem_ThreshImplCopyWith<$Res> {
  __$$SatisfiableItem_ThreshImplCopyWithImpl(
      _$SatisfiableItem_ThreshImpl _value,
      $Res Function(_$SatisfiableItem_ThreshImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? threshold = null,
  }) {
    return _then(_$SatisfiableItem_ThreshImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BdkPolicy>,
      threshold: null == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc

class _$SatisfiableItem_ThreshImpl extends SatisfiableItem_Thresh {
  const _$SatisfiableItem_ThreshImpl(
      {required final List<BdkPolicy> items, required this.threshold})
      : _items = items,
        super._();

  final List<BdkPolicy> _items;
  @override
  List<BdkPolicy> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final BigInt threshold;

  @override
  String toString() {
    return 'SatisfiableItem.thresh(items: $items, threshold: $threshold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SatisfiableItem_ThreshImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), threshold);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SatisfiableItem_ThreshImplCopyWith<_$SatisfiableItem_ThreshImpl>
      get copyWith => __$$SatisfiableItem_ThreshImplCopyWithImpl<
          _$SatisfiableItem_ThreshImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PkOrF key) ecdsaSignature,
    required TResult Function(PkOrF key) schnorrSignature,
    required TResult Function(String hash) sha256Preimage,
    required TResult Function(String hash) hash256Preimage,
    required TResult Function(String hash) ripemd160Preimage,
    required TResult Function(String hash) hash160Preimage,
    required TResult Function(LockTime value) absoluteTimelock,
    required TResult Function(int value) relativeTimelock,
    required TResult Function(List<PkOrF> keys, BigInt threshold) multisig,
    required TResult Function(List<BdkPolicy> items, BigInt threshold) thresh,
  }) {
    return thresh(items, threshold);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PkOrF key)? ecdsaSignature,
    TResult? Function(PkOrF key)? schnorrSignature,
    TResult? Function(String hash)? sha256Preimage,
    TResult? Function(String hash)? hash256Preimage,
    TResult? Function(String hash)? ripemd160Preimage,
    TResult? Function(String hash)? hash160Preimage,
    TResult? Function(LockTime value)? absoluteTimelock,
    TResult? Function(int value)? relativeTimelock,
    TResult? Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult? Function(List<BdkPolicy> items, BigInt threshold)? thresh,
  }) {
    return thresh?.call(items, threshold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PkOrF key)? ecdsaSignature,
    TResult Function(PkOrF key)? schnorrSignature,
    TResult Function(String hash)? sha256Preimage,
    TResult Function(String hash)? hash256Preimage,
    TResult Function(String hash)? ripemd160Preimage,
    TResult Function(String hash)? hash160Preimage,
    TResult Function(LockTime value)? absoluteTimelock,
    TResult Function(int value)? relativeTimelock,
    TResult Function(List<PkOrF> keys, BigInt threshold)? multisig,
    TResult Function(List<BdkPolicy> items, BigInt threshold)? thresh,
    required TResult orElse(),
  }) {
    if (thresh != null) {
      return thresh(items, threshold);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SatisfiableItem_EcdsaSignature value)
        ecdsaSignature,
    required TResult Function(SatisfiableItem_SchnorrSignature value)
        schnorrSignature,
    required TResult Function(SatisfiableItem_Sha256Preimage value)
        sha256Preimage,
    required TResult Function(SatisfiableItem_Hash256Preimage value)
        hash256Preimage,
    required TResult Function(SatisfiableItem_Ripemd160Preimage value)
        ripemd160Preimage,
    required TResult Function(SatisfiableItem_Hash160Preimage value)
        hash160Preimage,
    required TResult Function(SatisfiableItem_AbsoluteTimelock value)
        absoluteTimelock,
    required TResult Function(SatisfiableItem_RelativeTimelock value)
        relativeTimelock,
    required TResult Function(SatisfiableItem_Multisig value) multisig,
    required TResult Function(SatisfiableItem_Thresh value) thresh,
  }) {
    return thresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult? Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult? Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult? Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult? Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult? Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult? Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult? Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult? Function(SatisfiableItem_Multisig value)? multisig,
    TResult? Function(SatisfiableItem_Thresh value)? thresh,
  }) {
    return thresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SatisfiableItem_EcdsaSignature value)? ecdsaSignature,
    TResult Function(SatisfiableItem_SchnorrSignature value)? schnorrSignature,
    TResult Function(SatisfiableItem_Sha256Preimage value)? sha256Preimage,
    TResult Function(SatisfiableItem_Hash256Preimage value)? hash256Preimage,
    TResult Function(SatisfiableItem_Ripemd160Preimage value)?
        ripemd160Preimage,
    TResult Function(SatisfiableItem_Hash160Preimage value)? hash160Preimage,
    TResult Function(SatisfiableItem_AbsoluteTimelock value)? absoluteTimelock,
    TResult Function(SatisfiableItem_RelativeTimelock value)? relativeTimelock,
    TResult Function(SatisfiableItem_Multisig value)? multisig,
    TResult Function(SatisfiableItem_Thresh value)? thresh,
    required TResult orElse(),
  }) {
    if (thresh != null) {
      return thresh(this);
    }
    return orElse();
  }
}

abstract class SatisfiableItem_Thresh extends SatisfiableItem {
  const factory SatisfiableItem_Thresh(
      {required final List<BdkPolicy> items,
      required final BigInt threshold}) = _$SatisfiableItem_ThreshImpl;
  const SatisfiableItem_Thresh._() : super._();

  List<BdkPolicy> get items;
  BigInt get threshold;
  @JsonKey(ignore: true)
  _$$SatisfiableItem_ThreshImplCopyWith<_$SatisfiableItem_ThreshImpl>
      get copyWith => throw _privateConstructorUsedError;
}
