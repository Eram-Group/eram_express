import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../entities/customer_entity.dart';
import '../objects/update_customer_form_data.dart';

abstract class CustomerRepository {
  Future<CustomerEntity?> getAuthenticatedCustomer();

  Future<Either<ApiError, CustomerEntity>> updateProfile(
      UpdateCustomerFormData data);
}
