import 'dart:convert';


class RatingModel {
  final double averageRating;
  final int totalRatings;
  RatingModel({
    required this.averageRating,
    required this.totalRatings,
  });


 

  RatingModel copyWith({
    double? averageRating,
    int? totalRatings,
  }) {
    return RatingModel(
      averageRating: averageRating ?? this.averageRating,
      totalRatings: totalRatings ?? this.totalRatings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'averageRating': averageRating,
      'totalRatings': totalRatings,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
       averageRating: map['average_rating'],
      totalRatings: map['total_ratings'],
    
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingModel.fromJson(String source) => RatingModel.fromMap(json.decode(source));

  @override
  String toString() => 'RatingModel(averageRating: $averageRating, totalRatings: $totalRatings)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RatingModel &&
      other.averageRating == averageRating &&
      other.totalRatings == totalRatings;
  }

  @override
  int get hashCode => averageRating.hashCode ^ totalRatings.hashCode;
}


