import 'package:eram_express/features/home/data/models/home-Model.dart';
import 'package:eram_express_shared/core/api/network-service.dart';

import 'home_data_remote_data_source.dart';

class HomeDataApiRemoteDataSource implements HomeDataRemoteDataSource {
  final NetworkService _networkService;
  HomeDataApiRemoteDataSource({required NetworkService networkService})
      : _networkService = networkService;
  @override
  Future<HomeModel> getHomeData() async {
    final response = await _networkService.get(
      '/customer/home/',
    );
    return HomeModel.fromMap(response.data);
  }
}
