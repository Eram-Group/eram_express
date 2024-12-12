import '../models/customer_model.dart';
import '../objects/update_customer_form_data.dart';

abstract class CustomerRepository {
  Future<CustomerModel?> getAuthenticatedCustomer();

  Future<CustomerModel> updateProfile(UpdateCustomerFormData data);
}
