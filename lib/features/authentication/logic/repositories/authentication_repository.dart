import '../../../../core/network/api_service.dart';

class AuthenticationRepository {
  final ApiService _apiService;

  AuthenticationRepository({required ApiService apiService})
      : _apiService = apiService;
}
