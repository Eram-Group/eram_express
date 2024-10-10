import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:eram_express/features/authentication/domain/objects/otp_verification_data.dart';

import '../../../../core/app_error.dart';
import '../../../../core/network/api_error.dart';
import '../../../customer/domain/entities/customer_entity.dart';

abstract class AuthenticationRepository {
  bool get isAuthenticated;

  set isAuthenticated(bool value);

  Future<Either<AppError, Null>> logout();
  Future<Either<ApiError, Null>> sendOtp(String phoneNumber);
  Future<Either<ApiError, CustomerEntity>> verifyOtp(OtpVerificationData data);
}
