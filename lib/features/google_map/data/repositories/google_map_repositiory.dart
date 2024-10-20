import 'package:either_dart/either.dart';
import '../../../../core/api/api_error.dart';
import '../../data/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:eram_express/core/utils/logger.dart';
import '../../domain/repositories/google_map_reposirtoty.dart';
import '../data_sources/googlemap_remote_data_source.dart';

class GoogleMapRepositoryImpl extends GoogleMapRepository {
  final GoogleMapRemoteDataSource _googlemapRemoteDataSource;

  GoogleMapRepositoryImpl(
      {required GoogleMapRemoteDataSource googlemapRemoteDataSource})
      : _googlemapRemoteDataSource = googlemapRemoteDataSource;
  @override
  Future<Either<String, List<PlaceAutocompleteModel>>> getPredictionPlaces(
      String input) async {
    try {
      final result =await _googlemapRemoteDataSource.getPredictionPlaces(input);

      if (result.statusCode == 200) {
        logger.debug("Request successful");
        logger.debug("state: ${result.data}");

        List<PlaceAutocompleteModel> predictionModels = result.data
            .map((item) => PlaceAutocompleteModel.fromJson(item))
            .toList();
        return Right(predictionModels);
      } else {
        // Handle error based on status code
        logger.error("Error fetching predictions: ${result.statusMessage}");
        return Left("Error in prediction: ${result.statusMessage}");
      }
    } catch (error) {
      logger.error("Exception fetching predictions: ${error.toString()}");
      return Left("Exception in prediction: ${error.toString()}");
    }
  }
}
