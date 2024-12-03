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
    required this.image,
    required this.isActive,
    required this.country,
    required this.wallet,
  });

  
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ,
      phoneNumber: json['phone_number'] ,
      fullName: json['full_name'] ,
      image: json['image'] ,
      isActive: json['is_active'] ,
      country: CountryModel.fromJson(json['country']),
      wallet: WalletModel.fromJson(json['wallet'] ),
    );
  }

}
