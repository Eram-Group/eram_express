import 'dart:io';

import 'package:eram_express_shared/core/api/api_endpoint.dart';

final bookingRequestEndpoint = ApiEndpoint(
  path: '/booking-requests/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => null,
  },
);


