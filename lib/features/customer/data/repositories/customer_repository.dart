import 'package:either_dart/either.dart';
import 'package:eram_express/features/customer/data/models/customer_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import '../objects/update_customer_form_data.dart';

abstract class CustomerRepository {
  Future<CustomerModel?> getAuthenticatedCustomer();

  Future<Either<ApiError, CustomerModel>> updateProfile(
      UpdateCustomerFormData data);

 
  
}

