import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/data/configurations/repositories/configurations_repository.dart';
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
        super(LoginViewState(status: LogInStatus.initial));

  Future<void> init() async {
    try {
      final countries = await _configurationsRepository.getCountries();
      emit(
        state.copyWith(
          selectedCountry: countries.first,
        ),
      );
    } on ServerException catch (e) {
      LoginViewState(
          status: LogInStatus.countryError,
          errorMessage: "Failed to get Countries");
    }
  }

  void phoneNumberChanged(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber.replaceAll(' ', '')));
  }

  bool enabledButton() {
    logger.debug(state.selectedCountry.toString());
    logger.debug(state.phoneNumber!);

    if (state.selectedCountry != null &&
        state.phoneNumber!.length == state.selectedCountry!.numberLength) {
      return true;
    } else {
      return false;
    }
  }

  bool phoneNumberFieldEnabled() {
    return state.selectedCountry != null && !state.isLoading;
  }

  Future<void> countryCodeButtonOnClicked(BuildContext context) async {
    try {
      final countries = await _configurationsRepository.getCountries();
      final selection = await SelectCountryModal(
        countries: countries,
        selectedCountry: state.selectedCountry!,
      ).show(context);
      if (selection != null) {
        emit(state.copyWith(selectedCountry: selection));
      }
    } catch (e) {
      logger.debug(e.toString());
    }
  }

  Future<void> loginButtonOnClicked(BuildContext context) async {
    final phoneNumber =
        '${state.selectedCountry?.phoneCode ?? ''}${state.phoneNumber ?? ''}';
    try {
      emit(state.copyWith(status: LogInStatus.loading));
      await _authenticationService.sendOtp(phoneNumber: phoneNumber);
      emit(state.copyWith(
        status: LogInStatus.success,
        phoneNumber: phoneNumber,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LogInStatus.error,
        serverException: e as ServerException,
      ));
    }
  }
}
