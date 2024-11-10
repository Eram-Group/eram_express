import 'rating_entity.dart';
class ProviderEntity {
  final String fullName;
  final String?image;
  final RatingEntity rating;

  ProviderEntity({
    required this.fullName,
    required this.image,
    required this.rating,
  });

}
