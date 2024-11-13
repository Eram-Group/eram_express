
import 'package:eram_express/common/viewmodels/provider_view_model.dart';

import '../../../../../common/entities/provider_entity.dart';
import '../../../domain/Entities/bid_entity.dart';
import '../../../domain/Entities/booking_request_entity.dart';

class BidViewModel {
  final int id;
  final String status;
  final String amount;
  final String amountCurrency;
  final ProviderViewModel provider;
  final int bookingRequestId;

  BidViewModel({
    required this.id,
    required this.status,
    required this.amount,
    required this.amountCurrency,
    required this.provider,
    required this.bookingRequestId, 
  });

   factory BidViewModel.fromEntity(BidEntity  entity) {
    return BidViewModel(
        id: entity.id,
        status: entity.status,
        amount: entity.amount,
        amountCurrency: entity.amountCurrency,
        provider: ProviderViewModel.fromEntity(entity.provider),
        bookingRequestId: entity.bookingRequestId);
  }

}
