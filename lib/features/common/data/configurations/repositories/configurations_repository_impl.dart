import 'package:eram_express_shared/domain/entites/country_entity.dart';

import '../../../domain/repositories/configurations_repository.dart';
import '../data_sources/remote/configurations_remote_data_source.dart';

class ConfigurationsRepositoryImpl implements ConfigurationsRepository {
  final ConfigurationsRemoteDataSource _remoteDataSource;
  List<CountryEntity>? _cachedCountries;

  ConfigurationsRepositoryImpl(
      {required ConfigurationsRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<List<CountryEntity>> getCountries() async {
    return _cachedCountries ??= (await _remoteDataSource.getCountries())
        .map((model) => CountryEntity.fromModel(model))
        .toList();
  }
}
