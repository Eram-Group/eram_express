import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
abstract class WalletModel with _$WalletModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory WalletModel({
    required String balance,
    required String balanceCurrency,
    required bool isUseWalletInPayment,
  }) = _WalletModel;
  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}
