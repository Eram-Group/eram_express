// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_profile_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CompleteProfileViewState {
  File? get profilePicture => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  bool get saving => throw _privateConstructorUsedError;

  /// Create a copy of CompleteProfileViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompleteProfileViewStateCopyWith<CompleteProfileViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompleteProfileViewStateCopyWith<$Res> {
  factory $CompleteProfileViewStateCopyWith(CompleteProfileViewState value,
          $Res Function(CompleteProfileViewState) then) =
      _$CompleteProfileViewStateCopyWithImpl<$Res, CompleteProfileViewState>;
  @useResult
  $Res call({File? profilePicture, String fullName, bool saving});
}

/// @nodoc
class _$CompleteProfileViewStateCopyWithImpl<$Res,
        $Val extends CompleteProfileViewState>
    implements $CompleteProfileViewStateCopyWith<$Res> {
  _$CompleteProfileViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompleteProfileViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profilePicture = freezed,
    Object? fullName = null,
    Object? saving = null,
  }) {
    return _then(_value.copyWith(
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as File?,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompleteProfileViewStateImplCopyWith<$Res>
    implements $CompleteProfileViewStateCopyWith<$Res> {
  factory _$$CompleteProfileViewStateImplCopyWith(
          _$CompleteProfileViewStateImpl value,
          $Res Function(_$CompleteProfileViewStateImpl) then) =
      __$$CompleteProfileViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File? profilePicture, String fullName, bool saving});
}

/// @nodoc
class __$$CompleteProfileViewStateImplCopyWithImpl<$Res>
    extends _$CompleteProfileViewStateCopyWithImpl<$Res,
        _$CompleteProfileViewStateImpl>
    implements _$$CompleteProfileViewStateImplCopyWith<$Res> {
  __$$CompleteProfileViewStateImplCopyWithImpl(
      _$CompleteProfileViewStateImpl _value,
      $Res Function(_$CompleteProfileViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CompleteProfileViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profilePicture = freezed,
    Object? fullName = null,
    Object? saving = null,
  }) {
    return _then(_$CompleteProfileViewStateImpl(
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as File?,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CompleteProfileViewStateImpl extends _CompleteProfileViewState {
  _$CompleteProfileViewStateImpl(
      {this.profilePicture, this.fullName = '', this.saving = false})
      : super._();

  @override
  final File? profilePicture;
  @override
  @JsonKey()
  final String fullName;
  @override
  @JsonKey()
  final bool saving;

  @override
  String toString() {
    return 'CompleteProfileViewState(profilePicture: $profilePicture, fullName: $fullName, saving: $saving)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompleteProfileViewStateImpl &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.saving, saving) || other.saving == saving));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, profilePicture, fullName, saving);

  /// Create a copy of CompleteProfileViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompleteProfileViewStateImplCopyWith<_$CompleteProfileViewStateImpl>
      get copyWith => __$$CompleteProfileViewStateImplCopyWithImpl<
          _$CompleteProfileViewStateImpl>(this, _$identity);
}

abstract class _CompleteProfileViewState extends CompleteProfileViewState {
  factory _CompleteProfileViewState(
      {final File? profilePicture,
      final String fullName,
      final bool saving}) = _$CompleteProfileViewStateImpl;
  _CompleteProfileViewState._() : super._();

  @override
  File? get profilePicture;
  @override
  String get fullName;
  @override
  bool get saving;

  /// Create a copy of CompleteProfileViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompleteProfileViewStateImplCopyWith<_$CompleteProfileViewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
