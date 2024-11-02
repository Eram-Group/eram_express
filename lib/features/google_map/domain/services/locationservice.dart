import 'package:either_dart/either.dart';
import 'package:eram_express/features/customer/domain/repositories/customer_repository.dart';
import 'package:eram_express/features/customer/domain/services/customer_service.dart';

import 'package:eram_express/features/google_map/domain/repositories/google_map_reposirtoty.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';

import '../../../authentication/domain/repositories/authentication_repository.dart';
import '../../../customer/domain/entities/customer_entity.dart';
import '../../../home/data/models/picking_locationModel.dart';
import '../../data/models/addressmodels/place_details_model.dart';
import '../../data/models/place_auto_complete_model.dart';

class Locationservice {
  final GoogleMapRepository _googlemapRepository;
  final AuthenticationRepository _authenticationRepository ;

  Locationservice({
    required GoogleMapRepository googleMapRepository,
    required AuthenticationRepository authenticationRepository 
  }) : _googlemapRepository = googleMapRepository,
  _authenticationRepository  = authenticationRepository;

  PickingLocationModel? currentLocation;
  Location location = Location();

  Future<Either<String, List<PlaceAutocompleteModel>>> getsearchresult(
      String input, String sessiontoken) async 
      {
       CustomerEntity? user= await _authenticationRepository.authenticatedCustomer;
    final result = await _googlemapRepository.getPredictionPlaces(input, sessiontoken,user!.country.code);
    return result;
  }

  Future<Either<String, List<PlaceDetailsModel>>> getplacedetailsresult(
      String lat, String long) async {
    final result = await _googlemapRepository.getPlacedetails(lat, long);

    return result;
  }
  Future<Either<String, PlaceDetailsModel>> getlonglatresult(
      String address) async {
    final result = await _googlemapRepository.getlonglatplace(address);

    return result;
  }

  Future<bool> checkAndRequestLocationPermission() async // ده التاني
  {
    var permisionstatus = await location.hasPermission();
    if (permisionstatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permisionstatus == PermissionStatus.denied) {
      permisionstatus = await location.requestPermission();

      if (permisionstatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationService() async //ده الاول
  {
    var isserviceEnabled = await location.serviceEnabled();
    if (!isserviceEnabled) {
      isserviceEnabled = await location.requestService();
    }
    if (!isserviceEnabled) {
      return false;
    }
    return true;
  }

  Future<LocationData?> setmylocation() async {
    await checkAndRequestLocationService();

    var hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) {
      try {
        return await getCurrentLocation();
      } catch (e) {
        logger.debug("Error: $e");
        return Future.error(e);
      }
    }
  }


  Future<LocationData> getCurrentLocation() async {
    try {
      LocationData locationData = await location.getLocation();
      currentLocation = PickingLocationModel(
        point: Point(
            longitude: locationData.longitude!,
            latitude: locationData.latitude!),
        address: "hellllp",
      );
      logger.debug(
          "enter and get the currentlocation ${currentLocation?.point.latitude}");
      return locationData;
    } catch (e) {
      logger.error("enter and get the currentlocation");
      logger.error("Error: $e");
      return Future.error(e);
    }
  }

   Future<String> getCustomerCountry() async
  {
     CustomerEntity? user= await _authenticationRepository.authenticatedCustomer;
     return user!.country.code!;
  }
}
