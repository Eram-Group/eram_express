import 'package:either_dart/either.dart';

import '../../data/models/addressmodels/place_details_model.dart';
import '../repositories/google_map_reposirtoty.dart';

class GetLonglatPlaceUsecase 
{
  final GoogleMapRepository _googlemapRepository;
  GetLonglatPlaceUsecase({
    required GoogleMapRepository googleMapRepository,
  }) : _googlemapRepository = googleMapRepository;
     

      Future<Either<String, PlaceDetailsModel>> execute(
      String address) async {
    final result = await _googlemapRepository.getlonglatplace(address);

    return result;
  }
   
   }