import 'dart:convert';

class PickingLocationModel {
  late Point point;
  final String address;
  PickingLocationModel({
    required this.point,
    required this.address,
  });

 
  

  PickingLocationModel copyWith({
     Point? point,
    String? address,
  }) {
    return PickingLocationModel(
      point: point ?? this.point,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'point': point.toMap(),
      'address': address,
    };
  }

  factory PickingLocationModel.fromMap(Map<String, dynamic> map) {
    return PickingLocationModel(
      point: Point.fromList(map['location']['coordinates']),
      address: map['location_text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PickingLocationModel.fromJson(String source) => PickingLocationModel.fromMap(json.decode(source));

  @override
  String toString() => 'PickingLocationModel(point: $point, address: $address)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PickingLocationModel &&
      other.point == point &&
      other.address == address;
  }

  @override
  int get hashCode => point.hashCode ^ address.hashCode;
}












class Point {
  double longitude;
  double latitude;
  Point({
    required this.longitude,
    required this.latitude,
  });



  Point copyWith({
    double? longitude,
    double? latitude,
  }) {
    return Point(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory Point.fromMap(Map<String, dynamic> map) {
    
    return Point(
      longitude: map['longitude']?.toDouble() ?? 0.0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Point.fromJson(String source) => Point.fromMap(json.decode(source));
  factory Point.fromList(List<dynamic> list) {
    return Point(
      longitude: list[0]?.toDouble() ?? 0.0,
      latitude: list[1]?.toDouble() ?? 0.0,
    );
  }
  @override
  String toString() => 'Point(longitude: $longitude, latitude: $latitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Point &&
      other.longitude == longitude &&
      other.latitude == latitude;
  }

  @override
  int get hashCode => longitude.hashCode ^ latitude.hashCode;
  }


