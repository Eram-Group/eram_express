 import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../home/presentation/objects/booking_request_form_data.dart';
import '../models/bid_model.dart';
import '../models/booking_request_model.dart';

abstract class BookingRemoteDataSource 
 {
  Future<Either<ApiError, Null>> bookingRequest(BookingRequestFormData data, String accessToken,);
   Future<Either<ApiError, List<BookingRequestModel>>> listbBookingRequest(String accessToken,);
   Future<Either<ApiError,Null>>  acceptBidding(String accessToken ,int bidId);
 
 }