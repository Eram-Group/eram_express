import 'package:either_dart/either.dart';
import 'package:eram_express/core/network/api_error.dart';
import 'package:eram_express/features/authentication/data/data_sources/authentication/models/verify_otp_response_model.dart';
import 'package:eram_express/features/authentication/domain/objects/otp_verification_data.dart';

import '../../../../../../core/network/dio_api_client.dart';
import 'authentication_api_endpoint.dart';
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
  Future<Either<ApiError, VerifyOtpResponseModel>> verifyOtp(
      OtpVerificationData data) async {
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
