import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/utils/logger.dart';

import '../../../customer/data/models/customer_model.dart';
import '../../../customer/data/repositories/customer_repository.dart';
import '../../presentation/objects/otp_verification_data.dart';
import '../../presentation/objects/verify_otp_response_wrapper.dart';
import '../models/verify_otp_response_model.dart';
import '../respositories/authentication_repository.dart';

class AuthenticationService {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationService({
    required AuthenticationRepository authenticationRepository,
    required CustomerRepository customerRepository,
  }) : _authenticationRepository = authenticationRepository;

  Future<bool> get isAuthenticated async =>
      (await _authenticationRepository.authenticatedCustomer) != null;

  Future<void> sendOtp({
    required String phoneNumber,
    void Function()? onOtpSent,
    void Function(ApiError)? onOtpFailed,
  }) async {
    final response = await _authenticationRepository.sendOtp(phoneNumber);
    /*
    response.fold(
      (error) => onOtpFailed?.call(error),
      (data) => onOtpSent?.call(),
    );
    */
  }

  Future<VerifyOtpResponseWrapper<VerifyOtpResponseModel>> verifyOtp({
    required OtpVerificationData data,
    void Function(bool)? onOtpVerified,
    void Function(ApiError)? onOtpVerificationFailed,
  }) async {
    final response = await _authenticationRepository.verifyOtp(data);
    return response;

/*
    response.fold(
      (error) => onOtpVerificationFailed?.call(error),
      (data) => onOtpVerified?.call(data.isNewCustomer),
    );
    */
  }

  Future<void> logout({Function()? onLogout}) async {
    final response = await _authenticationRepository.logout();
    /*
    response.fold(
      (error) => logger.error('Failed to logout'),
      (data) => onLogout?.call(),
    );
    */
  }

  void savingToken(VerifyOtpResponseModel response) async {
    _authenticationRepository.savingToken(response);
  }
}
