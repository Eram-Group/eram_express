import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../data/models/goods-typeModel.dart';

abstract class HomeRepository {
 
  Future<Either<ApiError, List<CargoCategoryModel>>> getCargoCategories(); 
  Future<Either<ApiError, List<CargoSubCategoryModel>>> getSubCargoCategories();
  Future<Either<ApiError, List<GoodModel>>> getgoods();

}
