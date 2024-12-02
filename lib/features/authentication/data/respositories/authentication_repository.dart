import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:eram_express/features/customer/data/models/customer_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/app_error.dart';
import '../../presentation/objects/otp_verification_data.dart';
import '../../presentation/objects/verify_otp_response_wrapper.dart';

abstract class AuthenticationRepository {
  Future<CustomerModel?> get authenticatedCustomer;
  Future<bool> get isAuthenticated;

  Future<Either<AppError, Null>> logout();
  Future<Either<ApiError, Null>> sendOtp(String phoneNumber);
  Future<Either<ApiError, VerifyOtpResponseWrapper<CustomerModel>>> verifyOtp(
      OtpVerificationData data);

  void updateAuthenticatedCustomer(CustomerModel data);
}
