import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../home/domain/objects/booking_request_form_data.dart';
import '../repositories/booking_repository.dart';

class BookingService {
  final BookingRepository _bookingRepository;

  BookingService({
    required BookingRepository bookingRepository,
  }) : _bookingRepository = bookingRepository;

  Future<Either<ApiError, Null>> bookingRequest(
      BookingRequestFormData data) async {
    final response = await _bookingRepository.bookingRequest(data);
    response.fold((error) => null, (data) => null);
    return response;
  }
}

/*
قدامي حلين يا اعمل لكل  field bool خاص بيه 
يا اعمل الفلح الي عملاه هناك
*/