import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eram_express/features/profile/domain/repositories/profile_repository.dart';
import 'package:eram_express/features/profile/presentation/views/about_us_presentation/about_us_view_state.dart';

import 'terms_view_state.dart';

class TermsViewModel extends Cubit<TermViewState> {
  final ProfileRepository _profileRepository;

  TermsViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(TermsViewLoadingState());

  Future<void> getTerms() async {
    emit(TermsViewLoadingState());
    final result = await _profileRepository.getterms();
    result.fold(
      (error) => emit(TermsViewErrorState()),
      (data) => emit(TermsViewLoadedState(data)),
    );
  }
}
