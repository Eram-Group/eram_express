
import 'package:eram_express/features/booking/domain/repositories/booking_repository.dart';
import 'package:eram_express/features/booking/domain/usecases/get_booking_request_usecase.dart';
import 'package:eram_express/features/booking/presentation/views/viewsmodel/booking_request_view_model.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_request_view_state.dart';

BookingRequestViewState getBookingRequestState(BookingRepository bookingRepository) {
  return bookingRepository.cachetBooking == null
      ? BookingRequestViewState(): bookingRepository.cachetBooking!.isEmpty?BookingRequestViewEmptyState()
      : BookingRequestViewSuccessState(
          bookingRepository.cachetBooking!
              .map((item) => BookingRequestViewModel.fromEntity(item))
              .toList(),
        );
}

class BookingRequestViewController extends Cubit<BookingRequestViewState> {
  final GetBookingRequestUsecase _getBookingRequestUsecase;
  //final GetBiddingsUsecase _getBiddingsUsecase;

  BookingRequestViewController({
    required GetBookingRequestUsecase getBookingRequestUsecase,
    // required GetBiddingsUsecase getBiddingsUsecase,
    required BookingRepository bookingRepository,
  })  : _getBookingRequestUsecase = getBookingRequestUsecase,
        //_getBiddingsUsecase = getBiddingsUsecase,
        super(getBookingRequestState(bookingRepository)) {
    listBookingRequest();
  }

  Future<void> listBookingRequest() async {
   
    if (state is BookingRequestViewSuccessState) return;
    final result = await _getBookingRequestUsecase.execute();
    result.fold(
        (error) =>
            emit(BookingRequestViewErrorState("Error: ${error.toString()}")),
        (data) 
        {
          data.isEmpty? emit(BookingRequestViewEmptyState()):
         emit(
              BookingRequestViewSuccessState(data
                  .map((item) => BookingRequestViewModel.fromEntity(item))
                  .toList()),
            );
        });
  }
}
