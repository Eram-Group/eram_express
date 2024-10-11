import '../entities/customer_entity.dart';

abstract class CustomerRepository {
  Future<CustomerEntity?> getAuthenticatedCustomer(
      {required String accessToken});
}
