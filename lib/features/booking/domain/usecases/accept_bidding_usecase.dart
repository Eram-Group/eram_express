import 'package:either_dart/either.dart';
import 'package:eram_express/features/booking/domain/repositories/booking_repository.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

class AcceptBiddingUsecase
{
  final BookingRepository _bookingRepository;
  AcceptBiddingUsecase({required BookingRepository bookingRepository,})
                         : _bookingRepository = bookingRepository;
 
Future<Either<ApiError, Null>> execute(int bidId)
{
  return  _bookingRepository.acceptBidding(bidId);
  
}

}