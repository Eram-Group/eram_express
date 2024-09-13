import 'package:either_dart/either.dart';

import '../../../../core/network/api_service.dart';
import '../../data/models/user_model.dart';

class AuthenticationRepository {
  final ApiService _apiService;

  AuthenticationRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<Either<String, User>> authenticate({
    required String username,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username == 'error') {
      return const Left("Error");
    }

    if (username.isEmpty) {
      return const Left("Username cannot be empty");
    }

    return Right(User(username: username));
  }
}
