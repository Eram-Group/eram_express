import 'package:eram_express/features/home/data/models/home-Model.dart';

abstract class HomeDataRemoteDataSource {
  Future<HomeModel> getHomeData();
}
