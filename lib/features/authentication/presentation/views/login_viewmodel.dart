import 'package:equatable/equatable.dart';
import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/domain/repositories/configurations_repository.dart';

class LoginFormState extends Equatable {
  final bool buttonLoading;
  final String phoneNumber;
  final CountryEntity? selectedCountry;

  const LoginFormState({
    required this.buttonLoading,
    required this.phoneNumber,
    this.selectedCountry,
  });

  factory LoginFormState.initial() => const LoginFormState(
        phoneNumber: '',
        buttonLoading: false,
      );

  @override
  List<Object?> get props => [
        buttonLoading,
        phoneNumber,
        selectedCountry,
      ];

  LoginFormState copyWith({
    bool? buttonLoading,
    String? phoneNumber,
    CountryEntity? selectedCountry,
  }) {
    return LoginFormState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      buttonLoading: buttonLoading ?? this.buttonLoading,
    );
  }
}

class LoginViewModel extends Cubit<LoginFormState> {
  final ConfigurationsRepository configurationsRepository;

  LoginViewModel({
    required this.configurationsRepository,
  }) : super(LoginFormState.initial());

  Future<List<CountryEntity>> get countries async =>
      await configurationsRepository.getCountries();

  Future<void> init() async {
    final countries = await configurationsRepository.getCountries();
    emit(state.copyWith(selectedCountry: countries.first));
  }

  bool get isLoginButtonEnabled =>
      isCountryCodeButtonEnabled &&
      state.phoneNumber.length == state.selectedCountry!.numberLength;

  bool get isCountryCodeButtonEnabled => state.selectedCountry != null;

  Future<void> countryCodeButtonOnClicked() async {}

  void loginButtonOnClicked() async {
    emit(state.copyWith(buttonLoading: true));

    // TODO: Use authentication service to login
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(buttonLoading: false));
  }

  void phoneNumberChanged(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber.replaceAll(' ', '')));
  }
}
