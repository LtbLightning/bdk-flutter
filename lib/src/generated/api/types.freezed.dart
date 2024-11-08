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
