import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../customer/data/models/customer_model.dart';

part 'verify_otp_response_model.freezed.dart';
part 'verify_otp_response_model.g.dart';

@freezed
abstract class VerifyOtpResponseModel with _$VerifyOtpResponseModel {
  const VerifyOtpResponseModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory VerifyOtpResponseModel({
    required String accessToken,
    required String refreshToken,
    required CustomerModel customer,
  }) = _VerifyOtpResponseModel;

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseModelFromJson(json);
}
