class CargoSubCategoryEntity {
  final int id;
  final int? category;
  final String nameAr;
  final String nameEn;
  final String capacity;
  final String image;

  CargoSubCategoryEntity({
    required this.id,
    this.category,
    required this.nameAr,
    required this.nameEn,
    required this.capacity,
    required this.image,
  });
}
