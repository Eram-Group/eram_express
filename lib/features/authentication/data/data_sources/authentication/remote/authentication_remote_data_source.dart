import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

<<<<<<< HEAD
import '../../../../../../core/api/api_error.dart';

=======
>>>>>>> ac9b3dfcd0ce0ee82fdedbbf6d9ba9892ea0b09c
import '../../../../domain/objects/otp_verification_data.dart';
import '../../../../domain/objects/verify_otp_response_wrapper.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<ApiError, Null>> sendOtp(String phoneNumber);
  Future<Either<ApiError, VerifyOtpResponseWrapper>> verifyOtp(
      OtpVerificationData data);
}
