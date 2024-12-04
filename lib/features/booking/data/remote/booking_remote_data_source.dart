import '../../../home/presentation/objects/booking_request_form_data.dart';
import '../models/booking_request_model.dart';
abstract class BookingRemoteDataSource 
 {
  Future<void> bookingRequest(BookingRequestFormData data, String accessToken,);
   Future<List<BookingRequestModel>> listBookingRequest(String accessToken,);
   Future<void>  acceptBidding(String accessToken ,int bidId);
 
 }