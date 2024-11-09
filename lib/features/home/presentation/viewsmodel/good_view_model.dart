import '../../domain/entities/goods_entity.dart';

class GoodViewModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String imageUrl;

  GoodViewModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.imageUrl,
  });

  factory GoodViewModel.fromEntity(GoodEntity entity) {
    return GoodViewModel(
      id: entity.id,
      nameAr: entity.nameAr,
      nameEn: entity.nameEn,
      imageUrl: entity.image,
    );
  }

}
