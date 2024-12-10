import 'package:dio/dio.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/domain/repositories/configurations_repository.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

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
    try {
      final countries = await _configurationsRepository.getCountries();
      emit(
        state.copyWith(
          selectedCountry: countries.first,
        ),
      );
    } on ServerException catch (e) 
    {
      
      //emit(state)
    }
  }

  void phoneNumberChanged(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber.replaceAll(' ', '')));
  }

  Future<void> _countryCodeButtonOnClicked(BuildContext context) async {
    final countries = await _configurationsRepository.getCountries();

    try {
      final selection = await SelectCountryModal(
        countries: countries,
        selectedCountry: state.selectedCountry!,
      ).show(context);
      if (selection != null) {
        emit(state.copyWith(selectedCountry: selection));
      }
    } catch (e) {}
  }

  _loginButtonOnClicked(BuildContext context) async {
    emit(state.copyWith(sendingOtp: true));

    final phoneNumber = state.selectedCountry!.phoneCode + state.phoneNumber;

    try {
      emit(state.copyWith(sendingOtp: false));
      await _authenticationService.sendOtp(phoneNumber: phoneNumber);
      Navigator.of(context).pushNamed(
        OtpView.route,
        arguments: OtpViewArguments(
          loginFormData: LoginFormData(
            phoneNumber: phoneNumber,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(sendingOtp: false));
      ErrorModal.fromApiError(e as ServerException).show(context);
    }
  }
}
