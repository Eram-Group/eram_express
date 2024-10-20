import 'package:eram_express/core/utils/logger.dart';
import 'package:eram_express/features/google_map/domain/repositories/google_map_reposirtoty.dart';
import 'package:location/location.dart';

class Locationservice 
{

  final GoogleMapRepository _googlemapRepository;
  Locationservice({
    required GoogleMapRepository googlemapRepository
    
  }) : _googlemapRepository = googlemapRepository;

  Location location=Location();
  
  
 void getsearchresult(input)
 {
   _googlemapRepository.getPredictionPlaces(input);
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
   
  void setmylocation() async // انا شاييفه دي اصلا تتنادي اول ما يفتح ال App
  {
    await checkAndRequestLocationService();
    var hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) 
    {
      getRealtimeLocation();
    } else 
    {
      //TODO show error barrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
    }
  }
  
  Stream<LocationData> getRealtimeLocation() {
    return location.onLocationChanged.map((LocationData currentLocation) {
      logger.debug(
          "Current Location: ${currentLocation.latitude}, ${currentLocation.longitude}");
      return currentLocation;
    });
  }

 Future<LocationData> getcurrentLocation() async
 {
     return await location.getLocation();
 }


}