class VerifyOtpResponseWrapper<T> {
  final bool isNewCustomer;
  final T response;

  VerifyOtpResponseWrapper({
    required this.isNewCustomer,
    required this.response,
  });
}
