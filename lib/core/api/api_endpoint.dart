import 'dart:async';

import 'package:dio/dio.dart';

enum HttpMethod { get, post, put, delete, patch }

class ApiEndpoint {
  final String path;
  final HttpMethod method;
  final Map<int, FutureOr Function(Response)> responseHandlers;

  final Map<String, dynamic>? _queryParameters;
  final dynamic _body;
  final Map<String, String>? _headers;

  Map<String, dynamic>? get queryParameters => _queryParameters;
  dynamic get body => _body;
  Map<String, String>? get headers => _headers;

  FutureOr handleResponse(Response response) async {
    final handler = responseHandlers[response.statusCode];
    if (handler != null) {
      final result = await handler(response);
      return result;
    } else {
      // Handle other status codes
      throw Exception('Unhandled status code: ${response.statusCode}');
    }
  }

  ApiEndpoint prepare({
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
  }) {
    return ApiEndpoint(
      path: path,
      method: method,
      responseHandlers: responseHandlers,
      queryParameters: queryParameters,
      body: body,
      headers: headers,
    );
  }

  ApiEndpoint({
    required this.path,
    required this.method,
    this.responseHandlers = const {},
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
  })  : _queryParameters = queryParameters,
        _body = body,
        _headers = headers;
}
