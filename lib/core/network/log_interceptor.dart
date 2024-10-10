import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/logger.dart';

class CustomLogInterceptor extends Interceptor {
  final String tag;
  CustomLogInterceptor({this.tag = ''});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.network(
      '$tag '
      'Error ${err.response?.statusCode} ${err.response?.statusMessage}\n\n'
      '${err.requestOptions.method} ${err.requestOptions.uri}\n\n'
      '${const JsonEncoder.withIndent('  ').convert(err.response?.data)}',
    );
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.network(
      '$tag '
      '${options.method} ${options.uri}\n'
      '${options.headers}\n'
      '${options.data}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.network(
      '$tag '
      'Response ${response.statusCode} ${response.statusMessage}\n\n'
      '${response.requestOptions.method} ${response.requestOptions.uri}\n\n'
      '${response.data.toString().length < 1000 ? const JsonEncoder.withIndent('  ').convert(response.data) : 'Data too large to display'}',
    );
    super.onResponse(response, handler);
  }
}
