class AboutUsModel
 {
  final String contentEn;
  final String contentAr;
  AboutUsModel({
    required this.contentEn,
    required this.contentAr,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      contentEn: json['content_en'] ?? '', 
      contentAr: json['content_ar'] ?? '',
    );
  }
}
