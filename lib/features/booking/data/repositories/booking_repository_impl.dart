import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../../home/domain/objects/booking_request_form_data.dart';
import '../../domain/repositories/booking_repository.dart';
import '../remore/booking_remote_data_source.dart';

class BookingRepositoryImpl  implements BookingRepository
{
  
  final BookingRemoteDataSource  _bookingRemoteDataSource;
   final TokensLocalDataSource _tokensLocalDataSource;
BookingRepositoryImpl({
  required BookingRemoteDataSource  bookingRemoteDataSource,
  required TokensLocalDataSource tokensLocalDataSource,
}):_bookingRemoteDataSource=bookingRemoteDataSource,
_tokensLocalDataSource=tokensLocalDataSource;

  @override
 Future<Either<ApiError, Null>> bookingRequest(BookingRequestFormData data) async
{
  final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) {
      return Left(
        // TODO: Return proper error
        ApiError(
          errors: [
            ApiErrorDetail(code: 'code', detail: 'detail', attr: 'attr')
          ],
          type: '',
        ),
      );
    }
  final result = await _bookingRemoteDataSource.bookingRequest(data, accessToken);
  return result.fold((error)=>Left(error),
      (data) =>Right(null)
  );
  
}



  
}