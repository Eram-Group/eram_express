
import 'package:eram_express/features/booking/domain/repositories/booking_repository.dart';
import 'package:eram_express/features/booking/domain/usecases/get_booking_request_usecase.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/bid_view_model.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/booking_request_view_model.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/Entities/booking_request_entity.dart';
import '../../domain/usecases/accept_bidding_usecase.dart';
import 'booking_request_view_state.dart';

BookingRequestViewState getBookingRequestState(
    BookingRepository bookingRepository) 
    {
  return bookingRepository.cachetBooking == null
      ? BookingRequestViewState()
      : bookingRepository.cachetBooking!.isEmpty
          ? BookingRequestEmptyViewState()
          : BookingRequestSuccessViewState(
              bookingRepository.cachetBooking!
                  .map((item) => BookingRequestViewModel.fromEntity(item))
                  .toList(),
            );
}

class BookingRequestViewController extends Cubit<BookingRequestViewState> {
  final GetBookingRequestUsecase _getBookingRequestUsecase;
  final AcceptBiddingUsecase _acceptBiddingUsecase;
  final BookingRepository _bookingRepository;
  //final GetBiddingsUsecase _getBiddingsUsecase;

  BookingRequestViewController({
    required GetBookingRequestUsecase getBookingRequestUsecase,
    required AcceptBiddingUsecase acceptBiddingUsecase,
    // required GetBiddingsUsecase getBiddingsUsecase,
    required BookingRepository bookingRepository,
  })  : _getBookingRequestUsecase = getBookingRequestUsecase,
        _acceptBiddingUsecase = acceptBiddingUsecase,
        _bookingRepository = bookingRepository,
        //_getBiddingsUsecase = getBiddingsUsecase,
        super(getBookingRequestState(bookingRepository)) {
    listBookingRequest();
  }

  Future<void> listBookingRequest() async {

    //if (state is BookingRequestViewSuccessState) return;
    logger.debug("message6666666");
    final result = await _getBookingRequestUsecase.execute();
    result.fold(
        (error) =>
            emit(BookingRequesErrorViewState("Error: ${error.toString()}")),
        (data) {
      data.isEmpty
          ? emit(BookingRequestEmptyViewState())
          : emit(
              BookingRequestSuccessViewState(data
                  .map((item) => BookingRequestViewModel.fromEntity(item))
                  .toList()),
            );
    });
  }




  Future<void> acceptBidding(BidViewModel bid) async {
    final result = await _acceptBiddingUsecase.execute(bid.id);
    result.fold(
        (error) => emit((BookingRequesErrorViewState("Error in acceptinggggg"))),
        (data) 
        {
           emit(AcceptbookingRequest());
           removeAcceptingReqeust(bid.bookingRequestId);
        });
  }

  void removeAcceptingReqeust(int RemovedId) 
  {
  _bookingRepository.cachetBooking!.removeWhere((booking) => booking.id == RemovedId);
    final newList = _bookingRepository.cachetBooking!.map((item) => BookingRequestViewModel.fromEntity(item)).toList();
    emit(BookingRequestSuccessViewState(newList));
  }
 List<BidViewModel> getBidding(int id) {
    try {
      
      BookingRequestEntity booking = _bookingRepository.cachetBooking!.firstWhere((booking) => booking.id == id);
      List<BidViewModel> bids = booking.bids.map((bid) => BidViewModel.fromEntity(bid)).toList();
      return bids;
    } catch (e) 
    {
     
      return [];
    }
  }

}
