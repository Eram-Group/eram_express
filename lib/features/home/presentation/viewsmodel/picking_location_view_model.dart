import '../../domain/entities/picking_location_entity.dart';

class PickingLocationViewModel {
  final PointViewModel point;
  final String address;

  PickingLocationViewModel({
    required this.point,
    required this.address,
  });

  factory PickingLocationViewModel.fromEntity(PickingLocationEntity entity) {
    return PickingLocationViewModel(
      point: PointViewModel.fromEntity(entity.point), 
      address: entity.address,
    );
  }

}


class PointViewModel {
  final double longitude;
  final double latitude;

  PointViewModel({
    required this.longitude,
    required this.latitude,
  });

  factory PointViewModel.fromEntity(PointEntity entity) {
    return PointViewModel(
      longitude: entity.longitude,
      latitude: entity.latitude,
    );
  }


}
