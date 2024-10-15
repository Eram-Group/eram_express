import 'dart:io';
import '../../../../core/api/api_endpoint.dart';
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
    //GoodModel.fromJson(response.data),
  },
);
