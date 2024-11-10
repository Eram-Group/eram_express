import 'package:eram_express/common/entities/rating_entity.dart';

class RatingModel {
  final double averageRating;
  final int totalRatings;

  RatingModel({
    required this.averageRating,
    required this.totalRatings,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      averageRating: json['average_rating'],
      totalRatings: json['total_ratings'],
    );
  }

  RatingEntity toEntity()
  {
    return RatingEntity(averageRating: this.averageRating, totalRatings: this.totalRatings);
  }
}
