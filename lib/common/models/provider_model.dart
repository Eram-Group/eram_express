import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:eram_express_shared/data/configurations/models/country_model.dart';
import '../../features/customer/data/models/wallet_model.dart';
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
    this.image,
    required this.isActive,
    required this.country,
    required this.wallet,
    required this.rating,
  });





  ProviderModel copyWith({
    int? id,
    String? phoneNumber,
    String? fullName,
    ValueGetter<String?>? image,
    bool? isActive,
    CountryModel? country,
    WalletModel? wallet,
    RatingModel? rating,
  }) {
    return ProviderModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      image: image != null ? image() : this.image,
      isActive: isActive ?? this.isActive,
      country: country ?? this.country,
      wallet: wallet ?? this.wallet,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'image': image,
      'isActive': isActive,
      'country': country.toMap(),
      'wallet': wallet.toMap(),
      'rating': rating.toMap(),
    };
  }

  factory ProviderModel.fromMap(Map<String, dynamic> map) {
    return ProviderModel(
      id: map['id']?.toInt() ?? 0,
      phoneNumber: map['phoneNumber'] ?? '',
      fullName: map['fullName'] ?? '',
      image: map['image'],
      isActive: map['isActive'] ?? false,
      country: CountryModel.fromMap(map['country']),
      wallet: WalletModel.fromMap(map['wallet']),
      rating: RatingModel.fromMap(map['rating']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderModel.fromJson(String source) => ProviderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProviderModel(id: $id, phoneNumber: $phoneNumber, fullName: $fullName, image: $image, isActive: $isActive, country: $country, wallet: $wallet, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProviderModel &&
      other.id == id &&
      other.phoneNumber == phoneNumber &&
      other.fullName == fullName &&
      other.image == image &&
      other.isActive == isActive &&
      other.country == country &&
      other.wallet == wallet &&
      other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      phoneNumber.hashCode ^
      fullName.hashCode ^
      image.hashCode ^
      isActive.hashCode ^
      country.hashCode ^
      wallet.hashCode ^
      rating.hashCode;
  }
}
