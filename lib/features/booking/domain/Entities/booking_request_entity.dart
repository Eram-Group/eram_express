import 'package:eram_express/features/booking/domain/Entities/bid_entity.dart';
import 'package:eram_express/features/home/domain/entities/picking_location_entity.dart';

class BookingRequestEntity {
  final int id;
  final String status;
  final String bookingDate;
  final PickingLocationEntity pickingLocation;
  final PickingLocationEntity destinationLocation;
  List<BidEntity> bids;

  BookingRequestEntity({
    required this.id,
    required this.status,
    required this.bookingDate,
    required this.pickingLocation,
    required this.destinationLocation,
    List<BidEntity>? bids,
  }) : bids = bids ?? [];

  
}
