import 'package:either_dart/either.dart';
import 'package:eram_express_shared/domain/entites/country_entity.dart';

import '../../../../core/api/api_error.dart';

abstract class ConfigurationsRepository {
  Future<Either<ApiError, List<CountryEntity>>> get countries;
}
