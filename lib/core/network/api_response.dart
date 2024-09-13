class ApiResponse<T> {
  final T? data;
  final int? statusCode;
  final String? error;

  ApiResponse.success(this.statusCode, this.data) : error = null;
  ApiResponse.failure(this.statusCode, this.error) : data = null;

  bool get hasError => error != null;
}
