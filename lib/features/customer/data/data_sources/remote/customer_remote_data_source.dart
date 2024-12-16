import '../../objects/update_customer_form_data.dart';
import '../../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<CustomerModel> getAuthenticatedCustomer();

  Future<CustomerModel> updateProfile(
      UpdateCustomerFormData data,);
}
