import 'package:eram_express/features/booking/domain/Entities/bid_entity.dart';

import '../../../customer/data/models/customer_model.dart';
import '../../../home/data/models/picking_locationModel.dart';
import '../../data/models/booking_request_model.dart';

class BookingRequestEntity {
  final int id;
  final String status;
  final DateTime bookingDate;
  final PickingLocationModel pickingLocation;
  final PickingLocationModel destinationLocation;
  List<BidEntity> bids;

  BookingRequestEntity({
    required this.id,
    required this.status,
    required this.bookingDate,
    required this.pickingLocation,
    required this.destinationLocation,
    List<BidEntity>? bids,
  }) : bids = bids ?? [];

  factory BookingRequestEntity.fromModel(BookingRequestModel model) {
    return BookingRequestEntity(
      id: model.id,
      status: model.status,
      bookingDate: model.bookingDate,
      pickingLocation: model.pickingLocation,
      destinationLocation: model.destinationLocation,
    );
  }
}
