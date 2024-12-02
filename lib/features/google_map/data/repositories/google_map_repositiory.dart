import 'package:either_dart/either.dart';
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
  Future<Either<String, List<PlaceAutocompleteModel>>> getPredictionPlaces( String input, String sessionToken, String counrty) async {
    try {
      final result = await _googleMapRemoteDataSource.getPredictionPlaces( input, sessionToken, counrty);

      if (result.statusCode == 200) 
      {
        List<PlaceAutocompleteModel> predictionModels =
            (result.data['predictions'] as List).map((item) => PlaceAutocompleteModel.fromjson(item)).toList();
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
  Future<Either<String, PlaceDetailsModel>> getPlaceDetails(String lat, String long) async
  {
     final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) {
      return const Left("Error in Authorization"); 
    }
    final result= _googleMapRemoteDataSource.validateLocation(accessToken,lat, long);
    return result.fold((error)=>Left(error.errors[0].code),  
    (data) async
    {
    final result = await _googleMapRemoteDataSource.getPlaceDetails(lat, long);
    if (result.statusCode == 200) 
    {
      logger.debug("Request successful");
      List<PlaceDetailsModel> placeDetailsList =(result.data['results'] as List).map((item) => PlaceDetailsModel.fromJson(item)).toList();
      return Right(placeDetailsList[0]);
    } 
    else 
   
    {
      logger.error("Error fetching predictions: ${result.statusMessage}");
      return Left("Error in prediction: ${result.statusMessage}");
    }
  }
    );
    }
@override
  Future<Either<String, PlaceDetailsModel>> getCoordinatesForAddress(String address) async {
    final result = await _googleMapRemoteDataSource.getCoordinatesForAddress(address);
    if (result.statusCode == 200) {
      List<PlaceDetailsModel> placeDetailsList =(result.data['results'] as List).map((item) => PlaceDetailsModel.fromJson(item)).toList();
      return Right(placeDetailsList[0]);
    } else 
    {
      logger.error("Error fetching predictions: ${result.statusMessage}");
      return Left("Error in prediction: ${result.statusMessage}");
    }
  }

}
