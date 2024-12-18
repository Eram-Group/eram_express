import 'package:eram_express/features/authentication/data/models/verify_otp_response_model.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';

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
      OtpVerificationData data, String tokenDevice) async {
    final response = await _networkService.post(
      '$baseUrl/customer/authenticate/',
      data: {
        'phone_number': data.phoneNumber,
        'otp': data.otp,
        'device': {
          'registration_id':
              "dO-IKM7eQ2yJ2xMDe6YpSI:APA91bF9P0EyF_3DjbZsxi3RlZszM5UWVdCI59GPhI8A2HoRV72ZLkul1Svi2Sd_nr5dHnnVfNtRDL-UeYCr0c73JDedz24dT37A31xVg86xoLz_jb75aZkOvjDS6uQIZNCUtvgn_WSi",
          'device_id':
              "dO-IKM7eQ2yJ2xMDe6YpSI:APA91bF9P0EyF_3DjbZsxi3RlZszM5UWVdCI59GPhI8A2HoRV72ZLkul1Svi2Sd_nr5dHnnVfNtRDL-UeYCr0c73JDedz24dT37A31xVg86xoLz_jb75aZkOvjDS6uQIZNCUtvgn_WSi",
          'type': 'android',
        },
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
    } else {
      // هي متحلتش غير لما عملت كده  فازاي ومفروض اني مهندله في الى
      //networkservice

      throw ServerException.fromMap(response.data);
    }
  }
}
