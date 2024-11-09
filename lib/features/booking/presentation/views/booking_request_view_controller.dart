import 'package:either_dart/either.dart';
import 'package:eram_express/features/booking/domain/repositories/booking_repository.dart';
import 'package:eram_express/features/booking/domain/usecases/get_biddings_usecase.dart';
import 'package:eram_express/features/booking/domain/usecases/get_booking_request_usecase.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/booking_request_model.dart';
import '../../domain/Entities/bid_entity.dart';
import '../../domain/Entities/booking_request_entity.dart';
import 'booking_request_view_state.dart';


BookingRequestViewState tempppppppp(BookingRepository bookingRepository)
{
   return  bookingRepository.cachetbooking==null?
  BookingRequestViewState() : BookingRequestViewSuccessState(bookingRepository.cachetbooking!);
}





class BookingRequestViewController extends Cubit<BookingRequestViewState> 
{
  final GetBookingRequestUsecase _getBookingRequestUsecase;
  final GetBiddingsUsecase _getBiddingsUsecase;
  //final BookingRepository _bookingRepository;
  BookingRequestViewController({
    required GetBookingRequestUsecase getBookingRequestUsecase,
    required GetBiddingsUsecase getBiddingsUsecase,
   required BookingRepository bookingRepository,
  })  : _getBookingRequestUsecase = getBookingRequestUsecase,
        _getBiddingsUsecase = getBiddingsUsecase, 
        super(tempppppppp(bookingRepository)) 
  {
    mapBidsToBookings();
  }



//bookingRepository.cachetbooking==null?BookingRequestViewState() : BookingRequestViewSuccessState(bookingRepository.cachetbooking!)

 List<BookingRequestEntity>? bookings;
 List<BidEntity>? bids;


  Future<void> listBookingRequest() async {
    final result = await _getBookingRequestUsecase.execute();

    result.fold((error) {
      emit(BookingRequestViewErrorState("Error: ${error.toString()}"));
    }, (data) {
      bookings = data;
    });
  }

  Future<void> listbiddings() async {
    final result = await _getBiddingsUsecase.execute(25);
    logger.debug("Fetching bids");

    result.fold(
      (error) {
        emit(BookingRequestViewErrorState("Error: ${error.toString()}"));
      },
      (data) {
        bids = data;
      },
    );
  }

  Future<void> mapBidsToBookings() async 
  {
   
 if(state is BookingRequestViewSuccessState)
 {
  return ;
 }
    //
    await Future.wait([
      listBookingRequest(),
      listbiddings(),
    ]);
    if (bookings == null || bids == null) {
      emit(BookingRequestViewErrorState("Error: Data not loaded properly"));
      return;
    }
    logger.debug(bookings![0].bids.length.toString());

    
    final bidsByBookingId = <int, List<BidEntity>>{};

    for (final bid in bids!) {
      final bookingId = bid.bookingRequest.id;
      bidsByBookingId.putIfAbsent(bookingId, () => []).add(bid);
    }

    for (final booking in bookings!) 
    {
      final matchingBids = bidsByBookingId[booking.id] ?? [];
      booking.bids.addAll(matchingBids);
    }

    for (final booking in bookings!) {
      logger.debug(
          'Booking #${booking.id}: ' '(${booking.bids.length} bids)');
    }

    emit(BookingRequestViewSuccessState(bookings!));
    
  }
}
