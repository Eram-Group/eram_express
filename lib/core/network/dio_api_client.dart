import 'package:dio/dio.dart';
import 'package:eram_express/core/network/api_client.dart';
import 'package:eram_express/core/network/api_endpoint.dart';

import 'log_interceptor.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient({
    required Dio dio,
  }) : _dio = dio {
    _dio.interceptors.add(
      CustomLogInterceptor(),
    );
  }

  @override
  Future request(ApiEndpoint endpoint) async {
    try {
      final response = await _dio.request(
        endpoint.path,
        data: endpoint.body,
        queryParameters: endpoint.queryParameters,
        options: Options(
          method: endpoint.method.name,
          headers: endpoint.headers,
        ),
      );

      return await endpoint.handleResponse(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
