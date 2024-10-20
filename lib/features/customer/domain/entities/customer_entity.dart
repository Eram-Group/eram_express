import 'package:equatable/equatable.dart';
import 'package:eram_express_shared/data/configurations/models/country_model.dart';

import '../../../authentication/data/data_sources/authentication/models/wallet_model.dart';
import '../../data/models/customer_model.dart';

class CustomerEntity extends Equatable {
  final int id;
  final String phoneNumber;
  final String fullName;
  final String? image;
  final bool isActive;
  final CountryModel country;
  final WalletModel wallet;

  const CustomerEntity({
    required this.id,
    required this.phoneNumber,
    required this.fullName,
    required this.image,
    required this.isActive,
    required this.country,
    required this.wallet,
  });

  factory CustomerEntity.fromModel(CustomerModel model) {
    return CustomerEntity(
      id: model.id,
      phoneNumber: model.phoneNumber,
      fullName: model.fullName,
      image: model.image,
      isActive: model.isActive,
      country: model.country,
      wallet: model.wallet,
    );
  }

  @override
  List<Object?> get props =>
      [id, phoneNumber, fullName, image, isActive, country, wallet];
}
