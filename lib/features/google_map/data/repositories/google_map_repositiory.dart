import 'package:eram_express_shared/core/utils/logger.dart';
import 'google_map_reposirtoty.dart';
import '../data_sources/google_map_remote_data_source.dart';
import '../models/addressmodels/place_details_model.dart';
import '../models/place_auto_complete_model.dart';

class GoogleMapRepositoryImpl extends GoogleMapRepository {
  final GoogleMapRemoteDataSource _googleMapRemoteDataSource;
  
  GoogleMapRepositoryImpl(
      {required GoogleMapRemoteDataSource googleMapRemoteDataSource,
     
       })
      : _googleMapRemoteDataSource = googleMapRemoteDataSource;
       
  @override
  Future< List<PlaceAutocompleteModel>> getPredictionPlaces( String input, String sessionToken, String country) async {
      final result = await _googleMapRemoteDataSource.getPredictionPlaces(input, sessionToken, country);  
      if (result.statusCode == 200) 
      {
        List<PlaceAutocompleteModel> predictionModels =(result.data['predictions'] as List).map((item) => PlaceAutocompleteModel.fromMap(item)).toList();
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
    
   try
   {
        await _googleMapRemoteDataSource.validateLocation(lat, long);
        final places =  await _googleMapRemoteDataSource.getPlaceDetails(lat, long);
      if (places.statusCode == 200) {
        logger.debug("Request successful");
        List<PlaceDetailsModel> placeDetailsList =(places.data['results'] as List) .map((item) => PlaceDetailsModel.fromMap(item)) .toList();
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
      List<PlaceDetailsModel> placeDetailsList =(result.data['results'] as List).map((item) => PlaceDetailsModel.fromMap(item)).toList();
      return placeDetailsList[0];
    } 
    else 
    {
      logger.error("Error fetching predictions: ${result.statusMessage}");
      return throw "Error in prediction: ${result.statusMessage}";
    }
  }

}
