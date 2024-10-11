class CargoCategoryModel
{
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;

  CargoCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,            // هل في طريق لحوار ال localiztion هنا؟
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

}