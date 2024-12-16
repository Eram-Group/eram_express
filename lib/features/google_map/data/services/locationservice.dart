
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:location/location.dart';
import '../../../home/data/models/picking_locationModel.dart';

class LocationService {
  LocationService();
  PickingLocationModel? currentLocation;
  Location location = Location();

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationService() async //First
  {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) 
    {
      isServiceEnabled = await location.requestService();
    }
    if (!isServiceEnabled) 
    {
      return false;
    }
    return true;
  }

  Future<LocationData> getCurrentLocation() async {
    try {
      LocationData locationData = await location.getLocation();

      currentLocation = PickingLocationModel(
        point: Point(
          longitude: locationData.longitude!,
          latitude: locationData.latitude!,
        ),
        address: " ",  
      );
      return locationData;
    }
     catch (e) 
     {
      throw "Failed to get current location: ${e.toString()}";
    }
  }
  
  Future<LocationData?> setmylocation() async {
    await checkAndRequestLocationService();
    var hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) {
      try 
      {
       
      } 
      catch (e) 
      {
        logger.debug("Error: $e");
        return Future.error(e);
      }
    }
  }
}
