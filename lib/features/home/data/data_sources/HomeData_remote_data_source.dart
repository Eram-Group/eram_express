import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import '../models/cargo-categoriesModel.dart';
import '../models/cargo-subcategoryModel.dart';
import '../models/goods-typeModel.dart';

abstract class HomeDataRemoteDataSource {
  Future<Either<ApiError, List<CargoCategoryModel>>>
      getCargoCategories(); //مش لاقيه لازمه اني اعمل entity هنا
  Future<Either<ApiError, List<CargoSubCategoryModel>>> getSubCargoCategories();
  Future<Either<ApiError, List<GoodModel>>> getgoods();
}
