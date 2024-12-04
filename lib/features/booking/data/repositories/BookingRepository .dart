import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import '../../../home/presentation/objects/booking_request_form_data.dart';

abstract class BookingRepository 
{
  Future<void> bookingRequest(BookingRequestFormData data);  
  Future<List<BookingRequestModel>> listBookingRequest();
  Future<void> acceptBidding(int bidId);
  List<BookingRequestModel>? get cachetBooking;
}
