import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../authentication/data/respositories/authentication_repository.dart';

import '../models/customer_model.dart';
import '../objects/update_customer_form_data.dart';
import '../repositories/customer_repository.dart';

class CustomerService {
  final CustomerRepository _customerRepository;
  final AuthenticationRepository _authenticationRepository;

  CustomerService({
    required CustomerRepository customerRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _customerRepository = customerRepository,
        _authenticationRepository = authenticationRepository;

  Future<Either<ApiError, CustomerModel>> updateProfile(
    {
    required UpdateCustomerFormData data,
  }) async {
    final response = await _customerRepository.updateProfile(data);
    response.fold(
      (error) => null,
      (data) => _authenticationRepository.updateAuthenticatedCustomer(data),
    );
    return response;
  }
}
