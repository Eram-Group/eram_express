import 'dart:io';

import '../../../../../../core/api/api_endpoint.dart';

import '../models/verify_otp_response_model.dart';

final sendOtpEndpoint = ApiEndpoint(
  path: '/user/send-otp/',
  method: HttpMethod.post,
  responseHandlers: {HttpStatus.ok: (_) {}},
);

final verifyOtpEndpoint = ApiEndpoint(
  path: '/customer/authenticate/',
  method: HttpMethod.post,
  responseHandlers: {
    HttpStatus.ok: (response) => VerifyOtpResponseModel.fromJson(response.data),
    HttpStatus.created: (response) =>
        VerifyOtpResponseModel.fromJson(response.data),
  },
);
