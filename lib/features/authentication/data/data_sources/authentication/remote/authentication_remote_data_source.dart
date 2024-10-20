import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../../domain/objects/otp_verification_data.dart';
import '../../../../domain/objects/verify_otp_response_wrapper.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<ApiError, Null>> sendOtp(String phoneNumber);
  Future<Either<ApiError, VerifyOtpResponseWrapper>> verifyOtp(
      OtpVerificationData data);
}
