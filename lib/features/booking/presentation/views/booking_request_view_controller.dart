import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:eram_express/features/booking/domain/repositories/booking_repository.dart';
import 'package:eram_express/features/booking/domain/usecases/get_booking_request_usecase.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/bid_view_model.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/booking_request_view_model.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../../accepet_order_modal.dart';
import '../../domain/usecases/accept_bidding_usecase.dart';
import '../temp_offers_view.dart';
import 'booking_request_view_state.dart';

BookingRequestViewState getBookingRequestState(
    BookingRepository bookingRepository) {
  return bookingRepository.cachetBooking == null
      ? BookingRequestViewState()
      : bookingRepository.cachetBooking!.isEmpty
          ? BookingRequestViewEmptyState()
          : BookingRequestViewSuccessState(
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
    final result = await _getBookingRequestUsecase.execute();
    result.fold(
        (error) =>
            emit(BookingRequestViewErrorState("Error: ${error.toString()}")),
        (data) {
      data.isEmpty
          ? emit(BookingRequestViewEmptyState())
          : emit(
              BookingRequestViewSuccessState(data
                  .map((item) => BookingRequestViewModel.fromEntity(item))
                  .toList()),
            );
    });
  }

  void gotoHome() {
    emit(BookingRequestViewSuccessState(bookingRepository.cachetBooking!
        .map((item) => BookingRequestViewModel.fromEntity(item))
        .toList()));
    //Navigator.pop(NavigationService.globalContext);
  }

  void setbiddingState(List<BidViewModel> biddings, BuildContext context) {
    biddings.isEmpty
        ? emit(BiddingViewEmptyState())
        : emit(BiddingsViewLoadedState(biddings));
    Navigator.of(context).pushNamed(OffersView.route,
        arguments: OfferViewArguments(cubit: this));
  }

  Future<void> acceptBidding(BidViewModel bid) async {
    final result = await _acceptBiddingUsecase.execute(bid.id);
    result.fold(
        (error) =>
            emit((BookingRequestViewErrorState("Error in acceptinggggg"))),
        (data) {
      emit(BiddingViewEmptyState()); // الحاله دي ممكن اوقات محتجهاش
      /*
             قدامنا حل من 2 
          1- يا نفصل ال accept وكده نعمل
          2 controller


      */
      removeAcceptingReqeust(bid.bookingRequestId);
    });
  }

  void removeAcceptingReqeust(int RemovedId) {
    _bookingRepository.cachetBooking!
        .removeWhere((booking) => booking.id == RemovedId);
    emit(BookingRequestViewSuccessState(_bookingRepository.cachetBooking!
        .map((item) => BookingRequestViewModel.fromEntity(item))
        .toList()));
  }
}
