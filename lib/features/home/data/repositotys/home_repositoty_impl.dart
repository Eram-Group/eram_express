import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import 'package:eram_express/features/home/data/models/home-Model.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../data_sources/home_data-api_remote_data_source.dart';
import 'home_repository.dart';
import '../data_sources/homeData_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataRemoteDataSource _remoteDataSource;
  List<CargoCategoryModel>? cachedCargoCategories;
  List<CargoSubCategoryModel>? cachedCargoSubCategory;
  List<GoodModel>? cachedGoods;
  HomeModel? cachedHomeData;

  HomeRepositoryImpl({
    required final TokensLocalDataSource tokensLocalDataSource,
    required HomeDataApiRemoteDataSource remoteDataSource,
  })  : _remoteDataSource = remoteDataSource;

  @override
  Future<HomeModel> getHome() async {
    if (cachedHomeData != null) {
      return cachedHomeData!;
    }
    final response = await _remoteDataSource.getHomeData();
    logger.debug(response.categories.length.toString());
    cachedHomeData = response;
    return response;
  }
}
