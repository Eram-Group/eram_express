import 'package:either_dart/either.dart';
import 'package:eram_express/features/google_map/domain/Entities/address_entity.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import '../../domain/repositories/google_map_reposirtoty.dart';
import '../data_sources/googlemap_remote_data_source.dart';
import '../models/addressmodels/place_details_model.dart';
import '../models/place_auto_complete_model.dart';

class GoogleMapRepositoryImpl extends GoogleMapRepository {
  final GoogleMapRemoteDataSource _googlemapRemoteDataSource;

  GoogleMapRepositoryImpl(
      {required GoogleMapRemoteDataSource googlemapRemoteDataSource})
      : _googlemapRemoteDataSource = googlemapRemoteDataSource;
  @override
  Future<Either<String, List<PlaceAutocompleteModel>>> getPredictionPlaces(
      String input, String sessiontoken, String Counrty) async {
    try {
      final result = await _googlemapRemoteDataSource.getPredictionPlaces(
          input, sessiontoken, Counrty);

      if (result.statusCode == 200) {
        List<PlaceAutocompleteModel> predictionModels =
            (result.data['predictions'] as List)
                .map((item) => PlaceAutocompleteModel.fromjson(item))
                .toList();
        return Right(predictionModels);
      } else {
        logger.error("Error fetching predictions: ${result.statusMessage}");
        return Left("Error in prediction: ${result.statusMessage}");
      }
    } catch (error) {
      logger.error("Exception fetching predictions: ${error.toString()}");
      return Left("Exception in prediction: ${error.toString()}");
    }
  }

  @override
  Future<Either<String, AddressEntity>> getPlacedetails(String lat, String long) async
  {
    final result = await _googlemapRemoteDataSource.getPlacedetails(lat, long);
    if (result.statusCode == 200) 
    {
      logger.debug("Request successful");
      List<PlaceDetailsModel> placedetatilslist =(result.data['results'] as List).map((item) => PlaceDetailsModel.fromJson(item)).toList();
      AddressEntity address= AddressEntity(address:placedetatilslist[0].formattedAddress,countryCode: placedetatilslist[0].countryCode! );
      return Right(address);
    } 
    else 
    {
      logger.error("Error fetching predictions: ${result.statusMessage}");
      return Left("Error in prediction: ${result.statusMessage}");
    }
  }

  Future<Either<String, PlaceDetailsModel>> getCoordinatesForAddress(
      String address) async {
    final result = await _googlemapRemoteDataSource.getCoordinatesForAddress(address);
    if (result.statusCode == 200) {
      List<PlaceDetailsModel> placedetatilslist =
          (result.data['results'] as List)
              .map((item) => PlaceDetailsModel.fromJson(item))
              .toList();
      return Right(placedetatilslist[0]);
    } else {
      logger.error("Error fetching predictions: ${result.statusMessage}");
      return Left("Error in prediction: ${result.statusMessage}");
    }
  }
}
