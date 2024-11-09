import 'package:either_dart/either.dart';
import 'package:eram_express/features/google_map/domain/Entities/address_entity.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../domain/repositories/google_map_reposirtoty.dart';
import '../data_sources/googlemap_remote_data_source.dart';
import '../models/addressmodels/place_details_model.dart';
import '../models/place_auto_complete_model.dart';

class GoogleMapRepositoryImpl extends GoogleMapRepository {
  final GoogleMapRemoteDataSource _googlemapRemoteDataSource;
   final TokensLocalDataSource _tokensLocalDataSource;
  GoogleMapRepositoryImpl(
      {required GoogleMapRemoteDataSource googlemapRemoteDataSource,
       required TokensLocalDataSource tokensLocalDataSource,
       })
      : _googlemapRemoteDataSource = googlemapRemoteDataSource,
       _tokensLocalDataSource = tokensLocalDataSource;
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
  Future<Either<String, AddressEntity>> getPlaceDetails(String lat, String long) async
  {
     final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) {
      return Left("Error in Auntheriozation"); 
    }
    final result= _googlemapRemoteDataSource.validateLocation(accessToken,lat, long);
    return result.fold((error)=>Left(error.errors[0].code),
    (data) async
    {
    final result = await _googlemapRemoteDataSource.getPlaceDetails(lat, long);
    if (result.statusCode == 200) 
    {
      logger.debug("Request successful");
      List<PlaceDetailsModel> placeDetatilsList =(result.data['results'] as List).map((item) => PlaceDetailsModel.fromJson(item)).toList();
      AddressEntity address= AddressEntity(address:placeDetatilsList[0].formattedAddress,countryCode: placeDetatilsList[0].countryCode! );
      return Right(address);
    } 
    else 
    {
      logger.error("Error fetching predictions: ${result.statusMessage}");
      return Left("Error in prediction: ${result.statusMessage}");
    }
  }
    );
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
