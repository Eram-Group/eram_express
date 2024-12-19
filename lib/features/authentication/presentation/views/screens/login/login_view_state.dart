import 'package:eram_express_shared/core/api/server_expection.dart';
import 'package:eram_express_shared/data/configurations/models/country_model.dart';



enum LogInStatus {
  initial,
  loading,
  error,
  countryError,
  success,
}

extension LoginViewStateX on LoginViewState {
 
  bool get isInitial => status == LogInStatus.initial;
  bool get isLoading => status == LogInStatus.loading;
  bool get isSuccess => status == LogInStatus.success;
  bool get isError => status == LogInStatus.error;
  bool get isCountryError => status == LogInStatus.countryError;
 

}

class LoginViewState {
 
  final LogInStatus status;
  final String ?phoneNumber;
  final CountryModel? selectedCountry;
  final String ?errorMessage ;
  final List<CountryModel> ?countries;
  final ServerException ? serverException;
  LoginViewState({
     
    required this.status,
    this.phoneNumber = '',
    this.selectedCountry,
    this.errorMessage,
    this.serverException,
    this.countries,
  });
  LoginViewState copyWith
  ({
   LogInStatus? status,
   String ?phoneNumber,
  String ?errorMessage ,
  CountryModel? selectedCountry,
  ServerException ? serverException,
  List<CountryModel> ?countries,
  }) {
    return LoginViewState(
      status:  status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      errorMessage: errorMessage?? this.errorMessage,
      serverException: serverException??this.serverException,
      countries: countries??this.countries,
    );
  }
}
