import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';



abstract class GoogleMapRemoteDataSource 
{
  Future<dynamic> getPredictionPlaces(String input,String sessiontoken ,String country);
  Future<dynamic> getPlaceDetails(String lat,String long);
  Future<dynamic> getCoordinatesForAddress(String address);
  Future<Either<ApiError,Null>>validateLocation(String accessToken, String lat,String long);
}
