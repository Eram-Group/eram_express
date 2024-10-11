import 'dart:io';

import '../../../../../core/api/api_endpoint.dart';
import '../../models/customer_model.dart';

final getAuthenticatedCustomerEndpoint = ApiEndpoint(
  path: '/customer/me/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => CustomerModel.fromJson(response.data),
  },
);
