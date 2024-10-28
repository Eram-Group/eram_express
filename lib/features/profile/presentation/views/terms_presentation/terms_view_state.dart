import 'package:equatable/equatable.dart';
import 'package:eram_express/features/profile/data/models/about_us_model.dart';
import 'package:eram_express/features/profile/data/models/terms_model.dart';

abstract class TermViewState extends Equatable {
  const TermViewState();

  @override
  List<Object?> get props => [];
}

class TermsViewLoadedState extends TermViewState {

  final TermsModel termsContent; 

  const TermsViewLoadedState(this.termsContent); 

  @override
  List<Object?> get props => [termsContent]; 
}

class TermsViewLoadingState
    extends TermViewState {} 

class TermsViewErrorState
    extends TermViewState {} 
