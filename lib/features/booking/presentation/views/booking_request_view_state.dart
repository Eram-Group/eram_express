import 'package:equatable/equatable.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/bid_view_model.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/booking_request_view_model.dart';
import 'package:flutter/material.dart';

import '../../domain/Entities/booking_request_entity.dart';

class BookingRequestViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingRequestViewErrorState extends BookingRequestViewState {
  String errorMessage;
  BookingRequestViewErrorState(this.errorMessage);
}

class BookingRequestViewSuccessState extends BookingRequestViewState {
  final List<BookingRequestViewModel> bookingRequests;

  BookingRequestViewSuccessState(this.bookingRequests);

  @override
  List<Object?> get props => [bookingRequests.map((e) => e.id).toList()];
}

class BookingRequestViewEmptyState extends BookingRequestViewState {
  BookingRequestViewEmptyState();
}

class AcceptbookingRequest extends BookingRequestViewState
{

}
class RequestSuccessEmptyState extends BookingRequestViewState {}





