import 'dart:convert';

class WalletModel {
  final String balance;
  final String balanceCurrency;
  final bool isUseWalletInPayment;
  WalletModel({
    required this.balance,
    required this.balanceCurrency,
    required this.isUseWalletInPayment,
  });

  WalletModel copyWith({
    String? balance,
    String? balanceCurrency,
    bool? isUseWalletInPayment,
  }) {
    return WalletModel(
      balance: balance ?? this.balance,
      balanceCurrency: balanceCurrency ?? this.balanceCurrency,
      isUseWalletInPayment: isUseWalletInPayment ?? this.isUseWalletInPayment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'balanceCurrency': balanceCurrency,
      'isUseWalletInPayment': isUseWalletInPayment,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      balance: map['balance'] ?? '',
      balanceCurrency: map['balanceCurrency'] ?? '',
      isUseWalletInPayment: map['isUseWalletInPayment'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) => WalletModel.fromMap(json.decode(source));

  @override
  String toString() => 'WalletModel(balance: $balance, balanceCurrency: $balanceCurrency, isUseWalletInPayment: $isUseWalletInPayment)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WalletModel &&
      other.balance == balance &&
      other.balanceCurrency == balanceCurrency &&
      other.isUseWalletInPayment == isUseWalletInPayment;
  }

  @override
  int get hashCode => balance.hashCode ^ balanceCurrency.hashCode ^ isUseWalletInPayment.hashCode;
}
