import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/api/dio_api_client.dart';
import '../core/navigation_service.dart';
import '../features/authentication/data/data_sources/authentication/remote/authentication_api_remote_data_source.dart';
import '../features/authentication/data/data_sources/tokens/local/tokens_secure_storage_local_data_source.dart';
import '../features/authentication/data/respositories/authentication_repository_impl.dart';
import '../features/authentication/domain/services/authentication_service.dart';
import '../features/common/data/configurations/data_sources/remote/configurations_api_remote_data_source.dart';
import '../features/common/data/configurations/repositories/configurations_repository_impl.dart';
import '../features/customer/data/data_sources/remote/customer_api_remote_data_source.dart';
import '../features/customer/data/repositories/customer_repository_impl.dart';
import '../features/home/data/data_sources/HomeData-api_remote_data_source.dart';
import '../features/home/data/repositotys/home_repositoty_impl.dart';
import '../features/i18n/domain/locale_cubit.dart';
import 'navigation.dart';

const secureStorage = FlutterSecureStorage();

final authenticationRemoteDataSource = AuthenticationApiRemoteDataSource(
  dioClient: dioClient,
);

final authenticationRepository = AuthenticationRepositoryImpl(
  customerRepository: customerRepository,
  remoteDataSource: authenticationRemoteDataSource,
  localDataSource: tokensLocalDataSource,
);

final authenticationService = AuthenticationService(
  authenticationRepository: authenticationRepository,
  customerRepository: customerRepository,
);

final configurationsRemoteDataSource = ConfigurationsApiRemoteDataSource(
  dioClient: dioClient,
);

final configurationsRepository = ConfigurationsRepositoryImpl(
  remoteDataSource: configurationsRemoteDataSource,
);

final customerRemoteDataSource = CustomerApiRemoteDataSource(
  dioClient: dioClient,
);

final customerRepository = CustomerRepositoryImpl(
  remoteDataSource: customerRemoteDataSource,
  tokensLocalDataSource: tokensLocalDataSource,
);

 //Home
 final HomeRepository = HomeRepositoryImpl(remoteDataSource: HomeDataRemoteDataSource);
 final HomeDataRemoteDataSource = HomeDataApiRemoteDataSource( dioClient: dioClient,);





final dio = Dio(
  BaseOptions(
    baseUrl: 'https://prod.eramex.eramapps.com/api',
  ),
);

final dioClient = DioApiClient(
  dio: dio,
);

final localeCubit = LocaleCubit();

final mainNavigationService = NavigationService(
  navigatorKey,
);

final List<BlocProvider> providers = [
  BlocProvider<LocaleCubit>(
    create: (_) => localeCubit,
  ),
];

final tokensLocalDataSource = TokensSecureStorageLocalDataSource(secureStorage: secureStorage);

