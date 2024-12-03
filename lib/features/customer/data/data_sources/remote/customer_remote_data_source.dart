
import '../../objects/update_customer_form_data.dart';
import '../../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<CustomerModel> getAuthenticatedCustomer(
      String accessToken);

  Future<CustomerModel> updateProfile(
      UpdateCustomerFormData data, String accessToken);
}
