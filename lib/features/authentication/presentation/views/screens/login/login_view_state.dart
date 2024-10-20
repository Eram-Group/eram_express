import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_view_state.freezed.dart';

@freezed
abstract class LoginViewState with _$LoginViewState {
  const LoginViewState._();

  factory LoginViewState({
    @Default(false) bool sendingOtp,
    @Default('') String phoneNumber,
    CountryEntity? selectedCountry,
  }) = _LoginViewState;

  bool get loginButtonLoading => sendingOtp;
  bool get phoneNumberFieldEnabled => selectedCountry != null && !sendingOtp;
  bool get countryCodeButtonEnabled => selectedCountry != null;
  bool get loginButtonEnabled =>
      selectedCountry != null &&
      phoneNumber.length == selectedCountry!.numberLength;
}
