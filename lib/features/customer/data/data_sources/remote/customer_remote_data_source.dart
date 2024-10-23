import 'package:either_dart/either.dart';
<<<<<<< HEAD

import '../../../../../core/api/api_error.dart';
=======
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../domain/objects/update_customer_form_data.dart';
>>>>>>> ac9b3dfcd0ce0ee82fdedbbf6d9ba9892ea0b09c
import '../../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<Either<ApiError, CustomerModel>> getAuthenticatedCustomer(
      String accessToken);

  Future<Either<ApiError, CustomerModel>> updateProfile(
      UpdateCustomerFormData data, String accessToken);
}
