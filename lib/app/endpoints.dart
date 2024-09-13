import '../core/network/api_endpiont.dart';

class ApiEndpoints {
  static ApiEndpoint login = ApiEndpoint(
    uri: '/login',
    method: ApiMethod.post,
  );

  static ApiEndpoint register = ApiEndpoint(
    uri: '/register',
    method: ApiMethod.post,
  );

  static ApiEndpoint logout = ApiEndpoint(
    uri: '/logout',
    method: ApiMethod.post,
  );
}
