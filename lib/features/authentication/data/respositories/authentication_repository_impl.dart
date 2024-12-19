import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/tokens/local/tokens_local_data_source.dart';
import '../../../customer/data/models/customer_model.dart';
import '../../../customer/data/repositories/customer_repository.dart';
import '../../presentation/objects/otp_verification_data.dart';
import '../models/verify_otp_response_model.dart';
import 'authentication_repository.dart';
import '../data_sources/authentication/remote/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final CustomerRepository _customerRepository;
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;

  CustomerModel? _authenticatedCustomer;

  AuthenticationRepositoryImpl({
    required CustomerRepository customerRepository,
    required AuthenticationRemoteDataSource authenticationRemoteDataSource,
    required TokensLocalDataSource tokensLocalDataSource,
  })  : _customerRepository = customerRepository,
        _authenticationRemoteDataSource = authenticationRemoteDataSource,
        _tokensLocalDataSource = tokensLocalDataSource;

  @override
  Future<CustomerModel?> get authenticatedCustomer async {
    if (_authenticatedCustomer != null) return _authenticatedCustomer;
    try {
      final customer = await _customerRepository.getAuthenticatedCustomer();
      if (customer != null) _authenticatedCustomer = customer;
      return customer;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> get isAuthenticated async =>
      (await authenticatedCustomer) != null;

  @override
  logout() async 
  {
    await _authenticationRemoteDataSource.logOut();
    await _tokensLocalDataSource.clearTokens();
  }

  @override
  sendOtp(String phoneNumber) async {
    final response = await _authenticationRemoteDataSource.sendOtp(phoneNumber);
  }

  @override
  verifyOtp(OtpVerificationData data) async {
    final response = await _authenticationRemoteDataSource.verifyOtp(data);
    savingToken(response.response);
    return response;
  }

  @override
  void updateAuthenticatedCustomer(CustomerModel data) {
    logger.debug(_authenticatedCustomer!.fullName);
    _authenticatedCustomer = data;
  }

  @override
  void savingToken(VerifyOtpResponseModel response) async {
    await _tokensLocalDataSource.saveTokens(
      response.accessToken,
      response.refreshToken,
    );

    final customer = response.customer;
    _authenticatedCustomer = customer;
  }

}
