import 'package:either_dart/either.dart';
import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import 'package:eram_express/features/home/data/models/home-Model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'home_repository.dart';
import '../data_sources/homeData_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataRemoteDataSource _remoteDataSource;
  List<CargoCategoryModel>? cachedCargoCategories;
  List<CargoSubCategoryModel>? cachedCargoSubCategory;
  List<GoodModel>? cachedGoods;
  HomeModel ? cachedHomeData;
  HomeRepositoryImpl({
    required HomeDataRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
Future<Either<ApiError, List<CargoCategoryModel>>>getCargoCategories() async {
    if (cachedCargoCategories != null) {
      return Right(cachedCargoCategories!);
    }

    final response = await _remoteDataSource.getCargoCategories();

    return response.fold((error) => Left(error), (data) {
      cachedCargoCategories = data;
      return Right(cachedCargoCategories!);
    });
  }

  @override
  Future<Either<ApiError, List<CargoSubCategoryModel>>> getSubCargoCategories() async {
    if (cachedCargoSubCategory != null) 
    {
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
  Future<Either<ApiError, List<GoodModel>>> getGoods() async {
    if (cachedGoods!= null) {
      return Right(cachedGoods!);
    }
    final response = await _remoteDataSource.getgoods();
    return await response.fold((error) async => Left(error), (data) async 
    {
      cachedGoods= data;
      return Right(cachedGoods!);
    });
  }

 @override
  Future<Either<ApiError, HomeModel>>getHome() async {
    if (cachedHomeData != null) 
    {
      return Right(cachedHomeData!);
    }
    final response = await _remoteDataSource.getHomeData();
    return response.fold(
      (error) => Left(error),
      (data)
       {
        cachedHomeData=data;
        return Right(cachedHomeData!);
      },
    );
  }

}
