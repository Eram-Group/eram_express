
import 'package:eram_express_shared/domain/entites/country_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
