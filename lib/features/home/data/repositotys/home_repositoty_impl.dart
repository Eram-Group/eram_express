import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/domain/entites/country_entity.dart';

import '../../domain/repository/home_repository.dart';
import '../data_sources/HomeData_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataRemoteDataSource _remoteDataSource;
  List<CargoCategoryModel>? cachedcargocategories;
  List<CargoSubCategoryModel>? cachedCargoSubCategory;
  List<GoodModel>? cachedgoods;

  HomeRepositoryImpl({
    required HomeDataRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<ApiError, List<CargoCategoryModel>>>
      getCargoCategories() async {
    if (cachedcargocategories != null) return Right(cachedcargocategories!);
    final response = await _remoteDataSource.getCargoCategories();
    return await response.fold((error) async => Left(error), (data) async {
      cachedcargocategories = data;
      return Right(cachedcargocategories!);
    });
  }

  @override
  Future<Either<ApiError, List<CargoSubCategoryModel>>>
      getSubCargoCategories() async {
    if (cachedCargoSubCategory != null) {
      return Right(cachedCargoSubCategory!);
    }
    final response = await _remoteDataSource.getSubCargoCategories();
    return response.fold(
      (error) => Left(error),
      (data) {
        cachedCargoSubCategory = data;
        return Right(cachedCargoSubCategory!);
      },
    );
  }

  @override
  Future<Either<ApiError, List<GoodModel>>> getgoods() async {
    if (cachedgoods != null) {
      return Right(cachedgoods!);
    }
    final response = await _remoteDataSource.getgoods();
    return await response.fold((error) async => Left(error), (data) async 
    {
      cachedgoods = data;
      return Right(cachedgoods!);
    });
  }
}
