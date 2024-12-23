import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/data/configurations/repositories/configurations_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/services/authentication_service.dart';
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
        super(LoginViewState(status: LogInStatus.initial));

  Future<void> init() async {
    try {
      logger.debug("enter in init");
      final countries = await _configurationsRepository.getCountries();
      logger.debug("before ${state.selectedCountry}".toString());

      emit(
        state.copyWith(
          countries: countries,
          selectedCountry: countries.first,
        ),
      );

      logger.debug("after ${state.selectedCountry}".toString());
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
      final selection = await SelectCountryModal(
        countries: state.countries!,
        selectedCountry: state.selectedCountry!,
      ).show(context);
      if (selection != null) {
        emit(state.copyWith(selectedCountry: selection));
      }
    } catch (e) {}
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
