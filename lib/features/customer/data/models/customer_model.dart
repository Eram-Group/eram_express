

import 'package:eram_express_shared/data/configurations/models/country_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'wallet_model.dart';

part 'customer_model.freezed.dart';
part 'customer_model.g.dart';

@freezed
abstract class CustomerModel with _$CustomerModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory CustomerModel({
    required int id,
    required String phoneNumber,
    required String fullName,
    required String? image,
    required bool isActive,
    required CountryModel country,
    required WalletModel wallet,
  }) = _CustomerModel;
  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
}
