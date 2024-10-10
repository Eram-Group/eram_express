import 'package:eram_express/core/network/api_error.dart';

handleApiError(ApiError error) {
  return switch (error.type) {
    "validation_error" => error.errors.map((e) => e.detail).join(", "),
    _ => "An error occurred",
  };
}
