class WalletModel {
  final String balance;
  final String balanceCurrency;
  final bool isUseWalletInPayment;

  WalletModel({
    required this.balance,
    required this.balanceCurrency,
    required this.isUseWalletInPayment,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: json['balance'] ,
      balanceCurrency: json['balance_currency'] ,
      isUseWalletInPayment: json['is_use_wallet_in_payment'] ,
    );
  }


}
