import '../../domain/entities/cargo_categories_entity.dart';

class CargoCategoryModel
{
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;

  CargoCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,           
    required this.image,
  });

  factory CargoCategoryModel.fromJson(Map<String, dynamic> json) {
    return CargoCategoryModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      image: json['image'],
    );
  }
  CargoCategoryEntity toEntity() {
    return CargoCategoryEntity(
      id: this.id,
      nameAr: this.nameAr,
      nameEn: this.nameEn,
      image: this.image,
    );
  }
}