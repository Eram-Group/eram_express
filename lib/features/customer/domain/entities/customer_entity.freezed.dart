// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomerEntity {
  int get id => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  CountryEntity get country => throw _privateConstructorUsedError;
  WalletEntity get wallet => throw _privateConstructorUsedError;

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerEntityCopyWith<CustomerEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerEntityCopyWith<$Res> {
  factory $CustomerEntityCopyWith(
          CustomerEntity value, $Res Function(CustomerEntity) then) =
      _$CustomerEntityCopyWithImpl<$Res, CustomerEntity>;
  @useResult
  $Res call(
      {int id,
      String phoneNumber,
      String fullName,
      String? image,
      bool isActive,
      CountryEntity country,
      WalletEntity wallet});

  $CountryEntityCopyWith<$Res> get country;
  $WalletEntityCopyWith<$Res> get wallet;
}

/// @nodoc
class _$CustomerEntityCopyWithImpl<$Res, $Val extends CustomerEntity>
    implements $CustomerEntityCopyWith<$Res> {
  _$CustomerEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? fullName = null,
    Object? image = freezed,
    Object? isActive = null,
    Object? country = null,
    Object? wallet = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as CountryEntity,
      wallet: null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as WalletEntity,
    ) as $Val);
  }

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CountryEntityCopyWith<$Res> get country {
    return $CountryEntityCopyWith<$Res>(_value.country, (value) {
      return _then(_value.copyWith(country: value) as $Val);
    });
  }

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletEntityCopyWith<$Res> get wallet {
    return $WalletEntityCopyWith<$Res>(_value.wallet, (value) {
      return _then(_value.copyWith(wallet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerEntityImplCopyWith<$Res>
    implements $CustomerEntityCopyWith<$Res> {
  factory _$$CustomerEntityImplCopyWith(_$CustomerEntityImpl value,
          $Res Function(_$CustomerEntityImpl) then) =
      __$$CustomerEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String phoneNumber,
      String fullName,
      String? image,
      bool isActive,
      CountryEntity country,
      WalletEntity wallet});

  @override
  $CountryEntityCopyWith<$Res> get country;
  @override
  $WalletEntityCopyWith<$Res> get wallet;
}

/// @nodoc
class __$$CustomerEntityImplCopyWithImpl<$Res>
    extends _$CustomerEntityCopyWithImpl<$Res, _$CustomerEntityImpl>
    implements _$$CustomerEntityImplCopyWith<$Res> {
  __$$CustomerEntityImplCopyWithImpl(
      _$CustomerEntityImpl _value, $Res Function(_$CustomerEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? fullName = null,
    Object? image = freezed,
    Object? isActive = null,
    Object? country = null,
    Object? wallet = null,
  }) {
    return _then(_$CustomerEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as CountryEntity,
      wallet: null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as WalletEntity,
    ));
  }
}

/// @nodoc

class _$CustomerEntityImpl extends _CustomerEntity {
  _$CustomerEntityImpl(
      {required this.id,
      required this.phoneNumber,
      required this.fullName,
      required this.image,
      required this.isActive,
      required this.country,
      required this.wallet})
      : super._();

  @override
  final int id;
  @override
  final String phoneNumber;
  @override
  final String fullName;
  @override
  final String? image;
  @override
  final bool isActive;
  @override
  final CountryEntity country;
  @override
  final WalletEntity wallet;

  @override
  String toString() {
    return 'CustomerEntity(id: $id, phoneNumber: $phoneNumber, fullName: $fullName, image: $image, isActive: $isActive, country: $country, wallet: $wallet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.wallet, wallet) || other.wallet == wallet));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, phoneNumber, fullName, image, isActive, country, wallet);

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerEntityImplCopyWith<_$CustomerEntityImpl> get copyWith =>
      __$$CustomerEntityImplCopyWithImpl<_$CustomerEntityImpl>(
          this, _$identity);
}

abstract class _CustomerEntity extends CustomerEntity {
  factory _CustomerEntity(
      {required final int id,
      required final String phoneNumber,
      required final String fullName,
      required final String? image,
      required final bool isActive,
      required final CountryEntity country,
      required final WalletEntity wallet}) = _$CustomerEntityImpl;
  _CustomerEntity._() : super._();

  @override
  int get id;
  @override
  String get phoneNumber;
  @override
  String get fullName;
  @override
  String? get image;
  @override
  bool get isActive;
  @override
  CountryEntity get country;
  @override
  WalletEntity get wallet;

  /// Create a copy of CustomerEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerEntityImplCopyWith<_$CustomerEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
