import '../../domain/entities/cargo_categories_entity.dart';

class CargoCategoryViewModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String imageUrl;

  CargoCategoryViewModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.imageUrl,
  });

  factory CargoCategoryViewModel.fromEntity(CargoCategoryEntity entity) {
    return CargoCategoryViewModel(
      id: entity.id,
      nameAr: entity.nameAr, 
      nameEn: entity.nameEn,
      imageUrl: entity.image,
    );
  }

}