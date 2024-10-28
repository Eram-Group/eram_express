class TermsModel {
  final String contentEn;
  final String contentAr;
  TermsModel({
    required this.contentEn,
    required this.contentAr,
  });

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      contentEn: json['content_en'] ?? '',
      contentAr: json['content_ar'] ?? '',
    );
  }
}
