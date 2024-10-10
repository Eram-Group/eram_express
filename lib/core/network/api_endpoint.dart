import 'dart:async';

import 'package:dio/dio.dart';

enum HttpMethod { get, post, put, delete, patch }

class ApiEndpoint<T> {
  final String path;
  final HttpMethod method;
  final Map<int, FutureOr<T> Function(Response)> responseHandlers;

  late final Map<String, dynamic>? _queryParameters;
  late final dynamic _body;
  late final Map<String, String>? _headers;

  Map<String, dynamic>? get queryParameters => _queryParameters;
  dynamic get body => _body;
  Map<String, String>? get headers => _headers;

  FutureOr<T> handleResponse(Response response) async {
    final handler = responseHandlers[response.statusCode];
    if (handler != null) {
      final result = await handler(response);
      return result;
    } else {
      // Handle other status codes
      throw Exception('Unhandled status code: ${response.statusCode}');
    }
  }

  ApiEndpoint<T> prepare({
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, String>? headers,
  }) {
    _queryParameters = queryParameters;
    _body = body;
    _headers = headers;
    return this;
  }

  ApiEndpoint({
    required this.path,
    required this.method,
    this.responseHandlers = const {},
  });
}
