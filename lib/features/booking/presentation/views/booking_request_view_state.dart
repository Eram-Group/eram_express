import 'package:equatable/equatable.dart';
import 'package:eram_express/features/booking/data/models/booking_request_model.dart';

/*
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
*/


enum BookingRequestStatus { initial, loading, loaded, error ,acceptBidding,empty }

extension BookingRequestViewStateX on BookingRequestViewState {
  bool get isInitial => status == BookingRequestStatus.initial;
  bool get isLoading => status == BookingRequestStatus.loading;
  bool get isLoaded => status == BookingRequestStatus.loaded;
  bool get isError => status == BookingRequestStatus.error;
  bool get isEmpty=>status== BookingRequestStatus.empty;
  bool get isAcceptingBid=> status == BookingRequestStatus.acceptBidding;
}

class BookingRequestViewState extends Equatable {
  final BookingRequestStatus status;
  final List<BookingRequestModel>? bookingRequests;
  final String? errorMessage;

  const BookingRequestViewState({
    required this.status,
    this.bookingRequests,
    this.errorMessage,
  });

  BookingRequestViewState copyWith({
    BookingRequestStatus? status,
    List<BookingRequestModel>? bookingRequests,
    String? errorMessage,
  }) {
    return BookingRequestViewState(
      status: status ?? this.status,
      bookingRequests: bookingRequests ?? this.bookingRequests,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, bookingRequests, errorMessage];
}
