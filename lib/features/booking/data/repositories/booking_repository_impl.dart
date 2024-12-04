import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../../home/presentation/objects/booking_request_form_data.dart';
import '../remote/booking_remote_data_source.dart';
import 'BookingRepository .dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _bookingRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;
  List<BookingRequestModel>? _bookingRequests;
  BookingRepositoryImpl({
    required BookingRemoteDataSource bookingRemoteDataSource,
    required TokensLocalDataSource tokensLocalDataSource,
  })  : _bookingRemoteDataSource = bookingRemoteDataSource,
        _tokensLocalDataSource = tokensLocalDataSource;

  @override
  Future<void> bookingRequest(
      BookingRequestFormData data) async {
    final accessToken = await _tokensLocalDataSource.accessToken;
   
     await _bookingRemoteDataSource.bookingRequest(data, accessToken!);
    
  }
  @override
  Future<List<BookingRequestModel>>listBookingRequest() async {
    final accessToken = await _tokensLocalDataSource.accessToken;
   
    final result = await _bookingRemoteDataSource.listBookingRequest(accessToken!);
    return result;
  }
 @override
  Future<void> acceptBidding(int bidId) async {
    final accessToken = await _tokensLocalDataSource.accessToken;
    
    final result =
        await _bookingRemoteDataSource.acceptBidding(accessToken!, bidId);
    return result;
  }

  @override
  List<BookingRequestModel>? get cachetBooking => _bookingRequests;
}
