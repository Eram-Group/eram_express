import 'package:eram_express/features/booking/domain/Entities/booking_request_entity.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/bid_view_model.dart';
import 'package:eram_express/features/home/presentation/viewsmodel/picking_location_view_model.dart';
import 'package:flutter/material.dart';

class BookingRequestViewModel 
{
   final int id;
  final String status;
  final String bookingDate;
  final PickingLocationViewModel pickingLocation;
  final PickingLocationViewModel destinationLocation;
   List<BidViewModel> bids;

  BookingRequestViewModel({
    required this.id,
    required this.status,
    required this.bookingDate,
    required this.pickingLocation,
    required this.destinationLocation,
    List<BidViewModel>? bids,
  }) : bids = bids ?? [];


  factory BookingRequestViewModel.fromEntity(BookingRequestEntity entity)
  {
     return BookingRequestViewModel(id:entity.id,  
     status: entity.status, 
     bookingDate: entity.bookingDate, 
     pickingLocation:PickingLocationViewModel.fromEntity(entity.pickingLocation),
     destinationLocation: PickingLocationViewModel.fromEntity(entity.pickingLocation),
     );
  }
}