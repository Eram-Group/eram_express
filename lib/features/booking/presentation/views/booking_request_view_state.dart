import 'package:equatable/equatable.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/booking_request_view_model.dart';

class BookingRequestViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingRequesErrorViewState extends BookingRequestViewState {
  final String errorMessage;
  BookingRequesErrorViewState(this.errorMessage);
}

class BookingRequestSuccessViewState extends BookingRequestViewState {
  final List<BookingRequestViewModel> bookingRequests;
  BookingRequestSuccessViewState(this.bookingRequests);
  @override
  //List<Object?> get props => [bookingRequests.map((e) => e.id).toList()];
  List<Object?> get props => [bookingRequests];
}

class BookingRequestEmptyViewState extends BookingRequestViewState {
  BookingRequestEmptyViewState();
}

class AcceptbookingRequest extends BookingRequestViewState {}
