import 'package:either_dart/either.dart';
import 'package:eram_express_shared/domain/entites/country_entity.dart';

import '../../../../../core/network/api_error.dart';
import '../../../domain/repositories/configurations_repository.dart';
import '../data_sources/remote/configurations_remote_data_source.dart';

class ConfigurationsRepositoryImpl implements ConfigurationsRepository {
  final ConfigurationsRemoteDataSource _remoteDataSource;
  List<CountryEntity>? _cachedCountries;

  ConfigurationsRepositoryImpl({
    required ConfigurationsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<ApiError, List<CountryEntity>>> get countries async {
    if (_cachedCountries != null) return Right(_cachedCountries!);
    final response = await _remoteDataSource.getCountries();

    return await response.fold(
      (error) async => Left(error),
      (data) async {
        _cachedCountries = data.map((e) => CountryEntity.fromModel(e)).toList();
        return Right(_cachedCountries ?? []);
      },
    );
  }
}
