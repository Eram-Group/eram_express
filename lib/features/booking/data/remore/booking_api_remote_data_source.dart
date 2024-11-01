import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';

import '../../../home/domain/objects/booking_request_form_data.dart';
import 'booking_api_endpoints.dart';
import 'booking_remote_data_source.dart';

class BookingApiRemoteDataSource implements BookingRemoteDataSource {
  final DioApiClient _dioClient;

  BookingApiRemoteDataSource({required DioApiClient dioClient})
      : _dioClient = dioClient;

  Future<Either<ApiError, Null>> bookingRequest(
    BookingRequestFormData data,
    String accessToken,
  ) async {
    return await _dioClient.request(
      bookingRequestEndpoint.prepare(
        body: {
          "cargo_vehicle_subcategory": data.cargoVehicleSubcategoryId,
          "goods": data.goodIds,
          "booking_date": data.bookingDate,
          /*
          "picking_location": {
            "type": "Point",
            "coordinates": [
              data.pickup.point.latitude,
              data.pickup.point.longitude
            ],
          },
          "destination_location": {
            "type": "Point",
            "coordinates": [
              data.destination.point.latitude,
              data.destination.point.longitude
            ],
          },
          */
          "picking_location": {
            "type": "Point",
            "coordinates": [46.6753, 24.7136]
          },
          "destination_location": {
            "type": "Point",
            "coordinates": [46.6753, 24.7136]
          }
        },
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        },
      ),
    );
  }
}


/*
@override
  Future<Either<ApiError, Null>> bookingRequest(
      BookingRequestFormData data) async {
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
    final result =
        await _customerRemoteDataSource.bookingRequest(data, accessToken);
    return result.fold((error) => Left(error), (data) => Right(null));
  }*/