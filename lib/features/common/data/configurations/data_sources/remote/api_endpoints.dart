import 'dart:io';

import 'package:eram_express_shared/data/models/country_model.dart';

import '../../../../../../core/api/api_endpoint.dart';


final getCountriesEndpoint = ApiEndpoint(
  method: HttpMethod.get,
  path: "/countries",
  responseHandlers: {
    HttpStatus.ok: (response) =>
        (response.data as List).map((e) => CountryModel.fromJson(e)).toList(),
  },
);
