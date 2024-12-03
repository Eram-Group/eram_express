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

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      customer: CustomerModel.fromJson(json['customer']),
    );
  }
}
