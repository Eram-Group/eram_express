import 'package:dio/dio.dart';

import '../../../../app/di.dart';

import 'googlemap_remote_data_source.dart';

class GoogleMapApiRemoteDataSource implements GoogleMapRemoteDataSource {
  GoogleMapApiRemoteDataSource();

  String url = 'https://maps.googleapis.com/maps/api/';
  String apiKey = 'AIzaSyBjgqhScxJNS9pvwKyDNEdvjW-RKpIP5uM';

  @override
  Future<dynamic> getPredictionPlaces(String input, String sessiontoken ,String country) async {
    Response response =
        await dio.get(url + "place/autocomplete/json", queryParameters: {
      'input': input,
      'key': apiKey,
      'sessiontoken': sessiontoken,
      'components':  'country:$country',
       //TODO
      //'language': 'ar',
      
    });
    return response;
  }
 
  Future<dynamic> getCoordinatesForAddress(String address) async {
    
    Response response = await dio.get(url + "geocode/json", queryParameters: {
      'address': address,
      'key': apiKey,
      //TODO
      //'language': 'ar',
    });
    return response;
  }
  Future<dynamic> getPlacedetails(String lat, String long) async {
    String input = lat + "," + long;
    Response response = await dio.get(url +"geocode/json", queryParameters: {
      'latlng': input,
      'key': apiKey,
      //TODO
      //'language': 'ar',
    });
    return response;
  }
}