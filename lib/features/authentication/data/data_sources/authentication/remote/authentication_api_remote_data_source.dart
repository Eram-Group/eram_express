import 'package:eram_express/features/authentication/data/models/verify_otp_response_model.dart';
import 'package:eram_express_shared/core/api/network-service.dart';

import '../../../../../../app/api_keys.dart';
import '../../../../presentation/objects/otp_verification_data.dart';
import '../../../../presentation/objects/verify_otp_response_wrapper.dart';
import 'authentication_remote_data_source.dart';

class AuthenticationApiRemoteDataSource
    implements AuthenticationRemoteDataSource {
  final NetworkService _networkService;

  AuthenticationApiRemoteDataSource({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<void> sendOtp(String phoneNumber) async {
    final response = await _networkService.post(
      '$baseUrl/user/send-otp/',
      data: {'phone_number': phoneNumber},
    );
  }

  @override
  Future<VerifyOtpResponseWrapper<VerifyOtpResponseModel>> verifyOtp(
      OtpVerificationData data) async {
    final response = await _networkService.post(
      '$baseUrl/customer/authenticate/',
      data: {
        'phone_number': data.phoneNumber,
        'otp': data.otp,
      },
    );
    if (response.statusCode == 200) {
      return VerifyOtpResponseWrapper(
        isNewCustomer: false,
        response: VerifyOtpResponseModel.fromMap(response.data),
      );
    } else if (response.statusCode == 201) {
      return VerifyOtpResponseWrapper(
        isNewCustomer: true,
        response: VerifyOtpResponseModel.fromMap(response.data),
      );
    }
    return response.data;
  }
}
