import 'package:eram_express_shared/core/api/server_expection.dart';

const kResendOtpInterval = 60;

enum OtpViewStatus {
  initial,
  loading,
  error,
  timing,
  success,
}

extension OtpViewStateX on OtpViewState {
  bool get isInitial => status == OtpViewStatus.initial;
  bool get isLoading => status == OtpViewStatus.loading;
  bool get isSuccess => status == OtpViewStatus.success; 
  bool get isError => status == OtpViewStatus.error;
  bool get isTiming => status == OtpViewStatus.timing;
}

class OtpViewState {
  final OtpViewStatus status;
  final String? otp;
  final int? canResendIn;
  final bool? isNewCustomer;
  final ServerException? serverException;
  OtpViewState({
    required this.status,
    this.otp = " ",
    this.canResendIn,
    this.serverException,
    this.isNewCustomer,
  });

  OtpViewState copyWith({
    OtpViewStatus? status,
    String? otp,
    int? canResendIn,
    ServerException? serverException,
    final bool? isNewCustomer,
  }) {
    return OtpViewState(
      status: status ?? this.status,
      otp: otp ?? this.otp,
      canResendIn: canResendIn ?? this.canResendIn,
      serverException: serverException ?? this.serverException,
      isNewCustomer: isNewCustomer ?? this.isNewCustomer,
    );
  }
}
