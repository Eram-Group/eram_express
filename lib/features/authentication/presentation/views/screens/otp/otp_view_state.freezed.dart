// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OtpViewState {
  String get otp => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Create a copy of OtpViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpViewStateCopyWith<OtpViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpViewStateCopyWith<$Res> {
  factory $OtpViewStateCopyWith(
          OtpViewState value, $Res Function(OtpViewState) then) =
      _$OtpViewStateCopyWithImpl<$Res, OtpViewState>;
  @useResult
  $Res call({String otp, bool loading});
}

/// @nodoc
class _$OtpViewStateCopyWithImpl<$Res, $Val extends OtpViewState>
    implements $OtpViewStateCopyWith<$Res> {
  _$OtpViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpViewStateImplCopyWith<$Res>
    implements $OtpViewStateCopyWith<$Res> {
  factory _$$OtpViewStateImplCopyWith(
          _$OtpViewStateImpl value, $Res Function(_$OtpViewStateImpl) then) =
      __$$OtpViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String otp, bool loading});
}

/// @nodoc
class __$$OtpViewStateImplCopyWithImpl<$Res>
    extends _$OtpViewStateCopyWithImpl<$Res, _$OtpViewStateImpl>
    implements _$$OtpViewStateImplCopyWith<$Res> {
  __$$OtpViewStateImplCopyWithImpl(
      _$OtpViewStateImpl _value, $Res Function(_$OtpViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = null,
    Object? loading = null,
  }) {
    return _then(_$OtpViewStateImpl(
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OtpViewStateImpl extends _OtpViewState {
  _$OtpViewStateImpl({this.otp = '', this.loading = false}) : super._();

  @override
  @JsonKey()
  final String otp;
  @override
  @JsonKey()
  final bool loading;

  @override
  String toString() {
    return 'OtpViewState(otp: $otp, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpViewStateImpl &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, otp, loading);

  /// Create a copy of OtpViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpViewStateImplCopyWith<_$OtpViewStateImpl> get copyWith =>
      __$$OtpViewStateImplCopyWithImpl<_$OtpViewStateImpl>(this, _$identity);
}

abstract class _OtpViewState extends OtpViewState {
  factory _OtpViewState({final String otp, final bool loading}) =
      _$OtpViewStateImpl;
  _OtpViewState._() : super._();

  @override
  String get otp;
  @override
  bool get loading;

  /// Create a copy of OtpViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpViewStateImplCopyWith<_$OtpViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
