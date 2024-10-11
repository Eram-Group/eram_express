import 'package:eram_express/app/di.dart';
import 'package:eram_express/features/home/presentation/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void init({required String phoneNumber}) => this.phoneNumber = phoneNumber;

  Function(String) get onOtpChanged =>
      (String otp) => emit(state.copyWith(otp: otp));

  Function()? get verifyButtonOnClicked =>
      !state.verifyButtonEnabled ? null : _verifyButtonOnClicked;

  Future<void> _verifyButtonOnClicked() async {
    emit(state.copyWith(loading: true));

    await _authenticationService.verifyOtp(
      data: OtpVerificationData(
        phoneNumber: phoneNumber,
        otp: state.otp,
      ),
      onOtpVerified: () {
        emit(state.copyWith(loading: false));
        mainNavigationService.clearStackAndNavigateTo(HomeView.route);
      },
      onOtpVerificationFailed: () {
        emit(state.copyWith(loading: false));
      },
    );
  }
}
