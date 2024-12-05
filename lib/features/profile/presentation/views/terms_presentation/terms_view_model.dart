import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/profile_repository_impl.dart';
import 'terms_view_state.dart';

class TermsViewModel extends Cubit<TermViewState> {
  final ProfileRepository _profileRepository;

  TermsViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const TermViewState(status:  TermsStatus.initial));

  Future<void> getTerms() async {
    emit(state.copyWith(status: TermsStatus.loading));
    try
    {
    final result = await _profileRepository.getTerms();
    emit(state.copyWith(status: TermsStatus.loaded,termsContent:result));
    }
    catch(e)
    {
     emit(state.copyWith(status: TermsStatus.error ,errorMessage: "Fail to get terms & conditions")); // error depend on the language?

    }

  }
}
