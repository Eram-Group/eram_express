import 'package:either_dart/either.dart';
import '../models/addressmodels/place_details_model.dart';
import '../models/place_auto_complete_model.dart';


abstract class GoogleMapRepository 
{
  Future<Either<String, List<PlaceAutocompleteModel>>> getPredictionPlaces(String input,String sessionToken,String country);
  Future<Either<String, PlaceDetailsModel>> getPlaceDetails(String lat ,String long);
  Future<Either<String, PlaceDetailsModel>> getCoordinatesForAddress(String address);
 

}
