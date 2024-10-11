import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import 'api_client.dart';
import 'api_endpoint.dart';
import 'api_error.dart';
import 'log_interceptor.dart';

class DioApiClient implements ApiClient {
  final Dio _dio;

  DioApiClient({
    required Dio dio,
  }) : _dio = dio {
    _dio.interceptors.add(CustomLogInterceptor());
  }

  @override
  Future<Either<ApiError, T>> request<T>(ApiEndpoint endpoint) async {
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

      return Right(await endpoint.handleResponse(response));
    } on DioException catch (e) {
      return Left(ApiError.fromJson(e.response?.data));
    }
  }
}
