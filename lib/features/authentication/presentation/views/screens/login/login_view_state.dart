import 'package:eram_express_shared/data/configurations/models/country_model.dart';

class LoginViewState {
  final bool sendingOtp;
  final String phoneNumber;
  final CountryModel? selectedCountry;

  LoginViewState({
    this.sendingOtp = false,    //instead of enum
    this.phoneNumber = '',
    this.selectedCountry,
  });

  bool get loginButtonLoading => sendingOtp;

  bool get phoneNumberFieldEnabled => selectedCountry != null && !sendingOtp;

  bool get countryCodeButtonEnabled => selectedCountry != null;

  bool get loginButtonEnabled =>
      selectedCountry != null &&
      phoneNumber.length == selectedCountry!.numberLength;

  LoginViewState copyWith({
    bool? sendingOtp,
    String? phoneNumber,
    CountryModel? selectedCountry,
  }) {
    return LoginViewState(
      sendingOtp: sendingOtp ?? this.sendingOtp,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountry: selectedCountry ?? this.selectedCountry,
    );
  }
}
