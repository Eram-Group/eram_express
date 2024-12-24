import 'package:bloc/bloc.dart';
import 'package:eram_express/features/profile/presentation/views/language_presentation/language_view_state.dart';

import '../../../data/models/language_model.dart';


class LanguageViewModel extends Cubit<LanguageState> {
  LanguageViewModel() : super(LanguageState());    

  void selectLanguage(LanguageModel language)
   {
    //Question    المفروض هنا  اغير الlangue  
    // في ال local cubit 
    //فهل ينفع اصلا

    emit(LanguageState(selectedLanguage: language));
  }
}
