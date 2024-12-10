import 'dart:convert';
import 'package:eram_express/common/models/provider_model.dart';

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





  BidModel copyWith({
    int? id,
    String? status,
    String? amount,
    String? amountCurrency,
    String? createdAt,
    ProviderModel? provider,
    int? bookingRequestId,
  }) {
    return BidModel(
      id: id ?? this.id,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      amountCurrency: amountCurrency ?? this.amountCurrency,
      createdAt: createdAt ?? this.createdAt,
      provider: provider ?? this.provider,
      bookingRequestId: bookingRequestId ?? this.bookingRequestId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'amount': amount,
      'amountCurrency': amountCurrency,
      'createdAt': createdAt,
      'provider': provider.toMap(),
      'bookingRequestId': bookingRequestId,
    };
  }

  factory BidModel.fromMap(Map<String, dynamic> map) {
    return BidModel(
      id: map['id'],
      status: map['status'] ,
      amount: map['amount'] ,
      amountCurrency: map['amountCurrency'] ,
      createdAt: map['createdAt'] ,
      provider: ProviderModel.fromMap(map['provider']),
      bookingRequestId: map['bookingRequestId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BidModel.fromJson(String source) => BidModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BidModel(id: $id, status: $status, amount: $amount, amountCurrency: $amountCurrency, createdAt: $createdAt, provider: $provider, bookingRequestId: $bookingRequestId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BidModel &&
      other.id == id &&
      other.status == status &&
      other.amount == amount &&
      other.amountCurrency == amountCurrency &&
      other.createdAt == createdAt &&
      other.provider == provider &&
      other.bookingRequestId == bookingRequestId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      status.hashCode ^
      amount.hashCode ^
      amountCurrency.hashCode ^
      createdAt.hashCode ^
      provider.hashCode ^
      bookingRequestId.hashCode;
  }
}

