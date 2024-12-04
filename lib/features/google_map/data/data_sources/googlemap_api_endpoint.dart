import 'dart:io';
import 'package:eram_express_shared/core/api/api_endpoint.dart';

final validPointEndpoint = ApiEndpoint(
    path: '/validate-location/',
    method: HttpMethod.post,
    responseHandlers: {
      HttpStatus.ok: (response) => Null,
      HttpStatus.badRequest: (response) => "these location  move outside our service area ",
      //ApiError.fromJson(Response.data),
    });
