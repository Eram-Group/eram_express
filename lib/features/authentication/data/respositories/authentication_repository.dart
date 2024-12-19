import 'dart:async';
import '../../../customer/data/models/customer_model.dart';
import '../../presentation/objects/otp_verification_data.dart';
import '../../presentation/objects/verify_otp_response_wrapper.dart';
import '../models/verify_otp_response_model.dart';

abstract class AuthenticationRepository {
  Future<CustomerModel?> get authenticatedCustomer;
  Future<bool> isAuthenticated();

  Future<void> logout();
  Future<void> sendOtp(String phoneNumber);
  Future<VerifyOtpResponseWrapper<VerifyOtpResponseModel>> verifyOtp(
      OtpVerificationData data);
  void updateAuthenticatedCustomer(CustomerModel data);
  void savingToken(VerifyOtpResponseModel response);
}
