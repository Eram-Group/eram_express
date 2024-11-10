
class BidViewModel {
  final int id;
  final String status;
  final String amount;
  final String amountCurrency;
  final  provider;
  final int bookingRequestId;

  BidViewModel({
    required this.id,
    required this.status,
    required this.amount,
    required this.amountCurrency,
    required this.provider,
    required this.bookingRequestId,
  });
}
