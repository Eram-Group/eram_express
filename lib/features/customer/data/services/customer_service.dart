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

  Future<CustomerModel> updateProfile(
      {required UpdateCustomerFormData data}) async {
    final response = await _customerRepository.updateProfile(data);
    return response;
  }
}
