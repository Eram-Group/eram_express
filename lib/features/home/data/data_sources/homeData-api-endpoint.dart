import 'dart:io';

import 'package:eram_express/features/home/data/models/home-Model.dart';
import 'package:eram_express_shared/core/api/api_endpoint.dart';

import '../models/cargo-categoriesModel.dart';
import '../models/cargo-subcategoryModel.dart';
import '../models/goods-typeModel.dart';

final cargoCategoriesEndpoint = ApiEndpoint(
  path: '/cargo-categories/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => (response.data as List)
        .map((item) => CargoCategoryModel.fromJson(item))
        .toList(),
  },
);

final cargoSubCategoriesEndpoint = ApiEndpoint(
  path: '/cargo-subcategories/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) {
      return (response.data as List)
          .map((item) => CargoSubCategoryModel.fromJson(item))
          .toList();
    },
  },
);

final goodTypeEndpoint = ApiEndpoint(
  path: '/supported-goods-types/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => (response.data as List)
        .map((item) => GoodModel.fromJson(item))
        .toList(),
  },
);

final homeDataEndPoint = ApiEndpoint(
  path: '/customer/home/',
  method: HttpMethod.get,
  
  responseHandlers: {
    HttpStatus.ok: (response) => (response.data as List).map((item) => HomeModel.fromJson(item)).toList(),
  },
);
