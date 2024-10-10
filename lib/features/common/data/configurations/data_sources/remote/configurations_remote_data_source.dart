import 'package:eram_express_shared/data/models/country_model.dart';

abstract class ConfigurationsRemoteDataSource {
  Future<List<CountryModel>> getCountries();
}
