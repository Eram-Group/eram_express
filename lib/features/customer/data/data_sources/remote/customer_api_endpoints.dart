import 'dart:io';

<<<<<<< HEAD
import '../../../../../core/api/api_endpoint.dart';
=======
import 'package:eram_express_shared/core/api/api_endpoint.dart';

>>>>>>> ac9b3dfcd0ce0ee82fdedbbf6d9ba9892ea0b09c
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
