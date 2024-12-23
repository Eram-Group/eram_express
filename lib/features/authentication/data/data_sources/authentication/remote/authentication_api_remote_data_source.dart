import 'package:eram_express/features/authentication/data/models/verify_otp_response_model.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
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
      data: {'phoneNumber': phoneNumber},
    );
  }

  @override
  Future<VerifyOtpResponseWrapper<VerifyOtpResponseModel>> verifyOtp(
      OtpVerificationData data) async {
    
    final DeviceDetailsModel deviceDetails =
        await _notificationService.getDeviceDetails();
 
    final response = await _networkService.post(
      '$baseUrl/customer/authenticate/',
      data: {
        'phoneNumber': data.phoneNumber,
        'otp': data.otp,
       
        "device": deviceDetails.toMap()
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
