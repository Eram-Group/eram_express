import 'dart:io';

<<<<<<< HEAD
import '../../../../../../core/api/api_endpoint.dart';

import '../models/verify_otp_response_model.dart';
=======
import 'package:eram_express_shared/core/api/api_endpoint.dart';

import '../../../../domain/objects/verify_otp_response_wrapper.dart';
import '../../../models/verify_otp_response_model.dart';
>>>>>>> ac9b3dfcd0ce0ee82fdedbbf6d9ba9892ea0b09c

final sendOtpEndpoint = ApiEndpoint(
  path: '/user/send-otp/',
  method: HttpMethod.post,
  responseHandlers: {HttpStatus.ok: (_) {}},
);

final verifyOtpEndpoint = ApiEndpoint(
  path: '/customer/authenticate/',
  method: HttpMethod.post,
  responseHandlers: {
    HttpStatus.ok: (response) => VerifyOtpResponseWrapper(
          isNewCustomer: false,
          response: VerifyOtpResponseModel.fromJson(response.data),
        ),
    HttpStatus.created: (response) => VerifyOtpResponseWrapper(
          isNewCustomer: true,
          response: VerifyOtpResponseModel.fromJson(response.data),
        ),
  },
);
