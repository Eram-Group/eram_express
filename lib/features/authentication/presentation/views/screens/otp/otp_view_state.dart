import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_view_state.freezed.dart';

const kResendOtpInterval = 60;

@freezed
abstract class OtpViewState with _$OtpViewState {
  const OtpViewState._();
  factory OtpViewState({
    @Default(kResendOtpInterval) int canResendIn,
    @Default('') String otp,
    @Default(false) bool verifyingOtp,
    @Default(false) bool resendingOtp,
  }) = _OtpViewState;

  bool get verifyButtonLoading => verifyingOtp || resendingOtp;
  bool get verifyButtonEnabled => otp.length == 4 && !verifyButtonLoading;
  bool get pinEnabled => !verifyingOtp && !resendingOtp;
  bool get resendButtonEnabled => canResendIn == 0 && !resendingOtp;
}
