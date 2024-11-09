import 'package:either_dart/either.dart';
import 'package:eram_express/features/google_map/domain/Entities/address_entity.dart';
import '../../data/models/addressmodels/place_details_model.dart';
import '../../data/models/place_auto_complete_model.dart';

abstract class GoogleMapRepository 
{
  Future<Either<String, List<PlaceAutocompleteModel>>> getPredictionPlaces(String input,String sessiontoken,String country);
  Future<Either<String,AddressEntity>> getPlaceDetails(String lat ,String long);
  Future<Either<String, PlaceDetailsModel>> getCoordinatesForAddress(String address);
 

}
