
import 'dart:io';

import 'package:eram_express/features/home/data/models/cargo-categoriesModel.dart';
import 'package:eram_express/features/home/data/models/cargo-subcategoryModel.dart';
import 'package:eram_express/features/home/data/models/home-Model.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';
import '../models/goods-typeModel.dart';
import 'homeData-api-endpoint.dart';
import 'homeData_remote_data_source.dart';
class HomeDataApiRemoteDataSource implements HomeDataRemoteDataSource 
{
  final DioApiClient _dioClient;
  HomeDataApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;


   @override
  Future<HomeModel> getHomeData(String accessToken) async
   {
     
    return await _dioClient.request(

     homeDataEndPoint.prepare(   
      headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        }),
     
    );
  }

}
