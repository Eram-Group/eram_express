import 'package:either_dart/either.dart';
import 'package:eram_express/features/booking/data/models/bid_model.dart';
import 'package:eram_express/features/booking/data/models/booking_request_model.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../../home/presentation/objects/booking_request_form_data.dart';

import '../remote/booking_remote_data_source.dart';
import 'BookingRepository .dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _bookingRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;
  List<BookingRequestModel>? _bookingRequests;
  BookingRepositoryImpl({
    required BookingRemoteDataSource bookingRemoteDataSource,
    required TokensLocalDataSource tokensLocalDataSource,
  })  : _bookingRemoteDataSource = bookingRemoteDataSource,
        _tokensLocalDataSource = tokensLocalDataSource;

  @override
  Future<Either<ApiError, Null>> bookingRequest(
      BookingRequestFormData data) async {
    final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) {
      return Left(
        // TODO: Return proper error  // ساعتها مش مفروض اصلا د مبيحصش
        ApiError(
          errors: [
            ApiErrorDetail(code: 'code', detail: 'detail', attr: 'attr')
          ],
          type: '',
        ),
      );
    }
    final result = await _bookingRemoteDataSource.bookingRequest(data, accessToken);
    return result;
  }
  @override
  Future<Either<ApiError, List<BookingRequestModel>>>listBookingRequest() async {
    final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) {
      return Left(
        ApiError(
          errors: [
            ApiErrorDetail(code: 'code', detail: 'detail', attr: 'attr')
          ],
          type: '',
        ),
      );
    }
  
    final result = await _bookingRemoteDataSource.listbBookingRequest(accessToken);
    return result.fold(
      (error) => Left(error),
      (data) {
        _bookingRequests= data;
        return Right(_bookingRequests!);
      },
    );
  }

  Future<Either<ApiError, Null>> acceptBidding(int bidId) async {
    final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) {
      return Left(
        ApiError(
          errors: [
            ApiErrorDetail(code: 'code', detail: 'detail', attr: 'attr')
          ],
          type: '',
        ),
      );
    }
    final result =
        await _bookingRemoteDataSource.acceptBidding(accessToken, bidId);
    return result.fold((error) => Left(error), (data) => Right(null));
  }

  @override
  List<BookingRequestModel>? get cachetBooking => _bookingRequests;
}
