import 'dart:convert';


class LanguageModel {
  final String language;
  final String flag;
  LanguageModel({
    required this.language,
    required this.flag,
  });



 

  LanguageModel copyWith({
    String? language,
    String? flag,
  }) {
    return LanguageModel(
      language: language ?? this.language,
      flag: flag ?? this.flag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'flag': flag,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      language: map['language'] ?? '',
      flag: map['flag'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageModel.fromJson(String source) => LanguageModel.fromMap(json.decode(source));

  @override
  String toString() => 'LanguageModel(language: $language, flag: $flag)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LanguageModel &&
      other.language == language &&
      other.flag == flag;
  }

  @override
  int get hashCode => language.hashCode ^ flag.hashCode;
}
