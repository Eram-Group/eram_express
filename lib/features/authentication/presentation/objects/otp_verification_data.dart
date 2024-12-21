import 'dart:convert';


class OtpVerificationData {
  final String phoneNumber;
  final String otp;
  OtpVerificationData({
    required this.phoneNumber,
    required this.otp,
  });

 

  OtpVerificationData copyWith({
    String? phoneNumber,
    String? otp,
  }) {
    return OtpVerificationData(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'otp': otp,
    };
  }

  factory OtpVerificationData.fromMap(Map<String, dynamic> map) {
    return OtpVerificationData(
      phoneNumber: map['phoneNumber'] ?? '',
      otp: map['otp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpVerificationData.fromJson(String source) => OtpVerificationData.fromMap(json.decode(source));

  @override
  String toString() => 'OtpVerificationData(phoneNumber: $phoneNumber, otp: $otp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OtpVerificationData &&
      other.phoneNumber == phoneNumber &&
      other.otp == otp;
  }

  @override
  int get hashCode => phoneNumber.hashCode ^ otp.hashCode;
}
