import 'package:bloc/bloc.dart';
import 'package:eram_express/features/profile/presentation/views/language_presentation/language_view_state.dart';

import '../../../data/models/language_model.dart';


class LanguageViewModel extends Cubit<LanguageState> {
  LanguageViewModel() : super(const LanguageState(null));     // How i can get the current language?

  void selectLanguage(LanguageModel language) {
    emit(LanguageState(language));
  }
}
