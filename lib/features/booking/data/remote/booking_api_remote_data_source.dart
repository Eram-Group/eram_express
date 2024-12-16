import 'package:eram_express_shared/core/api/network-service.dart';
import '../../../../app/api_keys.dart';
import '../../../home/presentation/objects/booking_request_form_data.dart';
import '../models/booking_request_model.dart';
import 'booking_remote_data_source.dart';

class BookingApiRemoteDataSource implements BookingRemoteDataSource {
  final NetworkService _networkService;
  BookingApiRemoteDataSource({required NetworkService networkService})
      : _networkService = networkService;
  @override
  Future<void> bookingRequest(BookingRequestFormData data) async {
    await _networkService.post("$baseUrl/booking-requests/create/",
        data: data.toMap());
  }

  @override
  Future<List<BookingRequestModel>> listBookingRequest() async {
    final response = await _networkService.get('$baseUrl/booking-requests/');
    return (response.data as List)
        .map(
            (item) => BookingRequestModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> acceptBidding(int bidId) async {
    await _networkService.post("$baseUrl/bids/$bidId/accept/");
  }
}
