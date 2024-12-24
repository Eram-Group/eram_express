
import 'package:flutter/widgets.dart';
import '../../../data/models/language_model.dart';

class LanguageState {
  final LanguageModel? selectedLanguage;
  LanguageState({
    this.selectedLanguage,
  });



  LanguageState copyWith({
    ValueGetter<LanguageModel?>? selectedLanguage,
  }) {
    return LanguageState(
      selectedLanguage: selectedLanguage != null ? selectedLanguage() : this.selectedLanguage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LanguageState &&
      other.selectedLanguage == selectedLanguage;
  }

  @override
  int get hashCode => selectedLanguage.hashCode;
}
