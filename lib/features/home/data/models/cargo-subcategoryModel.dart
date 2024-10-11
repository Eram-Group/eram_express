class CargoSubCategoryModel {
  final int id;
  final int category;
  final String nameAr;
  final String nameEn;
  final String capacity;
  final String image;
  final DateTime createdAt;

 CargoSubCategoryModel({
    required this.id,
    required this.category,
    required this.nameAr,
    required this.nameEn,
    required this.capacity,
    required this.image,
    required this.createdAt,
  });

 
  factory CargoSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return CargoSubCategoryModel(
      id: json['id'],
      category: json['category'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      capacity: json['capacity'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}