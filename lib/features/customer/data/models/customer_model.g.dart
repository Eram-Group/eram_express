// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerModelImpl _$$CustomerModelImplFromJson(Map<String, dynamic> json) =>
    _$CustomerModelImpl(
      id: (json['id'] as num).toInt(),
      phoneNumber: json['phone_number'] as String,
      fullName: json['full_name'] as String,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool,
      country: CountryModel.fromJson(json['country'] as Map<String, dynamic>),
      wallet: WalletModel.fromJson(json['wallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CustomerModelImplToJson(_$CustomerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone_number': instance.phoneNumber,
      'full_name': instance.fullName,
      'image': instance.image,
      'is_active': instance.isActive,
      'country': instance.country,
      'wallet': instance.wallet,
    };
