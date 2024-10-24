import 'dart:async';
import 'package:eram_express/features/authentication/presentation/views/screens/complete_profile/complete_profile_view.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../home/presentation/views/home_view.dart';
import '../../../../domain/objects/otp_verification_data.dart';
import '../../../../domain/services/authentication_service.dart';
import 'otp_view_state.dart';


class OtpViewModel extends Cubit<OtpViewState> {
  final AuthenticationService _authenticationService;
  late final String _phoneNumber;

  OtpViewModel({
    required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super(OtpViewState());

  String get phoneNumber => _phoneNumber;

  void init({required String phoneNumber}) {
    _phoneNumber = phoneNumber;
    _startResendOtpTimer();
  }

  void _startResendOtpTimer() {
    emit(state.copyWith(canResendIn: kResendOtpInterval));
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.canResendIn == 0) {
          timer.cancel();
        } else {
          emit(state.copyWith(canResendIn: state.canResendIn - 1));
        }
      },
    );
  }

  Function(String) onOtpChanged() =>
      (String otp) => emit(state.copyWith(otp: otp));

  Function()? verifyButtonOnClicked(BuildContext context) =>
      !state.verifyButtonEnabled ? null : () => _verifyButtonOnClicked(context);

  Future<void> _verifyButtonOnClicked(BuildContext context) async {
    emit(state.copyWith(verifyingOtp: true));

    await _authenticationService.verifyOtp(
      data: OtpVerificationData(
        phoneNumber: _phoneNumber,
        otp: state.otp,
      ),
      onOtpVerified: (bool newCustomer) {
        emit(state.copyWith(verifyingOtp: false));

        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeView.route,
          (route) => false,
        );

        if (newCustomer) {
          logger.debug('New customer');
          Navigator.of(context).pushNamed(CompleteProfileView.route);
        }
      },
      onOtpVerificationFailed: (ApiError error) {
        emit(state.copyWith(verifyingOtp: false));

        ErrorModal.fromApiError(error).show(context);
      },
    );
  }

  void Function()? resendOtpOnClicked() =>
      !state.resendButtonEnabled ? null : _resendOtpOnClicked;

  Future<void> _resendOtpOnClicked() async {
    emit(state.copyWith(resendingOtp: true));
    await _authenticationService.sendOtp(
      phoneNumber: _phoneNumber,
      onOtpSent: () {
        _startResendOtpTimer();
        emit(state.copyWith(resendingOtp: false));
      },
    );
  }
}
