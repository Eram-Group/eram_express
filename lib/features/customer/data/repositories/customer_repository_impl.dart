import 'package:either_dart/either.dart';
import 'package:eram_express_shared/core/api/api_error.dart';

import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/objects/update_customer_form_data.dart';
import '../../domain/repositories/customer_repository.dart';
import '../data_sources/remote/customer_remote_data_source.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource _customerRemoteDataSource;
  final TokensLocalDataSource _tokensLocalDataSource;

  CustomerRepositoryImpl({
    required CustomerRemoteDataSource remoteDataSource,
    required TokensLocalDataSource tokensLocalDataSource,
  })  : _customerRemoteDataSource = remoteDataSource,
        _tokensLocalDataSource = tokensLocalDataSource;

  @override
  Future<CustomerEntity?> getAuthenticatedCustomer() async {
    final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) return null;

    final response =
        await _customerRemoteDataSource.getAuthenticatedCustomer(accessToken);

    return response.fold(
      (error) => null,
      (data) => CustomerEntity.fromModel(data),
    );
  }

  @override
  Future<Either<ApiError, CustomerEntity>> updateProfile(
      UpdateCustomerFormData data) async {
    final accessToken = await _tokensLocalDataSource.accessToken;
    if (accessToken == null) {
      return Left(
        // TODO: Return proper error
        ApiError(
          errors: [
            ApiErrorDetail(code: 'code', detail: 'detail', attr: 'attr')
          ],
          type: '',
        ),
      );
    }

    final updatedCustomer = await _customerRemoteDataSource.updateProfile(data, accessToken);

    return updatedCustomer.fold(
      (error) => Left(error),
      (data) {
        return Right(CustomerEntity.fromModel(data));
      },
    );
  }
}
