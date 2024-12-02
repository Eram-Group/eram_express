import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import 'package:eram_express/features/home/data/models/home-Model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';


abstract class HomeRepository {
 
  Future<Either<ApiError, List<CargoCategoryModel>>> getCargoCategories(); 
  Future<Either<ApiError, List<CargoSubCategoryModel>>> getSubCargoCategories();
  Future<Either<ApiError, List<GoodModel>>> getGoods();
  Future<Either<ApiError, HomeModel>>getHome();
}
