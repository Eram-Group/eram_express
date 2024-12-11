import 'package:eram_express/features/customer/data/models/customer_model.dart';
import '../objects/update_customer_form_data.dart';
import 'customer_repository.dart';
import '../data_sources/remote/customer_remote_data_source.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource _customerRemoteDataSource;
 

  CustomerRepositoryImpl({
    required CustomerRemoteDataSource remoteDataSource,
   
  })  : _customerRemoteDataSource = remoteDataSource;
     
  @override
  Future<CustomerModel?> getAuthenticatedCustomer() async {

    final response =
 await _customerRemoteDataSource.getAuthenticatedCustomer();
    return response;
  }

  @override
  Future<CustomerModel> updateProfile(UpdateCustomerFormData data) async {
   
    final updatedCustomer =
        await _customerRemoteDataSource.updateProfile(data);
    return updatedCustomer;
  }
}
