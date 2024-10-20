import 'package:either_dart/either.dart';
import '../../data/models/place_autocomplete_model/place_autocomplete_model.dart';

abstract class GoogleMapRepository 
{
  Future<Either<String, List<PlaceAutocompleteModel>>> getPredictionPlaces(String input);
}
