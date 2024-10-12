// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletEntity {
  String get balance => throw _privateConstructorUsedError;
  String get balanceCurrency => throw _privateConstructorUsedError;
  bool get isUseWalletInPayment => throw _privateConstructorUsedError;

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletEntityCopyWith<WalletEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletEntityCopyWith<$Res> {
  factory $WalletEntityCopyWith(
          WalletEntity value, $Res Function(WalletEntity) then) =
      _$WalletEntityCopyWithImpl<$Res, WalletEntity>;
  @useResult
  $Res call(
      {String balance, String balanceCurrency, bool isUseWalletInPayment});
}

/// @nodoc
class _$WalletEntityCopyWithImpl<$Res, $Val extends WalletEntity>
    implements $WalletEntityCopyWith<$Res> {
  _$WalletEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? balanceCurrency = null,
    Object? isUseWalletInPayment = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      balanceCurrency: null == balanceCurrency
          ? _value.balanceCurrency
          : balanceCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      isUseWalletInPayment: null == isUseWalletInPayment
          ? _value.isUseWalletInPayment
          : isUseWalletInPayment // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletEntityImplCopyWith<$Res>
    implements $WalletEntityCopyWith<$Res> {
  factory _$$WalletEntityImplCopyWith(
          _$WalletEntityImpl value, $Res Function(_$WalletEntityImpl) then) =
      __$$WalletEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String balance, String balanceCurrency, bool isUseWalletInPayment});
}

/// @nodoc
class __$$WalletEntityImplCopyWithImpl<$Res>
    extends _$WalletEntityCopyWithImpl<$Res, _$WalletEntityImpl>
    implements _$$WalletEntityImplCopyWith<$Res> {
  __$$WalletEntityImplCopyWithImpl(
      _$WalletEntityImpl _value, $Res Function(_$WalletEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? balanceCurrency = null,
    Object? isUseWalletInPayment = null,
  }) {
    return _then(_$WalletEntityImpl(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      balanceCurrency: null == balanceCurrency
          ? _value.balanceCurrency
          : balanceCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      isUseWalletInPayment: null == isUseWalletInPayment
          ? _value.isUseWalletInPayment
          : isUseWalletInPayment // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$WalletEntityImpl extends _WalletEntity {
  _$WalletEntityImpl(
      {required this.balance,
      required this.balanceCurrency,
      required this.isUseWalletInPayment})
      : super._();

  @override
  final String balance;
  @override
  final String balanceCurrency;
  @override
  final bool isUseWalletInPayment;

  @override
  String toString() {
    return 'WalletEntity(balance: $balance, balanceCurrency: $balanceCurrency, isUseWalletInPayment: $isUseWalletInPayment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletEntityImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.balanceCurrency, balanceCurrency) ||
                other.balanceCurrency == balanceCurrency) &&
            (identical(other.isUseWalletInPayment, isUseWalletInPayment) ||
                other.isUseWalletInPayment == isUseWalletInPayment));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, balance, balanceCurrency, isUseWalletInPayment);

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletEntityImplCopyWith<_$WalletEntityImpl> get copyWith =>
      __$$WalletEntityImplCopyWithImpl<_$WalletEntityImpl>(this, _$identity);
}

abstract class _WalletEntity extends WalletEntity {
  factory _WalletEntity(
      {required final String balance,
      required final String balanceCurrency,
      required final bool isUseWalletInPayment}) = _$WalletEntityImpl;
  _WalletEntity._() : super._();

  @override
  String get balance;
  @override
  String get balanceCurrency;
  @override
  bool get isUseWalletInPayment;

  /// Create a copy of WalletEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletEntityImplCopyWith<_$WalletEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
