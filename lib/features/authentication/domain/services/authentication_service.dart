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
    void Function()? onOtpFailed,
  }) async {
    final response = await _authenticationRepository.sendOtp(phoneNumber);
    response.fold(
      (error) => onOtpFailed?.call(),
      (data) => onOtpSent?.call(),
    );
  }

  Future<void> verifyOtp({
    required OtpVerificationData data,
    void Function()? onOtpVerified,
    void Function()? onOtpVerificationFailed,
  }) async {
    final response = await _authenticationRepository.verifyOtp(data);

    response.fold(
      (error) => onOtpVerificationFailed?.call(),
      (data) => onOtpVerified?.call(),
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
