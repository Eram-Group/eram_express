import 'package:either_dart/either.dart';
import 'package:eram_express_shared/data/models/country_model.dart';

import '../../../../../../core/network/api_error.dart';
import '../../../../../../core/network/dio_api_client.dart';
import 'configurations_api_endpoints.dart';
import 'configurations_remote_data_source.dart';

class ConfigurationsApiRemoteDataSource
    implements ConfigurationsRemoteDataSource {
  final DioApiClient _dioClient;
  ConfigurationsApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<Either<ApiError, List<CountryModel>>> getCountries() async =>
      await _dioClient.request(getCountriesEndpoint.prepare());
}
