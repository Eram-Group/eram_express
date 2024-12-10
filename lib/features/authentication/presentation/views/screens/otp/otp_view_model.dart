import 'dart:async';

import 'package:eram_express/features/authentication/presentation/views/screens/complete_profile/complete_profile_view.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../home/presentation/views/home_view.dart';
import '../../../objects/otp_verification_data.dart';
import '../../../../data/services/authentication_service.dart';
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

    try {
      final response = await _authenticationService.verifyOtp(
        data: OtpVerificationData(
          phoneNumber: _phoneNumber,
          otp: state.otp,
        ),
      );

      _authenticationService.savingToken(response.response);
      // Stop showing the loading state
      emit(state.copyWith(verifyingOtp: false));

      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeView.route,
        (route) => false,
      );
      if (response.isNewCustomer) {
        logger.debug('New customer');
        Navigator.of(context).pushNamed(CompleteProfileView.route);
      }
    } catch (e) {
      // Handle errors
      emit(state.copyWith(verifyingOtp: false));
      ErrorModal.fromApiError(e as ServerException).show(context);
    }
  }

  void Function()? resendOtpOnClicked() =>
      !state.resendButtonEnabled ? null : _resendOtpOnClicked;

  Future<void> _resendOtpOnClicked() async {
    emit(state.copyWith(resendingOtp: true));
    _authenticationService.sendOtp(
      phoneNumber: _phoneNumber,
    );
    _startResendOtpTimer();
    emit(state.copyWith(resendingOtp: false));
  }
}
