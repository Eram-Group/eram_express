import 'dart:io';


import 'package:eram_express_shared/core/api/api_endpoint.dart';

import '../../../../presentation/objects/verify_otp_response_wrapper.dart';
import '../../../models/verify_otp_response_model.dart';

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
