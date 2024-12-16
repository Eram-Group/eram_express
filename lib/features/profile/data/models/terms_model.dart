import 'dart:convert';

class TermsModel {
  final String contentEn;
  final String contentAr;
  TermsModel({
    required this.contentEn,
    required this.contentAr,
  });


  TermsModel copyWith({
    String? contentEn,
    String? contentAr,
  }) {
    return TermsModel(
      contentEn: contentEn ?? this.contentEn,
      contentAr: contentAr ?? this.contentAr,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contentEn': contentEn,
      'contentAr': contentAr,
    };
  }

  factory TermsModel.fromMap(Map<String, dynamic> map) {
    return TermsModel(
      contentEn: map['contentEn'] ?? '',
      contentAr: map['contentAr'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TermsModel.fromJson(String source) => TermsModel.fromMap(json.decode(source));

  @override
  String toString() => 'TermsModel(contentEn: $contentEn, contentAr: $contentAr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TermsModel &&
      other.contentEn == contentEn &&
      other.contentAr == contentAr;
  }

  @override
  int get hashCode => contentEn.hashCode ^ contentAr.hashCode;
}
