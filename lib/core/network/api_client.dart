import 'api_endpoint.dart';

abstract class ApiClient {
  Future request(ApiEndpoint endpoint);
}
