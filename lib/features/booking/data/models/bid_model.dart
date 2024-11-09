import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import 'package:eram_express/features/customer/data/models/customer_model.dart';

class BidModel {
  final int id;
  final String status;
  final String amount;
  final String amountCurrency;
  final String createdAt;
  final CustomerModel provider; // هذا هو الكائن الذي يمثل الـ provider
  final BookingRequestModel bookingRequest;

  // constructor
  BidModel({
    required this.id,
    required this.status,
    required this.amount,
    required this.amountCurrency,
    required this.createdAt,
    required this.provider,
    required this.bookingRequest,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['id'],
      status: json['status'],
      amount: json['amount'],
      amountCurrency: json['amount_currency'],
      createdAt: json['created_at'],
      provider: CustomerModel.fromJson(json['provider']), 
      bookingRequest: BookingRequestModel.fromJson(
          json['booking_request']), 
    );
  }

}
