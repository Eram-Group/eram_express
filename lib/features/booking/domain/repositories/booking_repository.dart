 import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../home/domain/objects/booking_request_form_data.dart';

abstract class BookingRepository 
{
  Future<Either<ApiError, Null>> bookingRequest(BookingRequestFormData data);
}