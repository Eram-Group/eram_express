abstract class TokensLocalDataSource {
  Future<void> saveTokens(String accessToken, String refreshToken);

  Future<void> saveAccessToken(String token);
  Future<void> deleteAccessToken();

  Future<void> saveRefreshToken(String token);
  Future<void> deleteRefreshToken();

  Future<void> clearTokens();

  Future<String?> get accessToken;
  Future<String?> get refreshToken;
}
