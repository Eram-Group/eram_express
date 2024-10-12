import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../home/presentation/views/home_view.dart';
import '../../../../domain/objects/otp_verification_data.dart';
import '../../../../domain/services/authentication_service.dart';
import 'otp_view_state.dart';

class OtpViewModel extends Cubit<OtpViewState> {
  final AuthenticationService _authenticationService;
  late final String phoneNumber;

  OtpViewModel({
    required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super(OtpViewState());

  Function(String) get onOtpChanged =>
      (String otp) => emit(state.copyWith(otp: otp));

  Function()? verifyButtonOnClicked(BuildContext context) =>
      !state.verifyButtonEnabled ? null : () => _verifyButtonOnClicked(context);

  void init({required String phoneNumber}) => this.phoneNumber = phoneNumber;

  Future<void> _verifyButtonOnClicked(BuildContext context) async {
    emit(state.copyWith(loading: true));

    await _authenticationService.verifyOtp(
      data: OtpVerificationData(
        phoneNumber: phoneNumber,
        otp: state.otp,
      ),
      onOtpVerified: () {
        emit(state.copyWith(loading: false));
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeView.route,
          (route) => false,
        );
      },
      onOtpVerificationFailed: () {
        emit(state.copyWith(loading: false));
      },
    );
  }
}
