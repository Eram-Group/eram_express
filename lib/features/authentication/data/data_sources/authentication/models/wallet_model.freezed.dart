// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) {
  return _WalletModel.fromJson(json);
}

/// @nodoc
mixin _$WalletModel {
  String get balance => throw _privateConstructorUsedError;
  String get balanceCurrency => throw _privateConstructorUsedError;
  bool get isUseWalletInPayment => throw _privateConstructorUsedError;

  /// Serializes this WalletModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletModelCopyWith<WalletModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletModelCopyWith<$Res> {
  factory $WalletModelCopyWith(
          WalletModel value, $Res Function(WalletModel) then) =
      _$WalletModelCopyWithImpl<$Res, WalletModel>;
  @useResult
  $Res call(
      {String balance, String balanceCurrency, bool isUseWalletInPayment});
}

/// @nodoc
class _$WalletModelCopyWithImpl<$Res, $Val extends WalletModel>
    implements $WalletModelCopyWith<$Res> {
  _$WalletModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletModel
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
abstract class _$$WalletModelImplCopyWith<$Res>
    implements $WalletModelCopyWith<$Res> {
  factory _$$WalletModelImplCopyWith(
          _$WalletModelImpl value, $Res Function(_$WalletModelImpl) then) =
      __$$WalletModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String balance, String balanceCurrency, bool isUseWalletInPayment});
}

/// @nodoc
class __$$WalletModelImplCopyWithImpl<$Res>
    extends _$WalletModelCopyWithImpl<$Res, _$WalletModelImpl>
    implements _$$WalletModelImplCopyWith<$Res> {
  __$$WalletModelImplCopyWithImpl(
      _$WalletModelImpl _value, $Res Function(_$WalletModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? balanceCurrency = null,
    Object? isUseWalletInPayment = null,
  }) {
    return _then(_$WalletModelImpl(
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

@JsonSerializable(fieldRename: FieldRename.snake)
class _$WalletModelImpl implements _WalletModel {
  _$WalletModelImpl(
      {required this.balance,
      required this.balanceCurrency,
      required this.isUseWalletInPayment});

  factory _$WalletModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletModelImplFromJson(json);

  @override
  final String balance;
  @override
  final String balanceCurrency;
  @override
  final bool isUseWalletInPayment;

  @override
  String toString() {
    return 'WalletModel(balance: $balance, balanceCurrency: $balanceCurrency, isUseWalletInPayment: $isUseWalletInPayment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletModelImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.balanceCurrency, balanceCurrency) ||
                other.balanceCurrency == balanceCurrency) &&
            (identical(other.isUseWalletInPayment, isUseWalletInPayment) ||
                other.isUseWalletInPayment == isUseWalletInPayment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, balance, balanceCurrency, isUseWalletInPayment);

  /// Create a copy of WalletModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletModelImplCopyWith<_$WalletModelImpl> get copyWith =>
      __$$WalletModelImplCopyWithImpl<_$WalletModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletModelImplToJson(
      this,
    );
  }
}

abstract class _WalletModel implements WalletModel {
  factory _WalletModel(
      {required final String balance,
      required final String balanceCurrency,
      required final bool isUseWalletInPayment}) = _$WalletModelImpl;

  factory _WalletModel.fromJson(Map<String, dynamic> json) =
      _$WalletModelImpl.fromJson;

  @override
  String get balance;
  @override
  String get balanceCurrency;
  @override
  bool get isUseWalletInPayment;

  /// Create a copy of WalletModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletModelImplCopyWith<_$WalletModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
