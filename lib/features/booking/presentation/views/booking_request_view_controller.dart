import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/bid_model.dart';
import '../../data/repositories/booking_repository .dart';
import 'booking_request_view_state.dart';

BookingRequestViewState getBookingRequestState(
    BookingRepository bookingRepository) {
  return bookingRepository.cachetBooking == null
      ? BookingRequestViewState(status: BookingRequestStatus.initial)
      : bookingRepository.cachetBooking!.isEmpty
      //Question ليه بعد ما حطيت الباكدج عايزيني اشيل كل ال const 
          ?  BookingRequestViewState(status: BookingRequestStatus.empty)
          : BookingRequestViewState(
              status: BookingRequestStatus.loaded,
              bookingRequests: bookingRepository.cachetBooking);
}

class BookingRequestViewController extends Cubit<BookingRequestViewState> {
  final BookingRepository _bookingRepository;

  BookingRequestViewController({
    required BookingRepository bookingRepository,
  })  : _bookingRepository = bookingRepository,
        super(getBookingRequestState(bookingRepository)) {
    initialListBookingRequest();
  }
  Future<void> initialListBookingRequest() async {
    if (state.isLoaded) return;
    await listBookingRequest();
  }

  Future<void> listBookingRequest() async {
    //if (state.isLoaded) return;
    try {
      final result = await _bookingRepository.listBookingRequest();
      result.isEmpty
          ? emit(state.copyWith(status: BookingRequestStatus.empty))
          : emit(state.copyWith(
              status: BookingRequestStatus.loaded, bookingRequests: result));
    } catch (e) {
      emit(state.copyWith(errorMessage: "fail to load booking Request"));
    }
  }

  Future<void> acceptBidding(BidModel bid) async {
    try {
      await _bookingRepository.acceptBidding(bid.id);
      emit(state.copyWith(status: BookingRequestStatus.acceptBidding));
      removeAcceptingRequest(bid.bookingRequestId);
    } catch (e) {
      logger.debug(e.toString());
      emit(state.copyWith(
          status: BookingRequestStatus.error,
          errorMessage: "Error in accepting Bid"));
    }
  }

  void removeAcceptingRequest(int removedId) {
    _bookingRepository.cachetBooking!
        .removeWhere((booking) => booking.id == removedId);
    final newList = _bookingRepository.cachetBooking;
    newList!.isEmpty
        ? emit(state.copyWith(status: BookingRequestStatus.empty))
        : emit(state.copyWith(
            status: BookingRequestStatus.loaded, bookingRequests: newList));
  }

  List<BidModel> getBidding(int id) {
    try {
      BookingRequestModel booking = _bookingRepository.cachetBooking!
          .firstWhere((booking) => booking.id == id);
      List<BidModel> bids = booking.bids;
      return bids;
    } catch (e) {
      return [];
    }
  }
}
