import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import 'package:eram_express/features/home/data/models/home-Model.dart';
import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import 'home_repository.dart';
import '../data_sources/homeData_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository 
{
  final HomeDataRemoteDataSource _remoteDataSource;
  List<CargoCategoryModel>? cachedCargoCategories;
  final TokensLocalDataSource _tokensLocalDataSource;
  List<CargoSubCategoryModel>? cachedCargoSubCategory;
  List<GoodModel>? cachedGoods;
  HomeModel ? cachedHomeData;
  HomeRepositoryImpl({
    required  final TokensLocalDataSource tokensLocalDataSource,
    required HomeDataRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _tokensLocalDataSource=tokensLocalDataSource;
    



 

 @override
  Future<HomeModel>getHome() async {
    if (cachedHomeData != null) 
    {
      return cachedHomeData!;
    }
   final accessToken = await _tokensLocalDataSource.accessToken;
    final response = await _remoteDataSource.getHomeData(accessToken!);
    cachedHomeData=response;
    return response;
    
  
  }

}
