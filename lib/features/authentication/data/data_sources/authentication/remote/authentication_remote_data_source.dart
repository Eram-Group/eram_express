import 'package:eram_express_shared/data/configurations/models/device_details_model.dart';

import '../../../../presentation/objects/otp_verification_data.dart';
import '../../../../presentation/objects/verify_otp_response_wrapper.dart';
import '../../../models/verify_otp_response_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> sendOtp(String phoneNumber);
  Future<VerifyOtpResponseWrapper<VerifyOtpResponseModel>> verifyOtp(
      OtpVerificationData data,DeviceDetailsModel deviceDetails);
}
