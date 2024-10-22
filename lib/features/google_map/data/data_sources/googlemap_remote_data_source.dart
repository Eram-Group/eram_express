import 'package:either_dart/either.dart';

import '../../../../core/api/api_error.dart';

abstract class GoogleMapRemoteDataSource 
{
  Future<dynamic> getPredictionPlaces(String input);
  Future<dynamic> getPlacedetails(String lat,String long);
}
