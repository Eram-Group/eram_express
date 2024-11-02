import 'package:either_dart/either.dart';



abstract class GoogleMapRemoteDataSource 
{
  Future<dynamic> getPredictionPlaces(String input,String sessiontoken ,String country);
  Future<dynamic> getPlacedetails(String lat,String long);
  Future<dynamic> getlonglatplace(String address);
}
