
import 'package:eram_express/features/home/data/models/home-Model.dart';
import '../models/cargo-categoriesModel.dart';
import '../models/cargo-subcategoryModel.dart';
import '../models/goods-typeModel.dart';

abstract class HomeDataRemoteDataSource {
  Future<List<CargoCategoryModel>> getCargoCategories();
  Future<List<CargoSubCategoryModel>> getSubCargoCategories();
  Future<List<GoodModel>> getgoods();
  Future<HomeModel> getHomeData();
}
