import 'dart:io';
import '../../data/models/picking_locationModel.dart';

class BookingRequestFormData {
  final int? cargoVehicleSubcategoryId;
  final List<int> goodIds;
  final String bookingDate;
  //final PickingLocationModel pickup;
  //final PickingLocationModel destination;

  BookingRequestFormData({
    required this.cargoVehicleSubcategoryId,
    required this.goodIds,
    required this.bookingDate,
    //required this.pickup,
    //required this.destination,
  });
}
