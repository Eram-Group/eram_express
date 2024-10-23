import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage_keys.dart';
import 'tokens_local_data_source.dart';

class TokensSecureStorageLocalDataSource implements TokensLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  TokensSecureStorageLocalDataSource(
      {required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  @override
  Future<String?> get accessToken async =>
      await _secureStorage.read(key: kAccessTokenKey);

  @override
  Future<String?> get refreshToken async =>
      await _secureStorage.read(key: kRefreshTokenKey);

  @override
  Future<void> deleteAccessToken() async {
    return _secureStorage.delete(key: kAccessTokenKey);
  }

  @override
  Future<void> deleteRefreshToken() async {
    return _secureStorage.delete(key: kRefreshTokenKey);
  }

  @override
  Future<void> saveAccessToken(String token) async =>
      _secureStorage.write(key: kAccessTokenKey, value: token);

  @override
  Future<void> saveRefreshToken(String token) async =>
      _secureStorage.write(key: kRefreshTokenKey, value: token);

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      deleteAccessToken(),
      deleteRefreshToken(),
    ]);
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    logger.debug('Saving tokens');
    await Future.wait([
      saveAccessToken(accessToken),
      saveRefreshToken(refreshToken),
    ]);
  }
}
