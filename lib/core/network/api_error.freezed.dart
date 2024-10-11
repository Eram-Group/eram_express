// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return _ApiError.fromJson(json);
}

/// @nodoc
mixin _$ApiError {
  String get type => throw _privateConstructorUsedError;
  List<ApiErrorDetail> get errors => throw _privateConstructorUsedError;

  /// Serializes this ApiError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiErrorCopyWith<ApiError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorCopyWith<$Res> {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) then) =
      _$ApiErrorCopyWithImpl<$Res, ApiError>;
  @useResult
  $Res call({String type, List<ApiErrorDetail> errors});
}

/// @nodoc
class _$ApiErrorCopyWithImpl<$Res, $Val extends ApiError>
    implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<ApiErrorDetail>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiErrorImplCopyWith<$Res>
    implements $ApiErrorCopyWith<$Res> {
  factory _$$ApiErrorImplCopyWith(
          _$ApiErrorImpl value, $Res Function(_$ApiErrorImpl) then) =
      __$$ApiErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, List<ApiErrorDetail> errors});
}

/// @nodoc
class __$$ApiErrorImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ApiErrorImpl>
    implements _$$ApiErrorImplCopyWith<$Res> {
  __$$ApiErrorImplCopyWithImpl(
      _$ApiErrorImpl _value, $Res Function(_$ApiErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? errors = null,
  }) {
    return _then(_$ApiErrorImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<ApiErrorDetail>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorImpl implements _ApiError {
  _$ApiErrorImpl(
      {required this.type, required final List<ApiErrorDetail> errors})
      : _errors = errors;

  factory _$ApiErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorImplFromJson(json);

  @override
  final String type;
  final List<ApiErrorDetail> _errors;
  @override
  List<ApiErrorDetail> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'ApiError(type: $type, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_errors));

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      __$$ApiErrorImplCopyWithImpl<_$ApiErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorImplToJson(
      this,
    );
  }
}

abstract class _ApiError implements ApiError {
  factory _ApiError(
      {required final String type,
      required final List<ApiErrorDetail> errors}) = _$ApiErrorImpl;

  factory _ApiError.fromJson(Map<String, dynamic> json) =
      _$ApiErrorImpl.fromJson;

  @override
  String get type;
  @override
  List<ApiErrorDetail> get errors;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiErrorDetail _$ApiErrorDetailFromJson(Map<String, dynamic> json) {
  return _ApiErrorDetail.fromJson(json);
}

/// @nodoc
mixin _$ApiErrorDetail {
  String get code => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;
  String get attr => throw _privateConstructorUsedError;

  /// Serializes this ApiErrorDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiErrorDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiErrorDetailCopyWith<ApiErrorDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorDetailCopyWith<$Res> {
  factory $ApiErrorDetailCopyWith(
          ApiErrorDetail value, $Res Function(ApiErrorDetail) then) =
      _$ApiErrorDetailCopyWithImpl<$Res, ApiErrorDetail>;
  @useResult
  $Res call({String code, String detail, String attr});
}

/// @nodoc
class _$ApiErrorDetailCopyWithImpl<$Res, $Val extends ApiErrorDetail>
    implements $ApiErrorDetailCopyWith<$Res> {
  _$ApiErrorDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiErrorDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? detail = null,
    Object? attr = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      detail: null == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String,
      attr: null == attr
          ? _value.attr
          : attr // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiErrorDetailImplCopyWith<$Res>
    implements $ApiErrorDetailCopyWith<$Res> {
  factory _$$ApiErrorDetailImplCopyWith(_$ApiErrorDetailImpl value,
          $Res Function(_$ApiErrorDetailImpl) then) =
      __$$ApiErrorDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String detail, String attr});
}

/// @nodoc
class __$$ApiErrorDetailImplCopyWithImpl<$Res>
    extends _$ApiErrorDetailCopyWithImpl<$Res, _$ApiErrorDetailImpl>
    implements _$$ApiErrorDetailImplCopyWith<$Res> {
  __$$ApiErrorDetailImplCopyWithImpl(
      _$ApiErrorDetailImpl _value, $Res Function(_$ApiErrorDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApiErrorDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? detail = null,
    Object? attr = null,
  }) {
    return _then(_$ApiErrorDetailImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      detail: null == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String,
      attr: null == attr
          ? _value.attr
          : attr // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorDetailImpl implements _ApiErrorDetail {
  _$ApiErrorDetailImpl(
      {required this.code, required this.detail, required this.attr});

  factory _$ApiErrorDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorDetailImplFromJson(json);

  @override
  final String code;
  @override
  final String detail;
  @override
  final String attr;

  @override
  String toString() {
    return 'ApiErrorDetail(code: $code, detail: $detail, attr: $attr)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorDetailImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.attr, attr) || other.attr == attr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, detail, attr);

  /// Create a copy of ApiErrorDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorDetailImplCopyWith<_$ApiErrorDetailImpl> get copyWith =>
      __$$ApiErrorDetailImplCopyWithImpl<_$ApiErrorDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorDetailImplToJson(
      this,
    );
  }
}

abstract class _ApiErrorDetail implements ApiErrorDetail {
  factory _ApiErrorDetail(
      {required final String code,
      required final String detail,
      required final String attr}) = _$ApiErrorDetailImpl;

  factory _ApiErrorDetail.fromJson(Map<String, dynamic> json) =
      _$ApiErrorDetailImpl.fromJson;

  @override
  String get code;
  @override
  String get detail;
  @override
  String get attr;

  /// Create a copy of ApiErrorDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiErrorDetailImplCopyWith<_$ApiErrorDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
