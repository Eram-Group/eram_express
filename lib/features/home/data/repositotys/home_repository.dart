import 'dart:async';

import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import 'package:eram_express/features/home/data/models/home-Model.dart';


abstract class HomeRepository {
 
  Future< List<CargoCategoryModel>> getCargoCategories(); 
  Future<List<CargoSubCategoryModel>> getSubCargoCategories();
  Future<List<GoodModel>> getGoods();
  Future<HomeModel>getHome();
}
