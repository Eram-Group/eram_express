import 'package:equatable/equatable.dart';

class LanguageModel extends Equatable {
  final String language;
  final String flag;

  const LanguageModel({
    required this.language,
    required this.flag,
  });

  @override
  List<Object?> get props => [language];
}
