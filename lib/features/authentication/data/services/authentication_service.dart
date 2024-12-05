
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
    required String phoneNumber,}) async {
    final response = await _authenticationRepository.sendOtp(phoneNumber);

  }

  Future<VerifyOtpResponseWrapper<VerifyOtpResponseModel>> verifyOtp({
    required OtpVerificationData data,
  }) async {
    final response = await _authenticationRepository.verifyOtp(data);
    return response;


  }

  Future<void> logout({Function()? onLogout}) async {
    final response = await _authenticationRepository.logout();
  }

  void savingToken(VerifyOtpResponseModel response) async {
    _authenticationRepository.savingToken(response);
  }
}
