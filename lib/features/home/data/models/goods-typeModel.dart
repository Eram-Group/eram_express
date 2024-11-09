import '../../domain/entities/goods_entity.dart';

class GoodModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;


  GoodModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,

  });

  factory GoodModel.fromJson(Map<String, dynamic> json) {
    return GoodModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      image: json['image'],
   
    );
  }
  GoodEntity toEntity() {
    return GoodEntity(
      id: this.id,
      nameAr: this.nameAr,
      nameEn: this.nameEn,
      image: this.image,
    );
  }

}
