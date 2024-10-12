import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/di.dart';
import '../../../../../common/domain/repositories/configurations_repository.dart';
import '../../../../domain/objects/login_form_data.dart';
import '../../../../domain/services/authentication_service.dart';
import '../../modals/select_country_modal.dart';
import '../otp/otp_view.dart';
import 'login_view_state.dart';

class LoginViewModel extends Cubit<LoginViewState> {
  final ConfigurationsRepository _configurationsRepository;
  final AuthenticationService _authenticationService;

  LoginViewModel({
    required ConfigurationsRepository configurationsRepository,
    required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        _configurationsRepository = configurationsRepository,
        super(LoginViewState());

  Function()? get loginButtonOnClicked =>
      !state.loginButtonEnabled ? null : _loginButtonOnClicked;

  Function()? countryCodeButtonOnClicked(BuildContext context) =>
      !state.countryCodeButtonEnabled
          ? null
          : () => _countryCodeButtonOnClicked(context);

  Future<void> init() async {
    final countries = await _configurationsRepository.countries;
    countries.fold(
      (error) {},
      (data) => emit(
        state.copyWith(
          selectedCountry: data.first,
        ),
      ),
    );
  }

  void phoneNumberChanged(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber.replaceAll(' ', '')));
  }

  Future<void> _countryCodeButtonOnClicked(BuildContext context) async {
    final countries = await _configurationsRepository.countries;
    countries.fold(
      (error) {},
      (data) async {
        final selection = await SelectCountryModal(
          countries: data,
          selectedCountry: state.selectedCountry!,
        ).show(context);

        if (selection != null) {
          emit(state.copyWith(selectedCountry: selection));
        }
      },
    );
  }

  _loginButtonOnClicked() async {
    emit(state.copyWith(sendingOtp: true));

    final phoneNumber = state.selectedCountry!.phoneCode + state.phoneNumber;

    await _authenticationService.sendOtp(
      phoneNumber: phoneNumber,
      onOtpSent: () {
        emit(state.copyWith(sendingOtp: false));
        mainNavigationService.to(
          OtpView.route,
          OtpViewArguments(
            loginFormData: LoginFormData(
              phoneNumber: phoneNumber,
            ),
          ),
        );
      },
      onOtpFailed: () => emit(state.copyWith(sendingOtp: false)),
    );

    emit(state.copyWith(sendingOtp: false));
  }
}
