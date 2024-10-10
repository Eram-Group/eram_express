import 'package:eram_express/features/authentication/domain/objects/otp_verification_data.dart';

import '../../../customer/domain/repositories/customer_repository.dart';
import '../repositories/authentication_repository.dart';

class AuthenticationService {
  final AuthenticationRepository _authenticationRepository;
  final CustomerRepository _customerRepository;

  AuthenticationService({
    required AuthenticationRepository authenticationRepository,
    required CustomerRepository customerRepository,
  })  : _authenticationRepository = authenticationRepository,
        _customerRepository = customerRepository;

  Future<void> init() async {
    try {
      await _customerRepository.getAuthenticatedCustomer();
      _authenticationRepository.isAuthenticated = true;
    } catch (e) {
      _authenticationRepository.isAuthenticated = false;
    }
  }

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

  Future<void> verifyOtp(String phoneNumber, String otp) async {
    final response = await _authenticationRepository.verifyOtp(
      OtpVerificationData(phoneNumber: phoneNumber, otp: otp),
    );

    response.fold(
      (error) => throw error,
      (data) => null,
    );
  }
}
