import 'dart:io';
import 'package:eram_express/features/profile/data/models/about_us_model.dart';
import 'package:eram_express/features/profile/data/models/support_type_model.dart';
import 'package:eram_express_shared/core/api/api_endpoint.dart';

import '../models/contact_us_model.dart';
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

final contactUsEndpoint = ApiEndpoint(
  path: '/social-accounts/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => ContactUsModel.fromJson(response.data)
  },
);
final supportEndpoint = ApiEndpoint(
  path: "/contact/types/",
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => (response.data as List)
        .map((item) => SupportTypeModel.fromJson(item as Map<String, dynamic>))
        .toList(),
  },
);
final contactEndpoint = ApiEndpoint(
  path: "/contact/",
  method: HttpMethod.post,
  responseHandlers: {
    HttpStatus.created: (response) => null,
  },
);
