 import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../home/domain/objects/booking_request_form_data.dart';
import '../../data/models/bid_model.dart';
import '../../data/models/booking_request_model.dart';
import '../Entities/bid_entity.dart';
import '../Entities/booking_request_entity.dart';

abstract class BookingRepository 
{
  Future<Either<ApiError, Null>> bookingRequest(BookingRequestFormData data);
  //Future<Either<ApiError, List<BidEntity>>> listBiddings(int bookingRequestId);
  Future<Either<ApiError, List<BookingRequestEntity>>> listBookingRequest();
  Future<Either<ApiError, Null>>acceptBidding(int bidId);
  List<BookingRequestEntity>? get cachetBooking ;
}