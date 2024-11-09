import '../../../customer/data/models/customer_model.dart';
import '../../data/models/bid_model.dart';
import '../../data/models/booking_request_model.dart';

class BidEntity {
  final int id;
  final String status;
  final String amount;
  final String amountCurrency;
  final CustomerModel provider;
  final BookingRequestModel bookingRequest;

  // Constructor
  BidEntity({
    required this.id,
    required this.status,
    required this.amount,
    required this.amountCurrency,
    required this.provider,
    required this.bookingRequest,
  });

 
  factory BidEntity.fromModel( BidModel model) {
    return BidEntity(
      id: model.id,
      status:model.status,
      amount:model.amount,
      amountCurrency:model.amountCurrency,
      provider: model.provider,
      bookingRequest: model.bookingRequest,
    );
  }
}
