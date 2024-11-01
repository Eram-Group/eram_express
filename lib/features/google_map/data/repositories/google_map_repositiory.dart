import 'package:either_dart/either.dart';
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
  Future<Either<String, List<PlaceAutocompleteModel>>> getPredictionPlaces(String input ,String sessiontoken,String Counrty) async {
    try {
      final result =  await _googlemapRemoteDataSource.getPredictionPlaces(input, sessiontoken,Counrty);

      if (result.statusCode == 200) {
        List<PlaceAutocompleteModel> predictionModels =
            (result.data['predictions'] as List)
                .map((item) => PlaceAutocompleteModel.fromjson(item))
                .toList();
        return Right(predictionModels);
      } else
      {
        logger.error("Error fetching predictions: ${result.statusMessage}");
        return Left("Error in prediction: ${result.statusMessage}");
      }
    } catch (error) 
    {
      logger.error("Exception fetching predictions: ${error.toString()}");
      return Left("Exception in prediction: ${error.toString()}");
    }
  }

  Future<Either<String, List<PlaceDetailsModel>>> getPlacedetails(String lat ,String long) async
  {
    final result=await _googlemapRemoteDataSource.getPlacedetails(lat, long);
    if(result.statusCode == 200)
    {
        logger.debug("Request successful");
          List<PlaceDetailsModel> placedetatilslist =
          (result.data['results'] as List)
              .map((item) => PlaceDetailsModel.fromJson(item))
              .toList();
        return Right(placedetatilslist);
    }
    else
      {
        logger.error("Error fetching predictions: ${result.statusMessage}");
        return Left("Error in prediction: ${result.statusMessage}");
      }
    } 
  }
