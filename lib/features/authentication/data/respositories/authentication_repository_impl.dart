import 'package:either_dart/either.dart';
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
    required AuthenticationRemoteDataSource remoteDataSource,
    required TokensLocalDataSource localDataSource,
  })  : _customerRepository = customerRepository,
        _authenticationRemoteDataSource = remoteDataSource,
        _tokensLocalDataSource = localDataSource;

  @override
  Future<CustomerEntity?> get authenticatedCustomer async {
    if (_authenticatedCustomer != null) return _authenticatedCustomer;

    final accessToken = await _tokensLocalDataSource.accessToken;

    if (accessToken == null) return null;

    final customer = await _customerRepository.getAuthenticatedCustomer(
      accessToken: accessToken,
    );

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
      return Left(AppError('Failed to logout'));
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
        await _tokensLocalDataSource.saveTokens(
          data.accessToken,
          data.refreshToken,
        );

        final customer = CustomerEntity.fromModel(data.customer);
        _authenticatedCustomer = customer;

        return Right(customer);
      },
    );
  }
}
