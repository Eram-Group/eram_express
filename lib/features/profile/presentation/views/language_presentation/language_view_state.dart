import 'package:equatable/equatable.dart';

import '../../../data/models/language_model.dart';

class LanguageState extends Equatable {
  final LanguageModel? selectedLanguage;

  const LanguageState(this.selectedLanguage);

  @override
  List<Object?> get props => [selectedLanguage];
}
