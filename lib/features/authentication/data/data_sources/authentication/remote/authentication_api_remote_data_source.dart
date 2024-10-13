import 'package:either_dart/either.dart';
import 'package:eram_express/features/authentication/data/models/verify_otp_response_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';

import '../../../../domain/objects/otp_verification_data.dart';
import '../../../../domain/objects/verify_otp_response_wrapper.dart';
import 'authentication_api_endpoints.dart';
import 'authentication_remote_data_source.dart';

class AuthenticationApiRemoteDataSource
    implements AuthenticationRemoteDataSource {
  final DioApiClient _dioClient;

  AuthenticationApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;

  @override
  sendOtp(String phoneNumber) async {
    return await _dioClient.request(
      sendOtpEndpoint.prepare(
        body: {
          'phone_number': phoneNumber,
        },
      ),
    );
  }

  @override
  Future<Either<ApiError, VerifyOtpResponseWrapper<VerifyOtpResponseModel>>>
      verifyOtp(OtpVerificationData data) async {
    return await _dioClient.request(
      verifyOtpEndpoint.prepare(
        body: {
          'phone_number': data.phoneNumber,
          'otp': data.otp,
        },
      ),
    );
  }
}
