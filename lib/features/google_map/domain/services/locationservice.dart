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
  Locationservice();
  PickingLocationModel? currentLocation;
  Location location = Location();

  Future<bool> checkAndRequestLocationPermission() async {
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
       
      } 
      catch (e) {
        logger.debug("Error: $e");
        return Future.error(e);
      }
    }
  }
}
