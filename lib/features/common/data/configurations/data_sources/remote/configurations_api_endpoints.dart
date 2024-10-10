import 'dart:io';

import 'package:eram_express_shared/data/models/country_model.dart';

import '../../../../../../core/network/api_endpoint.dart';

final getCountriesEndpoint = ApiEndpoint<List<CountryModel>>(
  method: HttpMethod.get,
  path: "/countries",
  responseHandlers: {
    HttpStatus.ok: (response) => (response.data as List)
        .map<CountryModel>((e) => CountryModel.fromJson(e))
        .toList(),
  },
);
