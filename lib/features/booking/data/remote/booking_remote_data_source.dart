import '../../../home/presentation/objects/booking_request_form_data.dart';
import '../models/booking_request_model.dart';
abstract class BookingRemoteDataSource 
 {
  Future<void> bookingRequest(BookingRequestFormData data,);
   Future<List<BookingRequestModel>> listBookingRequest();
   Future<void>  acceptBidding(int bidId);
 
 }