import 'package:eram_express_shared/data/models/country_model.dart';

abstract class ConfigurationsRepository {
  Future<List<CountryModel>> getCountries();
}
