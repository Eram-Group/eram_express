import 'package:either_dart/either.dart';

import 'package:eram_express/features/google_map/domain/repositories/google_map_reposirtoty.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';

import '../../data/models/addressmodels/place_details_model.dart';
import '../../data/models/place_auto_complete_model.dart';

class Locationservice {
  final GoogleMapRepository _googlemapRepository;
  Locationservice({required GoogleMapRepository googlemapRepository})
      : _googlemapRepository = googlemapRepository;

  Location location = Location();

  Future<Either<String, List<PlaceAutocompleteModel>>> getsearchresult(String input,String sessiontoken) async {
    
    final result = await _googlemapRepository.getPredictionPlaces(input , sessiontoken);
    return result;
  }

  Future<Either<String, List<PlaceDetailsModel>>> getplacedetailsresult(
      String lat, String long) async {
    final result = await _googlemapRepository.getPlacedetails(lat, long);

   
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

  Stream<LocationData> getRealtimeLocation() {
    return location.onLocationChanged.map((LocationData currentLocation) {
      /*
      logger.debug(
          "Current Location: ${currentLocation.latitude}, ${currentLocation.longitude}");
          */
      return currentLocation;
    });
  }

  Future<LocationData> getCurrentLocation() async {
    try {
      LocationData locationData = await location.getLocation();

      return locationData;
    } catch (e) {
      logger.debug("Error: $e");
      return Future.error(e);
    }
  }
}
