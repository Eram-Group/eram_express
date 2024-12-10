

abstract class GoogleMapRemoteDataSource 
{
  Future<dynamic> getPredictionPlaces(String input,String sessionToken ,String country);
  Future<dynamic> getPlaceDetails(String lat,String long);
  Future<dynamic> getCoordinatesForAddress(String address);
  Future<void>validateLocation(String accessToken, String lat,String long);
}
