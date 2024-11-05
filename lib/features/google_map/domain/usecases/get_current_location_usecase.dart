import 'package:either_dart/either.dart';
import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/google_map/domain/services/locationservice.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';

import '../../../home/data/models/picking_locationModel.dart';

class GetCurrentLocationUsecase {
  final Locationservice _locationservice;

  GetCurrentLocationUsecase({required Locationservice locationservice})
      : _locationservice = locationservice;

  Future<Either<String, LocationData>> execute() async {
    try {
      LocationData locationData = await _locationservice.location.getLocation();
      _locationservice.currentLocation = PickingLocationModel(
        point: Point(
            longitude: locationData.longitude!,
            latitude: locationData.latitude!),
        address: "hellllp", // لحد ما يتم تخزينه
      );

      return Right(locationData); 
    } 
    catch (e) 
    {
      return Left("Failed to get current location: ${e.toString()}");
    }
  }
}
