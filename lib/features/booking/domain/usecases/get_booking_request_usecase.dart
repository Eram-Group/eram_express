import 'package:either_dart/either.dart';
import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import 'package:eram_express/features/booking/domain/repositories/booking_repository.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../Entities/booking_request_entity.dart';

class GetBookingRequestUsecase 

{
  final BookingRepository _bookingRepository;
   GetBookingRequestUsecase 
  ({
    required BookingRepository bookingRepository,
  }):_bookingRepository=bookingRepository;
  

  Future<Either<ApiError, List<BookingRequestEntity>>> execute() async
  {
    final result =_bookingRepository.listBookingRequest();
    return result;
  }

}