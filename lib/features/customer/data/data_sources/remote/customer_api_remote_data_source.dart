import 'package:dio/dio.dart';
import 'package:eram_express/features/customer/data/objects/update_customer_form_data.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import '../../../../../app/api_keys.dart';
import '../../models/customer_model.dart';
import 'customer_remote_data_source.dart';

class CustomerApiRemoteDataSource implements CustomerRemoteDataSource {
  final NetworkService _networkService;

  CustomerApiRemoteDataSource({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<CustomerModel> getAuthenticatedCustomer() async {
    logger.debug("enter to get auth");
    final response = await _networkService.get(
      '$baseUrl/customer/me/',
    );
    logger.debug("print${response.data}");
    return CustomerModel.fromMap(response.data);
  }

  @override
  Future<CustomerModel> updateProfile(
    UpdateCustomerFormData data,
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
