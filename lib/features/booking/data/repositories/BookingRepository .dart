import 'package:either_dart/either.dart';
import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import '../../../home/presentation/objects/booking_request_form_data.dart';

abstract class BookingRepository 
{
  Future<Either<ApiError, Null>> bookingRequest(BookingRequestFormData data);
  Future<Either<ApiError, List<BookingRequestModel>>> listBookingRequest();
  Future<Either<ApiError, Null>> acceptBidding(int bidId);
  List<BookingRequestModel>? get cachetBooking;
}
