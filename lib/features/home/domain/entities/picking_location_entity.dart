class PickingLocationEntity {
  final PointEntity point;
  final String address;

  PickingLocationEntity({
    required this.point,
    required this.address,
  });
}

class PointEntity {
  final double longitude;
  final double latitude;

  PointEntity({
    required this.longitude,
    required this.latitude,
  });
}
