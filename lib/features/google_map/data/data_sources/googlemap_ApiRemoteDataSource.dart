import 'package:dio/dio.dart';
import '../../../../app/di.dart';

import 'googlemap_remote_data_source.dart';

class GoogleMapApiRemoteDataSource implements GoogleMapRemoteDataSource {
  GoogleMapApiRemoteDataSource();

  @override
  Future<dynamic> getPredictionPlaces(String input) async {
    String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String apiKey = 'AIzaSyBjgqhScxJNS9pvwKyDNEdvjW-RKpIP5uM';

    Response response = await dio.get(url, queryParameters: {
      'input': input,
      'key': apiKey,
    });
    return response;
  }
}
