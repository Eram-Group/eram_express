import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../../home/presentation/objects/booking_request_form_data.dart';
import '../remote/booking_remote_data_source.dart';
import 'BookingRepository .dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _bookingRemoteDataSource;

  List<BookingRequestModel>? _bookingRequests;
  BookingRepositoryImpl({
    required BookingRemoteDataSource bookingRemoteDataSource,
    required TokensLocalDataSource tokensLocalDataSource,
  })  : _bookingRemoteDataSource = bookingRemoteDataSource;
      

  @override
  Future<void> bookingRequest(BookingRequestFormData data) async {

    await _bookingRemoteDataSource.bookingRequest(data,);
  }

  @override
  Future<List<BookingRequestModel>> listBookingRequest() async {
 
    final result =
        await _bookingRemoteDataSource.listBookingRequest();
    _bookingRequests = result;
    return result;
  }

  @override
  Future<void> acceptBidding(int bidId) async {
   
    final result =
        await _bookingRemoteDataSource.acceptBidding( bidId);

    return result;
  }

  @override
  List<BookingRequestModel>? get cachetBooking => _bookingRequests;
}
