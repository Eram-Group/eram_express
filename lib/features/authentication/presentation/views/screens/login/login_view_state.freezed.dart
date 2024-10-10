// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginViewState {
  bool get loading => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  CountryEntity? get selectedCountry => throw _privateConstructorUsedError;
  List<CountryEntity>? get countries => throw _privateConstructorUsedError;

  /// Create a copy of LoginViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginViewStateCopyWith<LoginViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginViewStateCopyWith<$Res> {
  factory $LoginViewStateCopyWith(
          LoginViewState value, $Res Function(LoginViewState) then) =
      _$LoginViewStateCopyWithImpl<$Res, LoginViewState>;
  @useResult
  $Res call(
      {bool loading,
      String phoneNumber,
      CountryEntity? selectedCountry,
      List<CountryEntity>? countries});
}

/// @nodoc
class _$LoginViewStateCopyWithImpl<$Res, $Val extends LoginViewState>
    implements $LoginViewStateCopyWith<$Res> {
  _$LoginViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? phoneNumber = null,
    Object? selectedCountry = freezed,
    Object? countries = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCountry: freezed == selectedCountry
          ? _value.selectedCountry
          : selectedCountry // ignore: cast_nullable_to_non_nullable
              as CountryEntity?,
      countries: freezed == countries
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<CountryEntity>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginViewStateImplCopyWith<$Res>
    implements $LoginViewStateCopyWith<$Res> {
  factory _$$LoginViewStateImplCopyWith(_$LoginViewStateImpl value,
          $Res Function(_$LoginViewStateImpl) then) =
      __$$LoginViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      String phoneNumber,
      CountryEntity? selectedCountry,
      List<CountryEntity>? countries});
}

/// @nodoc
class __$$LoginViewStateImplCopyWithImpl<$Res>
    extends _$LoginViewStateCopyWithImpl<$Res, _$LoginViewStateImpl>
    implements _$$LoginViewStateImplCopyWith<$Res> {
  __$$LoginViewStateImplCopyWithImpl(
      _$LoginViewStateImpl _value, $Res Function(_$LoginViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? phoneNumber = null,
    Object? selectedCountry = freezed,
    Object? countries = freezed,
  }) {
    return _then(_$LoginViewStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      selectedCountry: freezed == selectedCountry
          ? _value.selectedCountry
          : selectedCountry // ignore: cast_nullable_to_non_nullable
              as CountryEntity?,
      countries: freezed == countries
          ? _value._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<CountryEntity>?,
    ));
  }
}

/// @nodoc

class _$LoginViewStateImpl extends _LoginViewState {
  _$LoginViewStateImpl(
      {this.loading = false,
      this.phoneNumber = '',
      this.selectedCountry,
      final List<CountryEntity>? countries})
      : _countries = countries,
        super._();

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  final CountryEntity? selectedCountry;
  final List<CountryEntity>? _countries;
  @override
  List<CountryEntity>? get countries {
    final value = _countries;
    if (value == null) return null;
    if (_countries is EqualUnmodifiableListView) return _countries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LoginViewState(loading: $loading, phoneNumber: $phoneNumber, selectedCountry: $selectedCountry, countries: $countries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginViewStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.selectedCountry, selectedCountry) ||
                other.selectedCountry == selectedCountry) &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading, phoneNumber,
      selectedCountry, const DeepCollectionEquality().hash(_countries));

  /// Create a copy of LoginViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginViewStateImplCopyWith<_$LoginViewStateImpl> get copyWith =>
      __$$LoginViewStateImplCopyWithImpl<_$LoginViewStateImpl>(
          this, _$identity);
}

abstract class _LoginViewState extends LoginViewState {
  factory _LoginViewState(
      {final bool loading,
      final String phoneNumber,
      final CountryEntity? selectedCountry,
      final List<CountryEntity>? countries}) = _$LoginViewStateImpl;
  _LoginViewState._() : super._();

  @override
  bool get loading;
  @override
  String get phoneNumber;
  @override
  CountryEntity? get selectedCountry;
  @override
  List<CountryEntity>? get countries;

  /// Create a copy of LoginViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginViewStateImplCopyWith<_$LoginViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
