<<<<<<< HEAD
import 'package:equatable/equatable.dart';
import 'package:eram_express_shared/data/configurations/models/country_model.dart';
=======
import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
>>>>>>> ac9b3dfcd0ce0ee82fdedbbf6d9ba9892ea0b09c

import '../../data/models/customer_model.dart';
import 'wallet_entity.dart';

part 'customer_entity.freezed.dart';

@freezed
abstract class CustomerEntity with _$CustomerEntity {
  const CustomerEntity._();

  factory CustomerEntity({
    required int id,
    required String phoneNumber,
    required String fullName,
    required String? image,
    required bool isActive,
    required CountryEntity country,
    required WalletEntity wallet,
  }) = _CustomerEntity;

  factory CustomerEntity.fromModel(CustomerModel model) {
    return CustomerEntity(
      id: model.id,
      phoneNumber: model.phoneNumber,
      fullName: model.fullName,
      image: model.image,
      isActive: model.isActive,
      country: CountryEntity.fromModel(model.country),
      wallet: WalletEntity.fromModel(model.wallet),
    );
  }
}
