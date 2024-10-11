// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiErrorImpl _$$ApiErrorImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorImpl(
      type: json['type'] as String,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => ApiErrorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ApiErrorImplToJson(_$ApiErrorImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'errors': instance.errors,
    };

_$ApiErrorDetailImpl _$$ApiErrorDetailImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorDetailImpl(
      code: json['code'] as String,
      detail: json['detail'] as String,
      attr: json['attr'] as String,
    );

Map<String, dynamic> _$$ApiErrorDetailImplToJson(
        _$ApiErrorDetailImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'detail': instance.detail,
      'attr': instance.attr,
    };
