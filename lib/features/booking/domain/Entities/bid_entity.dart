import 'package:eram_express/common/entities/provider_entity.dart';

import '../../../customer/data/models/customer_model.dart';

class BidEntity 
{
  final int id;
  final String status;
  final String amount;
  final String amountCurrency;
  final ProviderEntity provider;
  final int bookingRequestId;

  // Constructor
  BidEntity({
    required this.id,
    required this.status,
    required this.amount,
    required this.amountCurrency,
    required this.provider,
    required this.bookingRequestId,
  });
}
