import 'dart:convert';

import 'package:eram_express/common/entities/rating_entity.dart';
import 'package:eram_express_shared/data/configurations/models/country_model.dart';

import '../../features/customer/data/models/wallet_model.dart';
import '../entities/provider_entity.dart';
import 'rating_model.dart';

class ProviderModel {
  final int id;
  final String phoneNumber;
  final String fullName;
  final String? image;
  final bool isActive;
  final CountryModel  country;
  final WalletModel wallet;
  final RatingModel rating;

  ProviderModel({
    required this.id,
    required this.phoneNumber,
    required this.fullName,
    required this.image,
    required this.isActive,
    required this.country,
    required this.wallet,
    required this.rating,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'],
      phoneNumber: json['phone_number'],
      fullName: json['full_name'],
      image: json['image'],
      isActive: json['is_active'],
      country: CountryModel.fromJson(json['country']),
      wallet: WalletModel.fromJson(json['wallet']),
      rating: RatingModel.fromJson(json['rating']),
    );
  }

  ProviderEntity toEntity()
  {
     
     return ProviderEntity(fullName: this.fullName, image: this.image, rating: this.rating.toEntity());
  }
}
