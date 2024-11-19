import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eram_express_shared/core/api/api_endpoint.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../home/data/models/cargo-categoriesModel.dart';

final validPointEndpoint = ApiEndpoint(
    path: '/validate-location/',
    method: HttpMethod.post,
    responseHandlers: {
      HttpStatus.ok: (response) => Null,
      HttpStatus.badRequest: (Response) =>
          "these location  move outside our service area ",
      //ApiError.fromJson(Response.data),
    });
