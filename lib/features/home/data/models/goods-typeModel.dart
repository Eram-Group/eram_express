class GoodModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;
  final DateTime createdAt;

  GoodModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.createdAt,
  });

  // Factory constructor to create an instance from JSON
  factory GoodModel.fromJson(Map<String, dynamic> json) {
    return GoodModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}