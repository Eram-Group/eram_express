import 'dart:convert';

class AboutUsModel {
  final String contentEn;
  final String contentAr;
  AboutUsModel({
    required this.contentEn,
    required this.contentAr,
  });


  AboutUsModel copyWith({
    String? contentEn,
    String? contentAr,
  }) {
    return AboutUsModel(
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

  factory AboutUsModel.fromMap(Map<String, dynamic> map) {
    return AboutUsModel(
      contentEn: map['contentEn'] ?? '',
      contentAr: map['contentAr'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutUsModel.fromJson(String source) => AboutUsModel.fromMap(json.decode(source));

  @override
  String toString() => 'AboutUsModel(contentEn: $contentEn, contentAr: $contentAr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AboutUsModel &&
      other.contentEn == contentEn &&
      other.contentAr == contentAr;
  }

  @override
  int get hashCode => contentEn.hashCode ^ contentAr.hashCode;
}
