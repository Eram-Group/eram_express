import 'package:eram_express/features/authentication/data/models/verify_otp_response_model.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/data/configurations/models/device_details_model.dart';
import 'package:eram_express_shared/notification_service.dart';
import 'package:eram_express_shared/tokens/local/tokens_local_data_source.dart';
import '../../../../../../app/api_keys.dart';
import '../../../../presentation/objects/otp_verification_data.dart';
import '../../../../presentation/objects/verify_otp_response_wrapper.dart';
import 'authentication_remote_data_source.dart';

class AuthenticationApiRemoteDataSource
    implements AuthenticationRemoteDataSource {
  final NetworkService _networkService;
  final NotificationService _notificationService;
  final TokensLocalDataSource _tokensDataSource;
  AuthenticationApiRemoteDataSource(
      {required NetworkService networkService,
      required NotificationService notificationService,
      required TokensLocalDataSource tokensDataSource})
      : _networkService = networkService,
        _notificationService = notificationService,
        _tokensDataSource = tokensDataSource;

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
    /*
    final DeviceDetailsModel deviceDetails =
        await _notificationService.getDeviceDetails();
    logger.debug(deviceDetails.deviceId.toString());
    logger.debug(deviceDetails.registrationId.toString());
    logger.debug(deviceDetails.deviceType.toString());
    */
    final response = await _networkService.post(
      '$baseUrl/customer/authenticate/',
      data: {
        'phone_number': data.phoneNumber,
        'otp': data.otp,
        /*
         "device": {
          "registration_id":deviceDetails.registrationId,
          "device_id":deviceDetails.deviceId,
          "type": deviceDetails.deviceType,
        }
        */
        "device": {
          "registration_id":
              "dO-IKM7eQ2yJ2xMDe6YpSI:APA91bF9P0EyF_3DjbZsxi3RlZszM5UWVdCI59GPhI8A2HoRV72ZLkul1Svi2Sd_nr5dHnnVfNtRDL-UeYCr0c73JDedz24dT37A31xVg86xoLz_jb75aZkOvjDS6uQIZNCUtvgn_WSi",
          "device_id":
              "dO-IKM7eQ2yJ2xMDe6YpSI:APA91bF9P0EyF_3DjbZsxi3RlZszM5UWVdCI59GPhI8A2HoRV72ZLkul1Svi2Sd_nr5dHnnVfNtRDL-UeYCr0c73JDedz24dT37A31xVg86xoLz_jb75aZkOvjDS6uQIZNCUtvgn_WSi",
          "type": "android"
        }
      },
    );

    if (response.statusCode == 200) {
      return VerifyOtpResponseWrapper(
        isNewCustomer: false, //  TODo convert it to false
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

  @override
  Future<void> logOut() async {
    final refreshToken = await _tokensDataSource.refreshToken;
    await _networkService.post(
      '$baseUrl/user/logout/',
      data: {
        'refresh': refreshToken,
      },
    );
  }
}
