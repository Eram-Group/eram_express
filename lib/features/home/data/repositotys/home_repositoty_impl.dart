import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import 'package:eram_express/features/home/domain/entities/cargo_categories_entity.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/domain/entites/country_entity.dart';

import '../../domain/entities/cargo_subcategory_entity.dart';
import '../../domain/entities/goods_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_sources/homeData_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataRemoteDataSource _remoteDataSource;
  List<CargoCategoryEntity>? cachedCargoCategories;
  List<CargoSubCategoryEntity>? cachedCargoSubCategory;
  List<GoodEntity>? cachedGoods;
  HomeRepositoryImpl({
    required HomeDataRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
Future<Either<ApiError, List<CargoCategoryEntity>>>getCargoCategories() async {
    if (cachedCargoCategories != null) {
      return Right(cachedCargoCategories!);
    }

    final response = await _remoteDataSource.getCargoCategories();

    return response.fold((error) => Left(error), (data) {
      cachedCargoCategories = data.map((item) =>item.toEntity()).toList();
      return Right(cachedCargoCategories!);
    });
  }

  @override
  Future<Either<ApiError, List<CargoSubCategoryEntity>>> getSubCargoCategories() async {
    if (cachedCargoSubCategory != null) 
    {
      return Right(cachedCargoSubCategory!);
    }
    final response = await _remoteDataSource.getSubCargoCategories();
    return response.fold(
      (error) => Left(error),
      (data) {
        cachedCargoSubCategory = data.map((item)=>item.toEntity()).toList();
        return Right(cachedCargoSubCategory!);
      },
    );
  }

  @override
  Future<Either<ApiError, List<GoodEntity>>> getGoods() async {
    if (cachedGoods!= null) {
      return Right(cachedGoods!);
    }
    final response = await _remoteDataSource.getgoods();
    return await response.fold((error) async => Left(error), (data) async 
    {
      cachedGoods= data.map((item)=>item.toEntity()).toList();
      return Right(cachedGoods!);
    });
  }


}
