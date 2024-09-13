import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import 'api_endpiont.dart';
import 'api_response.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

  Future<Either<ApiResponse<String>, ApiResponse<T>>> request<T>(
    CallableApiEndpoint endpoint, {
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.request(
        endpoint.uri,
        queryParameters: endpoint.input?.queryParameters,
        data: endpoint.input?.data,
        options: Options(
          method: endpoint.method.toString().split('.').last,
          headers: endpoint.input?.headers,
        ),
        cancelToken: cancelToken,
      );
      return Right(
        ApiResponse.success(
          response.statusCode ?? 200,
          response.data,
        ),
      );
    } on DioException catch (e) {
      return Left(
        ApiResponse.failure(
          e.response?.statusCode,
          e.response?.data.toString() ?? e.message,
        ),
      );
    } catch (e) {
      return Left(ApiResponse.failure(null, e.toString()));
    }
  }
}
