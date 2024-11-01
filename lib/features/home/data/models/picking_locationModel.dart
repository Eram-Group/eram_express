class PickingLocationModel {
  late Point point;
  final String address;
  PickingLocationModel({required this.point, required this.address});

 
}

class Point {
  double longitude;
  double latitude;

  Point({required this.longitude, required this.latitude});


}
