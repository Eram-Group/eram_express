
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:eram_express/features/customer/data/objects/update_customer_form_data.dart';
import 'package:eram_express/features/home/presentation/objects/booking_request_form_data.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';


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
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
      ),
    );
  }

  @override
  Future<Either<ApiError, CustomerModel>> updateProfile(
    UpdateCustomerFormData data,
    String accessToken,
  ) async {
    return await _dioClient.request(
      updateProfileEndpoint.prepare(
        body: FormData.fromMap({
          'full_name': data.fullName,
          if (data.profilePicture != null)
            'image': MultipartFile.fromFileSync(data.profilePicture!.path),
        }),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
        },
      ),
    );
  }


}
