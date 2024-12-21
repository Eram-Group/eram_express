import 'package:flutter/widgets.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';

enum TermsStatus { initial, loading, loaded, error }

extension TermViewStateX  on TermViewState {
  bool get isInitial => status == TermsStatus.initial;
  bool get isLoading => status == TermsStatus.loading;
  bool get isError => status == TermsStatus.error;
  bool get isLoaded => status == TermsStatus.loaded;
}



class TermViewState {
  final  TermsStatus  status;
  final TermsModel? termsContent;
  final String? errorMessage;
  TermViewState({
    required this.status,
    this.termsContent,
    this.errorMessage,
  });

  

  TermViewState copyWith({
    TermsStatus? status,
    TermsModel? termsContent,
   String ? errorMessage,
  }) {
    return TermViewState(
      status: status ?? this.status,
      termsContent: termsContent ?? this.termsContent,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }



  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TermViewState &&
      other.status == status &&
      other.termsContent == termsContent &&
      other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ termsContent.hashCode ^ errorMessage.hashCode;
}
