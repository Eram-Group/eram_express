import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/domain/repositories/configurations_repository.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../objects/login_form_data.dart';
import '../../../../data/services/authentication_service.dart';
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

  Function()? loginButtonOnClicked(BuildContext context) =>
      !state.loginButtonEnabled ? null : () => _loginButtonOnClicked(context);

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

  _loginButtonOnClicked(BuildContext context) async {
    emit(state.copyWith(sendingOtp: true));

    final phoneNumber = state.selectedCountry!.phoneCode + state.phoneNumber;

    await _authenticationService.sendOtp(
      phoneNumber: phoneNumber,
      onOtpSent: () {
        emit(state.copyWith(sendingOtp: false));
        Navigator.of(context).pushNamed(
          OtpView.route,
          arguments: OtpViewArguments(
            loginFormData: LoginFormData(
              phoneNumber: phoneNumber,
            ),
          ),
        );
      },
      onOtpFailed: (ApiError error) {
        emit(state.copyWith(sendingOtp: false));
        ErrorModal.fromApiError(error).show(context);
      },
    );

    emit(state.copyWith(sendingOtp: false));
  }
}
