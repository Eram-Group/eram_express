import 'package:eram_express_shared/core/utils/logger.dart';
import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import 'google_map_reposirtoty.dart';
import '../data_sources/googlemap_remote_data_source.dart';
import '../models/addressmodels/place_details_model.dart';
import '../models/place_auto_complete_model.dart';

class GoogleMapRepositoryImpl extends GoogleMapRepository {
  final GoogleMapRemoteDataSource _googleMapRemoteDataSource;
   final TokensLocalDataSource _tokensLocalDataSource;
  GoogleMapRepositoryImpl(
      {required GoogleMapRemoteDataSource googleMapRemoteDataSource,
       required TokensLocalDataSource tokensLocalDataSource,
       })
      : _googleMapRemoteDataSource = googleMapRemoteDataSource,
       _tokensLocalDataSource = tokensLocalDataSource;
  @override
  Future< List<PlaceAutocompleteModel>> getPredictionPlaces( String input, String sessionToken, String country) async {
      final result = await _googleMapRemoteDataSource.getPredictionPlaces(input, sessionToken, country);  
      if (result.statusCode == 200) 
      {
        List<PlaceAutocompleteModel> predictionModels =(result.data['predictions'] as List).map((item) => PlaceAutocompleteModel.fromjson(item)).toList();
        return predictionModels ;
      } 
      else 
      {
        logger.error("Error fetching predictions: ${result.statusMessage}");
        throw "Error fetching predictions: ${result.statusMessage}";
      }
   
  }

  @override
  Future<PlaceDetailsModel> getPlaceDetails(String lat, String long) async
  {
     final accessToken = await _tokensLocalDataSource.accessToken;
   try
   {
        await _googleMapRemoteDataSource.validateLocation(accessToken!,lat, long);
        final places =  await _googleMapRemoteDataSource.getPlaceDetails(lat, long);
      if (places.statusCode == 200) {
        logger.debug("Request successful");
        List<PlaceDetailsModel> placeDetailsList =(places.data['results'] as List) .map((item) => PlaceDetailsModel.fromJson(item)) .toList();
        return placeDetailsList[0];
      } 
      else
      {
         throw "Error fetching predictions: ${places.statusMessage}";
      }
   }
   catch(e)
   {
          throw "these location  move outside our service area ";

    //throw    //e.errors[0].code
   }
   
  }
@override
  Future<PlaceDetailsModel> getCoordinatesForAddress(String address) async {
    final result = await _googleMapRemoteDataSource.getCoordinatesForAddress(address);
    if (result.statusCode == 200)
     {
      List<PlaceDetailsModel> placeDetailsList =(result.data['results'] as List).map((item) => PlaceDetailsModel.fromJson(item)).toList();
      return placeDetailsList[0];
    } 
    else 
    {
      logger.error("Error fetching predictions: ${result.statusMessage}");
      return throw "Error in prediction: ${result.statusMessage}";
    }
  }

}