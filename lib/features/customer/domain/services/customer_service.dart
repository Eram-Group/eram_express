import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../authentication/domain/repositories/authentication_repository.dart';
import '../entities/customer_entity.dart';
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

  Future<Either<ApiError, CustomerEntity>> updateProfile(
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
