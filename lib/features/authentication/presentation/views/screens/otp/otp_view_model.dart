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
        super(OtpViewState(status: OtpViewStatus.initial));

  String get phoneNumber => _phoneNumber;
  Function(String) onOtpChanged() =>
      (String otp) => emit(state.copyWith(otp: otp));

  void init({required String phoneNumber}) {
    _phoneNumber = phoneNumber;
    _startResendOtpTimer();
  }

  void _startResendOtpTimer() {
    emit(state.copyWith(
        status: OtpViewStatus.timing, canResendIn: kResendOtpInterval));
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.canResendIn == 0) {
          timer.cancel();
        } else {
          emit(state.copyWith(
              status: OtpViewStatus.timing,
              canResendIn: state.canResendIn! - 1));
        }
      },
    );
  }

  Future<void> verifyButtonOnClicked(BuildContext context) async {
    emit(state.copyWith(status: OtpViewStatus.loading));
    try {
      final response = await _authenticationService.verifyOtp(
        data: OtpVerificationData(
          phoneNumber: _phoneNumber,
          otp: state.otp!,
        ),
      );
      _authenticationService.savingToken(response.response);

      if (response.isNewCustomer) {
        emit(
            state.copyWith(status: OtpViewStatus.success, isNewCustomer: true));
      } else {
        emit(state.copyWith(
            status: OtpViewStatus.success, isNewCustomer: false));
      }
    } catch (e) {
      logger.debug(e.toString());
      emit(state.copyWith(
          status: OtpViewStatus.error, serverException: e as ServerException));
    }
  }

  //  ايه الاحسن ان اعمل فانكشن كده ولا اني اعمل مثلا
  // state = timingOut
  bool resendButtonEnabled() {
    if (state.canResendIn == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> resendOtpOnClicked() async {
    emit(state.copyWith(status: OtpViewStatus.loading));
    try {
      await _authenticationService.sendOtp(
        phoneNumber: _phoneNumber,
      );
      _startResendOtpTimer();
    } on ServerException catch (e) {
      emit(state.copyWith(status: OtpViewStatus.error, serverException: e));
    }
  }
}
