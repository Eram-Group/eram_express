import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../home/domain/objects/booking_request_form_data.dart';
import '../../data/models/booking_request_model.dart';
import '../repositories/booking_repository.dart';

class CreateBookingRequestUsecase {
  final BookingRepository _bookingRepository;

  CreateBookingRequestUsecase({
    required BookingRepository bookingRepository,
  }) : _bookingRepository = bookingRepository;

  // هنظبط حوار ال error لاي سبب
  Future<Either<ApiError, Null>> execute(BookingRequestFormData data) async {
    final response = await _bookingRepository.bookingRequest(data);
    response.fold((error) => null, (data) => null);
    return response;
  }
}
