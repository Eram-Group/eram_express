import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/di.dart';
import '../../../../../common/domain/repositories/configurations_repository.dart';
import '../../../../domain/objects/login_form_data.dart';
import '../../../../domain/services/authentication_service.dart';
import '../otp/otp_view.dart';
import '../../modals/select_country_modal.dart';
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
    final countries = await _configurationsRepository.getCountries();
    countries.fold(
      (error) => emit(state.copyWith(countries: null)),
      (data) => emit(state.copyWith(
        countries: data,
        selectedCountry: data.first,
      )),
    );
  }

  void phoneNumberChanged(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber.replaceAll(' ', '')));
  }

  Future<void> _countryCodeButtonOnClicked(BuildContext context) async {
    if (state.countries == null) return init();

    final selection = await showModalBottomSheet<CountryEntity>(
      context: context,
      builder: (context) => SelectCountryModal(
        countries: state.countries!,
      ),
    );

    if (selection != null) {
      emit(state.copyWith(selectedCountry: selection));
    }
  }

  _loginButtonOnClicked() async {
    emit(state.copyWith(loading: true));

    final phoneNumber = state.selectedCountry!.phoneCode + state.phoneNumber;
    await _authenticationService.sendOtp(
      phoneNumber: phoneNumber,
      onOtpSent: () {
        emit(state.copyWith(loading: false));
        mainNavigationService.to(
          OtpView.route,
          OtpViewArguments(
            loginFormData: LoginFormData(
              phoneNumber: phoneNumber,
            ),
          ),
        );
      },
      onOtpFailed: () => emit(state.copyWith(loading: false)),
    );

    emit(state.copyWith(loading: false));
  }
}