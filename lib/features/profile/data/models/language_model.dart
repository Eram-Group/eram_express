import 'dart:convert';

class LanguageModel {
  final String language;
  final String flag;
  final String languageCode;
  LanguageModel({
    required this.language,
    required this.flag,
    required this.languageCode,
  });




  LanguageModel copyWith({
    String? language,
    String? flag,
    String? languageCode,
  }) {
    return LanguageModel(
      language: language ?? this.language,
      flag: flag ?? this.flag,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'flag': flag,
      'languageCode': languageCode,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      language: map['language'] ?? '',
      flag: map['flag'] ?? '',
      languageCode: map['languageCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageModel.fromJson(String source) => LanguageModel.fromMap(json.decode(source));

  @override
  String toString() => 'LanguageModel(language: $language, flag: $flag, languageCode: $languageCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LanguageModel &&
      other.language == language &&
      other.flag == flag &&
      other.languageCode == languageCode;
  }

  @override
  int get hashCode => language.hashCode ^ flag.hashCode ^ languageCode.hashCode;
}
