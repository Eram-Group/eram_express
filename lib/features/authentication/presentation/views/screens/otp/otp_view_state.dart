
const kResendOtpInterval = 60;

class OtpViewState {
  final int canResendIn;
  final String otp;
  final bool verifyingOtp;
  final bool resendingOtp;

  const OtpViewState({
    this.canResendIn = kResendOtpInterval,
    this.otp = '',
    this.verifyingOtp = false,
    this.resendingOtp = false,
  });

  bool get verifyButtonLoading => verifyingOtp || resendingOtp;
  bool get verifyButtonEnabled => otp.length == 4 && !verifyButtonLoading;
  bool get pinEnabled => !verifyingOtp && !resendingOtp;
  bool get resendButtonEnabled => canResendIn == 0 && !resendingOtp;

  OtpViewState copyWith({
    int? canResendIn,
    String? otp,
    bool? verifyingOtp,
    bool? resendingOtp,
  }) {
    return OtpViewState(
      canResendIn: canResendIn ?? this.canResendIn,
      otp: otp ?? this.otp,
      verifyingOtp: verifyingOtp ?? this.verifyingOtp,
      resendingOtp: resendingOtp ?? this.resendingOtp,
    );
  }


  
}

