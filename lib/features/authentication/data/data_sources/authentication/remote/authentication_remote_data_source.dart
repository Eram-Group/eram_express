import 'package:either_dart/either.dart';

import '../../../../../../core/network/api_error.dart';
import '../../../../domain/objects/otp_verification_data.dart';
import '../models/verify_otp_response_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<ApiError, Null>> sendOtp(String phoneNumber);
  Future<Either<ApiError, VerifyOtpResponseModel>> verifyOtp(
      OtpVerificationData data);
}