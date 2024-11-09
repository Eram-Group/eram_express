import 'package:either_dart/either.dart';
import 'package:eram_express/features/booking/data/models/bid_model.dart';
import 'package:eram_express/features/booking/domain/repositories/booking_repository.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../Entities/bid_entity.dart';

class GetBiddingsUsecase 
{
  final BookingRepository _bookingRepository;
  GetBiddingsUsecase 
  ({
    required BookingRepository bookingRepository,
  }):_bookingRepository=bookingRepository;



Future<Either<ApiError, List<BidEntity>>>execute(int bookingRequestId) async
{
  final result = _bookingRepository.listBiddings(bookingRequestId);
  return result;
}


}
