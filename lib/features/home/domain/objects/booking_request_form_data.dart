import 'dart:io';
import '../../presentation/viewsmodel/picking_location_view_model.dart';

class BookingRequestFormData {
  // هل ممكن احولها لل entity علشان احنا domain
  final int? cargoVehicleSubcategoryId;
  final List<int> goodIds;
  final String bookingDate;
  final PickingLocationViewModel pickup;
  final PickingLocationViewModel destination;

  BookingRequestFormData({
    required this.cargoVehicleSubcategoryId,
    required this.goodIds,
    required this.bookingDate,
    required this.pickup,
    required this.destination,
  });
}
