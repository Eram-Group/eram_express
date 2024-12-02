
import 'cargo-subcategoryModel.dart';

class CargoCategoryModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;
  final List<CargoSubCategoryModel> subcategory;

  CargoCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.subcategory,
  });

  factory CargoCategoryModel.fromJson(Map<String, dynamic> json) {
    return CargoCategoryModel(
      id: json['id'] as int,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String,
      image: json['image'] as String,
      subcategory: (json['subcategory'] as List<dynamic>?) ?.map((item) =>CargoSubCategoryModel.fromJson(item as Map<String, dynamic>)).toList() ?? [],
    );
  }

}
