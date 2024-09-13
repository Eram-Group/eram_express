import 'package:dio/dio.dart';

class ApiEndpoint {
  final String uri;
  final ApiMethod method;

  ApiEndpoint({
    required this.uri,
    required this.method,
  });

  CallableApiEndpoint prepare(ApiEndpointInput? input) {
    return CallableApiEndpoint(
      uri: uri,
      method: method,
      input: input,
    );
  }
}

class ApiEndpointInput {
  late final Map<String, dynamic>? queryParameters;
  late final Map<String, String>? headers;

  /// Must have a `toJson` method
  late final dynamic data;

  ApiEndpointInput.multipart({
    this.queryParameters,
    EndpointRequest? data,
    String? auth,
  }) {
    headers = {
      'Content-Type': 'multipart/form-data',
      if (auth != null) 'Authorization': 'Bearer $auth',
    };
    this.data = data == null ? null : FormData.fromMap(data.toJson());
  }

  ApiEndpointInput.rawJson({
    this.queryParameters,
    EndpointRequest? data,
    String? auth,
  }) {
    headers = {
      'Content-Type': 'application/json',
      if (auth != null) 'Authorization': 'Bearer $auth',
    };
    this.data = data?.toJson();
  }
}

enum ApiMethod { get, post, patch, put, delete }

class CallableApiEndpoint {
  final String uri;
  final ApiMethod method;
  final ApiEndpointInput? input;

  CallableApiEndpoint({
    required this.uri,
    required this.method,
    this.input,
  });
}

abstract class EndpointRequest {
  Map<String, dynamic> toJson();
}
