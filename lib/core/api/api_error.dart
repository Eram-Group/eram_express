import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
abstract class ApiError with _$ApiError {
  factory ApiError({
    required String type,
    required List<ApiErrorDetail> errors,
  }) = _ApiError;
  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

@freezed
abstract class ApiErrorDetail with _$ApiErrorDetail {
  factory ApiErrorDetail({
    required String code,
    required String detail,
    required String attr,
  }) = _ApiErrorDetail;
  factory ApiErrorDetail.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDetailFromJson(json);
}
