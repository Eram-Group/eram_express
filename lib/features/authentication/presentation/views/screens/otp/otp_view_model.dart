import 'package:flutter_bloc/flutter_bloc.dart';

import 'otp_view_state.dart';

class OtpViewModel extends Cubit<OtpViewState> {
  OtpViewModel() : super(OtpViewState());

  Function(String) get onOtpChanged =>
      (String otp) => emit(state.copyWith(otp: otp));
}
