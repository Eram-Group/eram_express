import 'package:equatable/equatable.dart';
import 'package:eram_express/features/booking/data/models/booking_request_model.dart';

class BookingRequestViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingRequestErrorViewState
 extends BookingRequestViewState {
  final String errorMessage;
 BookingRequestErrorViewState(this.errorMessage);
}

class BookingRequestSuccessViewState extends BookingRequestViewState {
  final List<BookingRequestModel> bookingRequests;
  BookingRequestSuccessViewState(this.bookingRequests);
  @override
  //List<Object?> get props => [bookingRequests.map((e) => e.id).toList()];
  List<Object?> get props => [bookingRequests];
}

class BookingRequestEmptyViewState extends BookingRequestViewState {
  BookingRequestEmptyViewState();
}

class AcceptBookingRequest extends BookingRequestViewState {}
