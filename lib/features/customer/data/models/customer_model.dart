import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:eram_express_shared/data/configurations/models/country_model.dart';

import 'wallet_model.dart';

class CustomerModel {
  final int id;
  final String phoneNumber;
  final String fullName;
  final String? image;
  final bool isActive;
  final CountryModel country;
  final WalletModel wallet;
  CustomerModel({
    required this.id,
    required this.phoneNumber,
    required this.fullName,
    this.image,
    required this.isActive,
    required this.country,
    required this.wallet,
  });

  CustomerModel copyWith({
    int? id,
    String? phoneNumber,
    String? fullName,
    ValueGetter<String?>? image,
    bool? isActive,
    CountryModel? country,
    WalletModel? wallet,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      fullName: fullName ?? this.fullName,
      image: image != null ? image() : this.image,
      isActive: isActive ?? this.isActive,
      country: country ?? this.country,
      wallet: wallet ?? this.wallet,
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
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id']?.toInt() ?? 0,
      phoneNumber: map['phoneNumber'] ?? '',
      fullName: map['fullName'] ?? '',
      image: map['image'],
      isActive: map['isActive'] ?? false,
      country: CountryModel.fromMap(map['country']),
      wallet: WalletModel.fromMap(map['wallet']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) => CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(id: $id, phoneNumber: $phoneNumber, fullName: $fullName, image: $image, isActive: $isActive, country: $country, wallet: $wallet)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CustomerModel &&
      other.id == id &&
      other.phoneNumber == phoneNumber &&
      other.fullName == fullName &&
      other.image == image &&
      other.isActive == isActive &&
      other.country == country &&
      other.wallet == wallet;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      phoneNumber.hashCode ^
      fullName.hashCode ^
      image.hashCode ^
      isActive.hashCode ^
      country.hashCode ^
      wallet.hashCode;
  }
}
