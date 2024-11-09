import '../../domain/entities/cargo_subcategory_entity.dart';

class CargoSubCategoryViewModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String capacity;
  final String imageUrl;

  CargoSubCategoryViewModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.capacity,
    required this.imageUrl,
  });

  factory CargoSubCategoryViewModel.fromEntity(CargoSubCategoryEntity entity) {
    return CargoSubCategoryViewModel(
      id: entity.id,
      nameAr: entity.nameAr,
      nameEn: entity.nameEn,
      capacity: entity.capacity,
      imageUrl: entity.image,
    );
  }

}