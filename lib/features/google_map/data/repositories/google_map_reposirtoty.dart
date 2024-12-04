import '../models/addressmodels/place_details_model.dart';
import '../models/place_auto_complete_model.dart';


abstract class GoogleMapRepository 
{
  Future< List<PlaceAutocompleteModel>> getPredictionPlaces(String input,String sessionToken,String country);
  Future< PlaceDetailsModel> getPlaceDetails(String lat ,String long);
  Future< PlaceDetailsModel> getCoordinatesForAddress(String address);
 

}
