import 'package:eram_express/common/entities/provider_entity.dart';
import 'package:eram_express/common/viewmodels/rating_view_model.dart';

class ProviderViewModel
{
   final String fullName;
  final String? image;
  final RatingViewModel rating;

  ProviderViewModel({
    required this.fullName,
    required this.image,
    required this.rating,
  });

  factory ProviderViewModel.fromEntity(ProviderEntity entity)
  {
    return ProviderViewModel(
    fullName: entity.fullName,
    image: entity.image,
    rating:RatingViewModel.fromEntity(entity.rating));
  }
}