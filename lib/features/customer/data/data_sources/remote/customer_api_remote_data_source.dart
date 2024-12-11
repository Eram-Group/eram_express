
import 'package:dio/dio.dart';
import 'package:eram_express/features/customer/data/objects/update_customer_form_data.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import '../../../../../app/api_keys.dart';
import '../../models/customer_model.dart';
import 'customer_remote_data_source.dart';
class CustomerApiRemoteDataSource implements CustomerRemoteDataSource {
  final NetworkService _networkService;

  CustomerApiRemoteDataSource({required NetworkService networkService})
      : _networkService = networkService; 

  @override
  Future<CustomerModel> getAuthenticatedCustomer(String accessToken) async {
    final response = await _networkService.get(
      '$baseUrl/customer/me/',
     
    );
    return CustomerModel.fromMap(response.data);
  }

  @override
  Future<CustomerModel> updateProfile(
    UpdateCustomerFormData data,
    String accessToken,
  ) async {
    final formData = FormData.fromMap({
      'full_name': data.fullName,
      if (data.profilePicture != null)
        'image': MultipartFile.fromFileSync(data.profilePicture!.path),
    });

    final response = await _networkService.patch(
      '$baseUrl/customer/me/',
      data: formData,
    );
    return CustomerModel.fromMap(response.data);
  }
}
