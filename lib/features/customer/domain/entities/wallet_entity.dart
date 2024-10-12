import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/wallet_model.dart';

part 'wallet_entity.freezed.dart';

@freezed
abstract class WalletEntity with _$WalletEntity {
  factory WalletEntity({
    required String balance,
    required String balanceCurrency,
    required bool isUseWalletInPayment,
  }) = _WalletEntity;

  factory WalletEntity.fromModel(WalletModel wallet) {
    return WalletEntity(
      balance: wallet.balance,
      balanceCurrency: wallet.balanceCurrency,
      isUseWalletInPayment: wallet.isUseWalletInPayment,
    );
  }

  const WalletEntity._();
}
