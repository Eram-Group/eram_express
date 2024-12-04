
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

 BookingRequestViewController({ required BookingRepository bookingRepository,}) 
 :_bookingRepository = bookingRepository,super(getBookingRequestState(bookingRepository)) 
  {
    initialListBookingRequest();
  }
  Future<void> initialListBookingRequest() async {
    if (state is BookingRequestSuccessViewState) return;
    await listBookingRequest();
  }

  Future<void> listBookingRequest() async {
    //if (state is BookingRequestViewSuccessState) return;
    try
    {
         final result =  await _bookingRepository.listBookingRequest();
         result.isEmpty
          ? emit(BookingRequestEmptyViewState())
          : emit(
              BookingRequestSuccessViewState(result));
    }
    catch (e)
    {
        emit(BookingRequestErrorViewState
("Error: ${e.toString()}"));
    }
 
  }

  Future<void> acceptBidding(BidModel bid) async {
    try
    {
    final result = await _bookingRepository.acceptBidding(bid.id);
      emit(AcceptBookingRequest());
      removeAcceptingReqeust(bid.bookingRequestId);
    }
    catch(e)
    {
      emit((BookingRequestErrorViewState
("Error in acceptinggggg")));
    }
   
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