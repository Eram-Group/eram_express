class PickingLocationModel {
  final Point point;
  final String address;
  PickingLocationModel({required this.point ,required this.address});

  Map<String, dynamic> toJson() {
    return {
      'picking_location': point.toJson(),
    };
  }
}

class Point {
  final double longitude;
  final double latitude;

  Point({required this.longitude, required this.latitude});

  Map<String, dynamic> toJson() {
    return {
      'type': 'Point',
      'coordinates': [longitude, latitude],
    };
  }
}
