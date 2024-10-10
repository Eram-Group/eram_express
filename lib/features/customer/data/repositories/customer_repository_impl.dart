import '../../../authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../../domain/entities/customer_entity.dart';
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
}
