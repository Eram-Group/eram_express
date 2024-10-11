import 'dart:io';
import '../../../../core/network/api_endpiont.dart';
import '../models/cargo-categoriesModel.dart';
import '../models/cargo-subcategoryModel.dart';
import '../models/goods-typeModel.dart';

final cargoCategoriesEndpoint=ApiEndpoint(path: '/cargo-categories/',
 method: HttpMethod.get,
 responseHandlers: {HttpStatus.ok: (response)=>CargoCategoryModel.fromJson(response.data),},
);

final cargoSubCategoriesEndpoint = ApiEndpoint(
  path: 'cargo-subcategories/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => CargoSubCategoryModel.fromJson(response.data),
  },
);
final goodTypeEndpoint = ApiEndpoint(
  path: '/supported-goods-types/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => GoodModel.fromJson(response.data),
  },
);
