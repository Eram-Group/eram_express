import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_view_state.freezed.dart';

@freezed
abstract class LoginViewState with _$LoginViewState {
  const LoginViewState._();

  factory LoginViewState({
    @Default(false) bool loading,
    @Default('') String phoneNumber,
    CountryEntity? selectedCountry,
    List<CountryEntity>? countries,
  }) = _LoginViewState;

  bool get phoneNumberFieldEnabled => selectedCountry != null && !loading;
  bool get countryCodeButtonEnabled => selectedCountry != null;
  bool get loginButtonLoading => loading;
  bool get loginButtonEnabled =>
      selectedCountry != null &&
      phoneNumber.length == selectedCountry!.numberLength;
}
