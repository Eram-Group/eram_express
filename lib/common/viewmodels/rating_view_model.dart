import 'package:eram_express/common/entities/rating_entity.dart';

class RatingViewModel {
  final double averageRating;
  final int totalRatings;

  RatingViewModel({
    required this.averageRating,
    required this.totalRatings,
  });

 factory RatingViewModel.fromEntity(RatingEntity entity)
 {
  return RatingViewModel(averageRating: entity.averageRating, totalRatings: entity.totalRatings);
 }

}
