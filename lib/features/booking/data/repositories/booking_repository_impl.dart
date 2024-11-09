import 'package:either_dart/either.dart';
import 'package:eram_express/features/booking/domain/Entities/bid_entity.dart';
import 'package:eram_express/features/booking/domain/Entities/booking_request_entity.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../../home/domain/objects/booking_request_form_data.dart';
import '../../domain/repositories/booking_repository.dart';
import '../models/bid_model.dart';
import '../models/booking_request_model.dart';
import '../remote/booking_remote_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _bookingRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;
  List<BidEntity>? _biddings;
  List<BookingRequestEntity>? _bookingRequests;
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
        // TODO: Return proper error  // ساعتها مش مفروض اصلا دخ مبيحصش
        ApiError(
          errors: [
            ApiErrorDetail(code: 'code', detail: 'detail', attr: 'attr')
          ],
          type: '',
        ),
      );
    }
    final result =
        await _bookingRemoteDataSource.bookingRequest(data, accessToken);
    return result;
  }

  Future<Either<ApiError, List<BidEntity>>> listBiddings(
      int bookingRequestId) async {
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
    if (_biddings != null) return Right(_biddings!);
    final result = await _bookingRemoteDataSource.listBiddings(
        bookingRequestId, accessToken);
    return result.fold((error) => Left(error), (data) {
      final bidlist = data.map((item) => BidEntity.fromModel(item)).toList();
      return Right(bidlist);
    });
  }

  Future<Either<ApiError, List<BookingRequestEntity>>>listBookingRequest() async {
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
    if (_bookingRequests != null) return Right(_bookingRequests!);
    final result = await _bookingRemoteDataSource.listbBookingRequest(accessToken);
    return result.fold(
      (error) => Left(error),
      (data) 
      {
        final _booking = data.map((item) => BookingRequestEntity.fromModel(item)).toList();
        return Right(_booking);
      },
    );
  }




  Future<Either<ApiError, Null>> acceptBidding(int bidId) async
  {
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
    final result= await _bookingRemoteDataSource.acceptBidding(accessToken, bidId);
    return result.fold(
      (error) => Left(error),
      (data) => Right(null)
      
    );
  }
  
  @override
  List<BookingRequestEntity>? get cachetbooking => _bookingRequests;
  


}
