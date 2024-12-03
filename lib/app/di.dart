import 'package:eram_express/features/profile/data/data_sources/profile_api_remote_data_source.dart';
import 'package:eram_express/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:eram_express_shared/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../features/authentication/data/data_sources/authentication/remote/authentication_api_remote_data_source.dart';
import '../features/authentication/data/data_sources/tokens/local/tokens_secure_storage_local_data_source.dart';
import '../features/authentication/data/respositories/authentication_repository_impl.dart';
import '../features/authentication/data/services/authentication_service.dart';
import '../features/customer/data/data_sources/remote/customer_api_remote_data_source.dart';
import '../features/customer/data/repositories/customer_repository_impl.dart';
import '../features/customer/data/services/customer_service.dart';
import '../features/i18n/domain/locale_cubit.dart';

const secureStorage = FlutterSecureStorage();

final authenticationRemoteDataSource = AuthenticationApiRemoteDataSource(
  dioClient: dioClient,
);

final customerService = CustomerService(
  customerRepository: customerRepository,
  authenticationRepository: authenticationRepository,
);

final authenticationRepository = AuthenticationRepositoryImpl(
  customerRepository: customerRepository,
  authenticationRemoteDataSource: authenticationRemoteDataSource,
  tokensLocalDataSource: tokensLocalDataSource,
);

final authenticationService = AuthenticationService(
  authenticationRepository: authenticationRepository,
  customerRepository: customerRepository,
);

final customerRemoteDataSource = CustomerApiRemoteDataSource(
  dioClient: dioClient,
);

final customerRepository = CustomerRepositoryImpl(
  remoteDataSource: customerRemoteDataSource,
  tokensLocalDataSource: tokensLocalDataSource,
);

//profile
final profileRemoteDataSource = ProfileApiRemoteDataSource(
  dioClient: dioClient,
);
final profileRepository = ProfileRepositoryImpl(
  profileRemoteDataSource: profileRemoteDataSource,
  tokensLocalDataSource: tokensLocalDataSource,
  
  );
final localeCubit = LocaleCubit();
final List<BlocProvider> providers =
 [
  BlocProvider<LocaleCubit>(
    create: (_) => localeCubit,
  ),
];

final tokensLocalDataSource =
    TokensSecureStorageLocalDataSource(secureStorage: secureStorage);
