import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';
import '../../../../app/di.dart';
import 'googlemap_api_endpoint.dart';
import 'googlemap_remote_data_source.dart';

class GoogleMapApiRemoteDataSource implements GoogleMapRemoteDataSource {
  final DioApiClient _dioClient;
  GoogleMapApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;

  String url = 'https://maps.googleapis.com/maps/api/';
  String apiKey = 'AIzaSyBjgqhScxJNS9pvwKyDNEdvjW-RKpIP5uM';

  @override
  Future<dynamic> getPredictionPlaces(
      String input, String sessionToken, String country) async {
    Response response =  await dio.get("${url}place/autocomplete/json", queryParameters: {
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
    Response response = await dio.get("${url}geocode/json", queryParameters: {
      'address': address,
      'key': apiKey,
      //TODO
      //'language': 'ar',
    });
    return response;
  }

  Future<dynamic> getPlaceDetails(String lat, String long) async {
    String input = "$lat,$long";
    Response response = await dio.get("${url}geocode/json", queryParameters: {
      'latlng': input,
      'key': apiKey,
      //TODO
      //'language': 'ar',
    });
    return response;
  }

@override
  Future<void> validateLocation(
      String accessToken, String lat, String long) async {
    final response =
        await _dioClient.request(validPointEndpoint.prepare(headers: {
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    }, body: {
      "point": {
        "type": "Point",
        "coordinates": [
          double.parse(long),
          double.parse(lat)
        ] // Ensure valid lat/long format
      }
    }));

  
  }
}