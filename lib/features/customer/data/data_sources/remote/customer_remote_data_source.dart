import 'package:either_dart/either.dart';

import '../../../../../core/api/api_error.dart';
import '../../models/customer_model.dart';

abstract class CustomerRemoteDataSource {
  Future<Either<ApiError, CustomerModel>> getAuthenticatedCustomer(
      String accessToken);
}
