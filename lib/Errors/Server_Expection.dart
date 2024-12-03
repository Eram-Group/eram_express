class ServerException implements Exception 
{
  final String type;
  final List<ApiErrorDetail> errors;

  ServerException({
    required this.type,
    required this.errors,
  });

  factory ServerException.fromJson(Map<String, dynamic> json) {
    return ServerException(
      type: json['type'] as String,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => ApiErrorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

}

class ApiErrorDetail {
  final String code;
  final String detail;
  final String attr;

  ApiErrorDetail({
    required this.code,
    required this.detail,
    required this.attr,
  });

  factory ApiErrorDetail.fromJson(Map<String, dynamic> json) {
    return ApiErrorDetail(
      code: json['code'] as String,
      detail: json['detail'] as String,
      attr: json['attr'] as String,
    );
  }

 
}
