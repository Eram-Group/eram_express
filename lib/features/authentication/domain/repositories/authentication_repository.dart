import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/app_error.dart';

<<<<<<< HEAD
import '../../../../core/api/api_error.dart';
import '../../../../core/app_error.dart';

=======
>>>>>>> ac9b3dfcd0ce0ee82fdedbbf6d9ba9892ea0b09c
import '../../../customer/domain/entities/customer_entity.dart';
import '../objects/otp_verification_data.dart';
import '../objects/verify_otp_response_wrapper.dart';

abstract class AuthenticationRepository {
  Future<CustomerEntity?> get authenticatedCustomer;
  Future<bool> get isAuthenticated;

  Future<Either<AppError, Null>> logout();
  Future<Either<ApiError, Null>> sendOtp(String phoneNumber);
  Future<Either<ApiError, VerifyOtpResponseWrapper<CustomerEntity>>> verifyOtp(
      OtpVerificationData data);

  void updateAuthenticatedCustomer(CustomerEntity data);
}
