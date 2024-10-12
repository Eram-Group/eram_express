// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifyOtpResponseModelImpl _$$VerifyOtpResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyOtpResponseModelImpl(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VerifyOtpResponseModelImplToJson(
        _$VerifyOtpResponseModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'customer': instance.customer,
    };
