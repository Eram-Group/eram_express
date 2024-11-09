import '../../domain/entities/picking_location_entity.dart';

class PickingLocationModel {
  late Point point;
  final String address;

  PickingLocationModel({required this.point, required this.address});

  factory PickingLocationModel.fromJson(Map<String, dynamic> json) {
    return PickingLocationModel(
      point: Point.fromJson(json['location']['coordinates']),
      address: json['location_text'] ?? '',
    );
  }

  
  PickingLocationEntity toEntity(PickingLocationModel pickingLocationModel) {
    return PickingLocationEntity(
      point: point.toEntity(pickingLocationModel.point), 
      address: pickingLocationModel.address,
    );
  }
}

class Point {
  double longitude;
  double latitude;

  Point({required this.longitude, required this.latitude});

  factory Point.fromJson(List<dynamic> json) {
    return Point(
      longitude: json[0],
      latitude: json[1],
    );
  }

  PointEntity toEntity(Point point ) {
    return PointEntity(
      longitude: point.longitude,
      latitude: latitude,
    );
  }
}
