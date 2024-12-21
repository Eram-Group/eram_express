import 'package:equatable/equatable.dart';
import 'package:eram_express/features/profile/data/models/about_us_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';

enum TermsStatus { initial, loading, loaded, error }

extension TermViewStateX  on TermViewState {
  bool get isInitial => status == TermsStatus.initial;
  bool get isLoading => status == TermsStatus.loading;
  bool get isError => status == TermsStatus.error;
  bool get isLoaded => status == TermsStatus.loaded;
}



class TermViewState extends Equatable {
  final  TermsStatus  status;
  final TermsModel? termsContent;
  final String? errorMessage;

  const TermViewState({
    required this.status,
    this.termsContent,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, termsContent, errorMessage];

  TermViewState copyWith({
   TermsStatus ? status,
  TermsModel? termsContent,
    String? errorMessage,
  }) {
    return TermViewState(
      status: status ?? this.status,
      termsContent: termsContent ?? this.termsContent,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
