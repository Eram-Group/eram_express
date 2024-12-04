import 'dart:io';
import 'package:eram_express_shared/core/api/api_endpoint.dart';
import '../models/bid_model.dart';
import '../models/booking_request_model.dart';

final bookingRequestEndpoint = ApiEndpoint(
  path: "/booking-requests/create/",
  method: HttpMethod.post,
  responseHandlers: {HttpStatus.created: (response) => null},
);

final listBiddingEndpoint = ApiEndpoint(
  path: '/bids/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => (response.data as List)
        .map((item) => BidModel.fromJson(item as Map<String, dynamic>))
        .toList()
  },
);

final listBookingRequestEndpoint = ApiEndpoint(
  path: '/booking-requests/',
  method: HttpMethod.get,
  responseHandlers: {
    HttpStatus.ok: (response) => (response.data as List)
        .map((item) =>
            BookingRequestModel.fromJson(item as Map<String, dynamic>))
        .toList()
  },
);


acceptBiddingEndpoint(int bidId) => ApiEndpoint(
      path: "/bids/$bidId/accept/",
      method: HttpMethod.post,
      responseHandlers: {
        HttpStatus.created: (response) => null,
      },
    );
