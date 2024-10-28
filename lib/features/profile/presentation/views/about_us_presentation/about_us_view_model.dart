
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eram_express/features/profile/domain/repositories/profile_repository.dart';
import 'package:eram_express/features/profile/presentation/views/about_us_presentation/about_us_view_state.dart';

class AboutUsViewModel extends Cubit<AboutUsViewState> {
  final ProfileRepository _profileRepository;

  AboutUsViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(AboutUsViewLoadingState());

  Future<void> getAboutUs() async {
    emit(AboutUsViewLoadingState());
    final result = await _profileRepository.getAboutUs();
    result.fold(
      (error) => emit(AboutUsViewErrorState()),
      (data) => emit(AboutUsViewLoadedState(data)),
    );
  }
}

