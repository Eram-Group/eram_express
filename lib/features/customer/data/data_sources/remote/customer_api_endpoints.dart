import 'dart:io';

import 'package:eram_express_shared/core/api/api_endpoint.dart';

import '../../models/customer_model.dart';

final getAuthenticatedCustomerEndpoint = ApiEndpoint(
  path: '/customer/me/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => CustomerModel.fromJson(response.data),
  },
);

final updateProfileEndpoint = ApiEndpoint(
  path: '/customer/me/',
  method: HttpMethod.patch,
  responseHandlers: {
    HttpStatus.ok: (response) => CustomerModel.fromJson(response.data),
  },
);
