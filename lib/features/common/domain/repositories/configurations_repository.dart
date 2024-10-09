import 'package:eram_express_shared/domain/entites/country_entity.dart';

abstract class ConfigurationsRepository {
  Future<List<CountryEntity>> getCountries();
}
