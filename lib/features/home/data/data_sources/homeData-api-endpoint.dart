import 'dart:io';

import 'package:eram_express/features/home/data/models/home-Model.dart';
import 'package:eram_express_shared/core/api/api_endpoint.dart';


final homeDataEndPoint = ApiEndpoint(
  path: '/customer/home/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => HomeModel.fromJson(response.data),
  
  },
);
