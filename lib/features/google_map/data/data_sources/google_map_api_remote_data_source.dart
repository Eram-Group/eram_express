import 'package:dio/dio.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import '../../../../app/api_keys.dart';
import 'google_map_remote_data_source.dart';

class GoogleMapApiRemoteDataSource implements GoogleMapRemoteDataSource {
  final NetworkService _networkService;
  GoogleMapApiRemoteDataSource(
      {required NetworkService networkService, required Dio dio})
      : _networkService = networkService;

  @override
  Future<dynamic> getPredictionPlaces(
      String input, String sessionToken, String country) async {
    Response response = await _networkService
        .get("${mapUrl}place/autocomplete/json", queryParameters: {
      'input': input,
      'key': apiKey,
      'sessiontoken': sessionToken,
      'components': 'country:$country',
      //TODO
      //'language': 'ar',
    });
    return response;
  }

  @override
  Future<dynamic> getCoordinatesForAddress(String address) async {
    Response response =
        await _networkService.get("${mapUrl}geocode/json", queryParameters: {
      'address': address,
      'key': apiKey,
      //TODO
      //'language': 'ar',
    });
    return response;
  }

  Future<dynamic> getPlaceDetails(String lat, String long) async {
    String input = "$lat,$long";
    Response response =
        await _networkService.get("${mapUrl}geocode/json", queryParameters: {
      'latlng': input,
      'key': apiKey,
      //TODO
      //'language': 'ar',
    });
    return response;
  }

  @override
  Future<void> validateLocation(
      String lat, String long) async {
    final response = _networkService.post('$baseUrl/location/validate-point/ ', data: {
      "point": {
        "type": "Point",
        "coordinates": [
          double.parse(long),
          double.parse(lat)
        ] // Ensure valid lat/long format
      }
    });
  }
}