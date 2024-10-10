import 'package:either_dart/either.dart';
import 'package:eram_express/core/app_error.dart';
import 'package:eram_express/features/authentication/domain/objects/otp_verification_data.dart';
import 'package:eram_express/features/customer/domain/entities/customer_entity.dart';

import '../../../customer/data/data_sources/remote/customer_remote_data_source.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../data_sources/authentication/remote/authentication_remote_data_source.dart';
import '../data_sources/tokens/local/tokens_local_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;

  bool _isAuthenticated;

  AuthenticationRepositoryImpl({
    required AuthenticationRemoteDataSource remoteDataSource,
    required CustomerRemoteDataSource customerRemoteDataSource,
    required TokensLocalDataSource localDataSource,
  })  : _authenticationRemoteDataSource = remoteDataSource,
        _tokensLocalDataSource = localDataSource,
        _isAuthenticated = false;

  @override
  logout() async {
    try {
      await _tokensLocalDataSource.clearTokens();
      _isAuthenticated = false;
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
        _isAuthenticated = true;
        return Right(CustomerEntity.fromModel(data.customer));
      },
    );
  }

  @override
  bool get isAuthenticated => _isAuthenticated;

  @override
  set isAuthenticated(bool value) => _isAuthenticated = value;
}
