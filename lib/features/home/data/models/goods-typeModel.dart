
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

  
}
