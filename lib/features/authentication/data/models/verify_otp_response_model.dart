import 'dart:convert';

import '../../../customer/data/models/customer_model.dart';

class VerifyOtpResponseModel {
  final String accessToken;
  final String refreshToken;
  final CustomerModel customer;
  VerifyOtpResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.customer,
  });
  VerifyOtpResponseModel copyWith({
    String? accessToken,
    String? refreshToken,
    CustomerModel? customer,
  }) {
    return VerifyOtpResponseModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      customer: customer ?? this.customer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'customer': customer.toMap(),
    };
  }

  factory VerifyOtpResponseModel.fromMap(Map<String, dynamic> map) {
    return VerifyOtpResponseModel(
      accessToken: map["accessToken"],
      refreshToken: map["refreshToken"],
      customer: CustomerModel.fromMap(map['customer']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpResponseModel.fromJson(String source) =>
      VerifyOtpResponseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'VerifyOtpResponseModel(accessToken: $accessToken, refreshToken: $refreshToken, customer: $customer)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerifyOtpResponseModel &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.customer == customer;
  }

  @override
  int get hashCode =>
      accessToken.hashCode ^ refreshToken.hashCode ^ customer.hashCode;
}
