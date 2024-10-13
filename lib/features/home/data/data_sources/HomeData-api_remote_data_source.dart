import 'package:either_dart/either.dart';
import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/goods-typeModel.dart';
import '../../../../../../core/api/api_error.dart';
import '../../../../../../core/api/dio_api_client.dart';
import 'HomeData_remote_data_source.dart';
import 'get-HomeData-api-endpoint.dart';

class HomeDataApiRemoteDataSource implements HomeDataRemoteDataSource 
{
  final DioApiClient _dioClient;
  HomeDataApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<Either<ApiError, List<CargoCategoryModel>>>
      getCargoCategories() async {
    return await _dioClient.request(
      cargoCategoriesEndpoint.prepare(),
    );
  }

  @override
  Future<Either<ApiError, List<CargoSubCategoryModel>>>getSubCargoCategories() async {
    return await _dioClient.request(cargoSubCategoriesEndpoint.prepare());
  }

  @override
  Future<Either<ApiError, List<GoodModel>>> getgoods() async 
  {
    return await _dioClient.request(
      goodTypeEndpoint.prepare(),
    );
  }
}
