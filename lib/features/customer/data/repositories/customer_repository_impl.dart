import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customer_repository.dart';
import '../data_sources/remote/customer_remote_data_source.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource _customerRemoteDataSource;
  CustomerRepositoryImpl({
    required CustomerRemoteDataSource remoteDataSource,
    required TokensLocalDataSource tokensLocalDataSource,
  }) : _customerRemoteDataSource = remoteDataSource;

  @override
  Future<CustomerEntity?> getAuthenticatedCustomer({
    required String accessToken,
  }) async {
    final response =
        await _customerRemoteDataSource.getAuthenticatedCustomer(accessToken);

    return response.fold(
      (error) => null,
      (data) => CustomerEntity.fromModel(data),
    );
  }
}
