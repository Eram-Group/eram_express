// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletModelImpl _$$WalletModelImplFromJson(Map<String, dynamic> json) =>
    _$WalletModelImpl(
      balance: json['balance'] as String,
      balanceCurrency: json['balance_currency'] as String,
      isUseWalletInPayment: json['is_use_wallet_in_payment'] as bool,
    );

Map<String, dynamic> _$$WalletModelImplToJson(_$WalletModelImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'balance_currency': instance.balanceCurrency,
      'is_use_wallet_in_payment': instance.isUseWalletInPayment,
    };
