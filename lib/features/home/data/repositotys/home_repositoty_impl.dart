import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import 'package:eram_express/features/home/data/models/home-Model.dart';
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
 Future<List<CargoCategoryModel>>getCargoCategories() async {
    if (cachedCargoCategories != null) {
      return cachedCargoCategories!;
    }
    final response = await _remoteDataSource.getCargoCategories();
    cachedCargoCategories = response;
    return response;
   
  }

  @override
  Future<List<CargoSubCategoryModel>> getSubCargoCategories() async {
    if (cachedCargoSubCategory != null) 
    {
      return cachedCargoSubCategory! ;
    }
    final response = await _remoteDataSource.getSubCargoCategories();
     cachedCargoSubCategory = response;
    return response;
    
    
  }

  @override
  Future<List<GoodModel>> getGoods() async {
    if (cachedGoods!= null) {
      return cachedGoods!;
    }
    final response = await _remoteDataSource.getgoods();
     cachedGoods= response;
     return response;
  }

 @override
  Future<HomeModel>getHome() async {
    if (cachedHomeData != null) 
    {
      return cachedHomeData!;
    }
    final response = await _remoteDataSource.getHomeData();
    cachedHomeData=response;
    return response;
    
  
  }

}
