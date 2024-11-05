import 'package:either_dart/either.dart';
import 'package:eram_express/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../customer/domain/entities/customer_entity.dart';
import '../../data/models/place_auto_complete_model.dart';
import '../repositories/google_map_reposirtoty.dart';

class GetSearchResultUsecase 
{
    final GoogleMapRepository _googlemapRepository;
  final AuthenticationRepository _authenticationRepository;

   GetSearchResultUsecase({
    required GoogleMapRepository googleMapRepository,
    required AuthenticationRepository authenticationRepository 
  }) : _googlemapRepository = googleMapRepository,
  _authenticationRepository  = authenticationRepository;

    Future<Either<String, List<PlaceAutocompleteModel>>>  execute(String input, String sessiontoken) async
  {
     CustomerEntity? user =await _authenticationRepository.authenticatedCustomer;
    final result = await _googlemapRepository.getPredictionPlaces(input, sessiontoken, user!.country.code);
    return result;
  }

}