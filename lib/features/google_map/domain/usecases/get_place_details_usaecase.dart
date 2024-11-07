import 'package:either_dart/either.dart';
import 'package:eram_express/features/google_map/domain/Entities/address_entity.dart';

import '../../../authentication/domain/repositories/authentication_repository.dart';
import '../../../customer/domain/entities/customer_entity.dart';
import '../../data/models/addressmodels/place_details_model.dart';
import '../repositories/google_map_reposirtoty.dart';

class GetPlaceDetailsUsaecase {
  final GoogleMapRepository _googlemapRepository;
  final AuthenticationRepository _authenticationRepository;

  GetPlaceDetailsUsaecase({
    required AuthenticationRepository authenticationRepository,
    required GoogleMapRepository googleMapRepository,
  })  : _googlemapRepository = googleMapRepository,
        _authenticationRepository = authenticationRepository;

  Future<Either<String, AddressEntity>> execute(
      String lat, String long) async {
    final result = await _googlemapRepository.getPlacedetails(lat, long);

    return await result.fold(
      (error) => Left("Network error"), 
      (data) async {
        CustomerEntity? user = await _authenticationRepository.authenticatedCustomer;

        if (user != null && user.country.code == data.countryCode) 
        {
          return Right(data);
        }
         else {
          return Left("Out of service area"); 
        }
      },
    );
  }
}
