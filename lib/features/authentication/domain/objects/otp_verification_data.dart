import 'package:equatable/equatable.dart';

class OtpVerificationData extends Equatable {
  final String phoneNumber;
  final String otp;

  const OtpVerificationData({
    required this.phoneNumber,
    required this.otp,
  });

  @override
  List<Object> get props => [phoneNumber, otp];
}
