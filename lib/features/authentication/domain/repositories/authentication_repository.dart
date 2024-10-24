import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/app_error.dart';


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
