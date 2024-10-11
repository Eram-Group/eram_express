import 'dart:async';

import 'package:either_dart/either.dart';

import '../../../../core/app_error.dart';
import '../../../../core/network/api_error.dart';
import '../../../customer/domain/entities/customer_entity.dart';
import '../objects/otp_verification_data.dart';

abstract class AuthenticationRepository {
  Future<CustomerEntity?> get authenticatedCustomer;
  Future<bool> get isAuthenticated;

  Future<Either<AppError, Null>> logout();
  Future<Either<ApiError, Null>> sendOtp(String phoneNumber);
  Future<Either<ApiError, CustomerEntity>> verifyOtp(OtpVerificationData data);
}
