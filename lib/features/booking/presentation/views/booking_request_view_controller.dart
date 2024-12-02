
import 'package:either_dart/either.dart';
import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/bid_model.dart';
import '../../data/repositories/BookingRepository .dart';
import 'booking_request_view_state.dart';

BookingRequestViewState getBookingRequestState(
    BookingRepository bookingRepository) {
  return bookingRepository.cachetBooking == null
      ? BookingRequestViewState()
      : bookingRepository.cachetBooking!.isEmpty
          ? BookingRequestEmptyViewState()
          : BookingRequestSuccessViewState(
              bookingRepository.cachetBooking!
                  
            );
}
 
class BookingRequestViewController extends Cubit<BookingRequestViewState>
 {
  final BookingRepository _bookingRepository;

 BookingRequestViewController({
    required BookingRepository bookingRepository,
  }) :
        _bookingRepository = bookingRepository,
        //_getBiddingsUsecase = getBiddingsUsecase,
        super(getBookingRequestState(bookingRepository)) {
    intiallistBookingRequest();
  }

  Future<void> intiallistBookingRequest() async {
    if (state is BookingRequestSuccessViewState) return;
    await listBookingRequest();
  }

  Future<void> listBookingRequest() async {
    //if (state is BookingRequestViewSuccessState) return;

    final result = _bookingRepository.listBookingRequest();
    result.fold(
        (error) =>emit(BookingRequesErrorViewState("Error: ${error.toString()}")),
        (data) {
      data.isEmpty
          ? emit(BookingRequestEmptyViewState())
          : emit(
              BookingRequestSuccessViewState(data)
            );
    });
  }

  Future<void> acceptBidding(BidModel bid) async {
    final result = await _bookingRepository.acceptBidding(bid.id);
    result.fold(
        (error) =>
            emit((BookingRequesErrorViewState("Error in acceptinggggg"))),
        (data) {
      emit(AcceptbookingRequest());
      removeAcceptingReqeust(bid.bookingRequestId);
    });
  }

  void removeAcceptingReqeust(int removedId) {
    _bookingRepository.cachetBooking! .removeWhere((booking) => booking.id == removedId);
    final newList =  _bookingRepository.cachetBooking;
    emit(BookingRequestSuccessViewState(newList!));
  }

  List<BidModel> getBidding(int id) {
    try {
      BookingRequestModel booking = _bookingRepository.cachetBooking!.firstWhere((booking) => booking.id == id);
      List<BidModel> bids =booking.bids;
      return bids;
    } 
    catch (e) 
    {
      return [];
    }
  }

 }