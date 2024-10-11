import 'package:either_dart/either.dart';
import 'package:eram_express_shared/data/models/country_model.dart';

import '../../../../../../core/api/api_error.dart';

abstract class ConfigurationsRemoteDataSource {
  Future<Either<ApiError, List<CountryModel>>> getCountries();
}
