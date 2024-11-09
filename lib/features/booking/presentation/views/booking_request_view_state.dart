import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/Entities/booking_request_entity.dart';

class BookingRequestViewState  extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}
class BookingRequestViewErrorState extends BookingRequestViewState {
  String errorMessage;
  BookingRequestViewErrorState(this.errorMessage);

}

class BookingRequestViewSuccessState extends BookingRequestViewState {
  List<BookingRequestEntity> bookingRequests;
  BookingRequestViewSuccessState(
    this.bookingRequests
  );
   List<Object?> get props =>[bookingRequests];
}
class BookingRequestViewEmptyState extends BookingRequestViewState {
  
  BookingRequestViewEmptyState();
}



