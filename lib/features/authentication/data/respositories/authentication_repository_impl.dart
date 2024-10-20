import 'package:either_dart/either.dart';
import 'package:eram_express/features/authentication/domain/objects/verify_otp_response_wrapper.dart';
import 'package:eram_express_shared/core/app_error.dart';

import '../../../customer/domain/entities/customer_entity.dart';
import '../../../customer/domain/repositories/customer_repository.dart';
import '../../domain/objects/otp_verification_data.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../data_sources/authentication/remote/authentication_remote_data_source.dart';
import '../data_sources/tokens/local/tokens_local_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final CustomerRepository _customerRepository;
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;

  CustomerEntity? _authenticatedCustomer;

  AuthenticationRepositoryImpl({
    required CustomerRepository customerRepository,
    required AuthenticationRemoteDataSource authenticationRemoteDataSource,
    required TokensLocalDataSource tokensLocalDataSource,
  })  : _customerRepository = customerRepository,
        _authenticationRemoteDataSource = authenticationRemoteDataSource,
        _tokensLocalDataSource = tokensLocalDataSource;

  @override
  Future<CustomerEntity?> get authenticatedCustomer async {
    if (_authenticatedCustomer != null) return _authenticatedCustomer;

    final customer = await _customerRepository.getAuthenticatedCustomer();

    if (customer != null) _authenticatedCustomer = customer;

    return customer;
  }

  @override
  Future<bool> get isAuthenticated async =>
      (await authenticatedCustomer) != null;

  @override
  logout() async {
    try {
      await _tokensLocalDataSource.clearTokens();
      _authenticatedCustomer = null;
      return const Right(null);
    } catch (e) {
      return Left(
        AppError(
          title: 'Failed to logout',
          message: e.toString(),
        ),
      );
    }
  }

  @override
  sendOtp(String phoneNumber) async {
    final response = await _authenticationRemoteDataSource.sendOtp(phoneNumber);
    return response.fold(
      (error) => Left(error),
      (data) => const Right(null),
    );
  }

  @override
  verifyOtp(OtpVerificationData data) async {
    final response = await _authenticationRemoteDataSource.verifyOtp(data);

    return response.fold(
      (error) => Left(error),
      (data) async {
        final response = data.response;

        await _tokensLocalDataSource.saveTokens(
          response.accessToken,
          response.refreshToken,
        );

        final customer = CustomerEntity.fromModel(response.customer);
        _authenticatedCustomer = customer;

        return Right(
          VerifyOtpResponseWrapper(
            isNewCustomer: data.isNewCustomer,
            response: customer,
          ),
        );
      },
    );
  }

  @override
  void updateAuthenticatedCustomer(CustomerEntity data) {
    _authenticatedCustomer = data;
  }
}
