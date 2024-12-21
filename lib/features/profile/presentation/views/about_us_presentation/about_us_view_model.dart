
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eram_express/features/profile/presentation/views/about_us_presentation/about_us_view_state.dart';

import '../../../data/repositories/profile_repository_impl.dart';

class AboutUsViewModel extends Cubit<AboutUsViewState> {
  final ProfileRepository _profileRepository;

  AboutUsViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const AboutUsViewState(status: AboutUsStatus.initial));

  Future<void> getAboutUs() async {
    emit(state.copyWith(status: AboutUsStatus.loading));
    try
    {
            final result = await _profileRepository.getAboutUs();
            emit(state.copyWith(status: AboutUsStatus.loaded,
           aboutUsModel: result));
    }
    catch(e)
    {
             emit(state.copyWith(status: AboutUsStatus.error));
    }
  
   
  }
}

