import 'dart:io';
import 'package:eram_express/features/profile/data/models/about_us_model.dart';
import 'package:eram_express_shared/core/api/api_endpoint.dart';

import '../models/terms_model.dart';

final aboutUsEndpoint = ApiEndpoint(
  path: '/about-us/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => AboutUsModel.fromJson(response.data)
  },
);
final termsEndpoint = ApiEndpoint(
  path: '/terms-and-conditions/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => TermsModel.fromJson(response.data)
  },
);
