import 'package:either_dart/either.dart';

import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../../home/presentation/objects/booking_request_form_data.dart';
import '../../objects/update_customer_form_data.dart';

import '../../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<Either<ApiError, CustomerModel>> getAuthenticatedCustomer(
      String accessToken);

  Future<Either<ApiError, CustomerModel>> updateProfile(
      UpdateCustomerFormData data, String accessToken);

}
