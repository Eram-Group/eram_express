import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/utils/logger.dart';

import '../../../customer/domain/repositories/customer_repository.dart';
import '../objects/otp_verification_data.dart';
import '../repositories/authentication_repository.dart';

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
    response.fold(
      (error) => onOtpFailed?.call(error),
      (data) => onOtpSent?.call(),
    );
  }

  Future<void> verifyOtp({
    required OtpVerificationData data,
    void Function(bool)? onOtpVerified,
    void Function(ApiError)? onOtpVerificationFailed,
  }) async {
    final response = await _authenticationRepository.verifyOtp(data);

    response.fold(
      (error) => onOtpVerificationFailed?.call(error),
      (data) => onOtpVerified?.call(data.isNewCustomer),
    );
  }

  Future<void> logout({Function()? onLogout}) async {
    final response = await _authenticationRepository.logout();
    response.fold(
      (error) => logger.error('Failed to logout'),
      (data) => onLogout?.call(),
    );
  }
}
