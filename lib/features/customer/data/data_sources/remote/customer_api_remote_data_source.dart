import 'package:either_dart/either.dart';
import 'package:eram_express/core/network/api_error.dart';

import '../../../../../core/network/dio_api_client.dart';
import '../../models/customer_model.dart';
import 'customer_api_endpoints.dart';
import 'customer_remote_data_source.dart';

class CustomerApiRemoteDataSource implements CustomerRemoteDataSource {
  final DioApiClient _dioClient;

  CustomerApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<Either<ApiError, CustomerModel>> getAuthenticatedCustomer(
    String accessToken,
  ) async {
    return await _dioClient.request(
      getAuthenticatedCustomerEndpoint.prepare(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
  }
}