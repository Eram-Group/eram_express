import 'package:either_dart/either.dart';
import '../../data/models/addressmodels/place_details_model.dart';
import '../../data/models/place_auto_complete_model.dart';

abstract class GoogleMapRepository 
{
  Future<Either<String, List<PlaceAutocompleteModel>>> getPredictionPlaces(String input);
  Future<Either<String, List<PlaceDetailsModel>>> getPlacedetails(String lat ,String long);
  
}
