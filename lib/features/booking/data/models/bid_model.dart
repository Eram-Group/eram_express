import 'package:eram_express/common/models/provider_model.dart';
import 'package:eram_express/features/booking/domain/Entities/bid_entity.dart';

class BidModel {
  final int id;
  final String status;
  final String amount;
  final String amountCurrency;
  final String createdAt;
  final ProviderModel provider;
  final int bookingRequestId;


  BidModel({
    required this.id,
    required this.status,
    required this.amount,
    required this.amountCurrency,
    required this.createdAt,
    required this.provider,
    required this.bookingRequestId,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['id'],
      status: json['status'],
      amount: json['amount'],
      amountCurrency: json['amount_currency'],
      createdAt: json['created_at'],
      provider: ProviderModel.fromJson(json['provider']),
      bookingRequestId: json["booking_request"],
    );
  }
  
  BidEntity toEntity() {
    return BidEntity(
        id: this.id,
        status: this.status,
        amount: this.amount,
        amountCurrency: this.amountCurrency,
        provider: this.provider.toEntity(),
        bookingRequestId: this.bookingRequestId);
  }
}
