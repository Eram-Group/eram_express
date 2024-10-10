import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_view_state.freezed.dart';

@freezed
abstract class OtpViewState with _$OtpViewState {
  const OtpViewState._();
  factory OtpViewState({
    @Default('') String otp,
    @Default(false) bool loading,
  }) = _OtpViewState;

  bool get verifyButtonLoading => loading;
  bool get verifyButtonEnabled => otp.length == 4;
}
