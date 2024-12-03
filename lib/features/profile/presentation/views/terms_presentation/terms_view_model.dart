import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/profile_repository_impl.dart';
import 'terms_view_state.dart';

class TermsViewModel extends Cubit<TermViewState> {
  final ProfileRepository _profileRepository;

  TermsViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(TermsViewLoadingState());

  Future<void> getTerms() async {
    emit(TermsViewLoadingState());
    try
    {
    final result = await _profileRepository.getTerms();
    emit(TermsViewLoadedState(result));
    }
    catch(e)
    {
      emit(TermsViewErrorState());

    }

  }
}
