import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../entities/cargo_categories_entity.dart';
import '../entities/cargo_subcategory_entity.dart';
import '../entities/goods_entity.dart';


abstract class HomeRepository {
 
  Future<Either<ApiError, List<CargoCategoryEntity>>> getCargoCategories(); 
  Future<Either<ApiError, List<CargoSubCategoryEntity>>> getSubCargoCategories();
  Future<Either<ApiError, List<GoodEntity>>> getGoods();

}
