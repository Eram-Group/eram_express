import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';

import '../../../home/domain/objects/booking_request_form_data.dart';
import '../models/bid_model.dart';
import '../models/booking_request_model.dart';
import 'booking_api_endpoints.dart';
import 'booking_remote_data_source.dart';

class BookingApiRemoteDataSource implements BookingRemoteDataSource {
  final DioApiClient _dioClient;

  BookingApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;
  @override
  Future<Either<ApiError, Null>> bookingRequest(
    BookingRequestFormData data,
    String accessToken,
  ) async {
    return await _dioClient.request(
      bookingRequestEndpoint.prepare(
        body: {
          "cargo_subcategory": data.cargoVehicleSubcategoryId,
          "goods": data.goodIds,
          "booking_date": data.bookingDate,
          "picking_location_text": data.pickup.address,
          "destination_location_text": data.pickup.address,
          "picking_location": {
            "type": "Point",
            "coordinates": [
              data.pickup.point.longitude,
              data.pickup.point.latitude
            ],
          },
          "destination_location": {
            "type": "Point",
            "coordinates": [
               data.destination.point.longitude,
              data.destination.point.latitude
            
            ],
          }
        },
        /*
          //حطاهم ثابتين لحد ما اعرف اظبط الل emulator
          "picking_location": {
            "type": "Point",
            "coordinates": [46.6753, 24.7136]
          },
          "destination_location": {
            "type": "Point",
            "coordinates": [46.6753, 24.7136]
          }
        },
        */
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
      ),
    );
  }

  @override
  Future<Either<ApiError, List<BookingRequestModel>>> listbBookingRequest(
    String accessToken,
  ) async {
    return await _dioClient.request(
      listbBookingRequestEndpoint.prepare(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
      ),
    );
  }

  @override
  Future<Either<ApiError, Null>> acceptBidding(
      String accessToken, int bidId) async {
    return await _dioClient.request(acceptBiddingtEndpoint(bidId).prepare(
      headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'},
    ));
  }
}
