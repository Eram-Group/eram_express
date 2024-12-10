import 'package:dio/dio.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import 'package:eram_express_shared/data/configurations/data_sources/remote/configurations_api_remote_data_source.dart';
import 'package:eram_express_shared/data/configurations/data_sources/remote/configurations_remote_data_source.dart';
import 'package:eram_express_shared/data/configurations/repositories/configurations_repository.dart';
import 'package:eram_express_shared/data/configurations/repositories/configurations_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../features/authentication/data/data_sources/authentication/remote/authentication_api_remote_data_source.dart';
import '../features/authentication/data/data_sources/authentication/remote/authentication_remote_data_source.dart';
import '../features/authentication/data/data_sources/tokens/local/tokens_local_data_source.dart';
import '../features/authentication/data/data_sources/tokens/local/tokens_secure_storage_local_data_source.dart';
import '../features/authentication/data/respositories/authentication_repository.dart';
import '../features/authentication/data/respositories/authentication_repository_impl.dart';
import '../features/authentication/data/services/authentication_service.dart';
import '../features/booking/data/remote/booking_api_remote_data_source.dart';
import '../features/booking/data/remote/booking_remote_data_source.dart';
import '../features/booking/data/repositories/booking_repository .dart';
import '../features/booking/data/repositories/booking_repository_impl.dart';
import '../features/booking/presentation/widgets/booking_request_card.dart';
import '../features/customer/data/data_sources/remote/customer_api_remote_data_source.dart';
import '../features/customer/data/data_sources/remote/customer_remote_data_source.dart';
import '../features/customer/data/repositories/customer_repository.dart';
import '../features/customer/data/repositories/customer_repository_impl.dart';
import '../features/customer/data/services/customer_service.dart';
import '../features/google_map/data/data_sources/google_map_api_remote_data_source.dart';
import '../features/google_map/data/data_sources/google_map_remote_data_source.dart';
import '../features/google_map/data/repositories/google_map_repositiory.dart';
import '../features/google_map/data/services/locationservice.dart';
import '../features/google_map/presentation/search_model_view/search_model_view.dart';
import '../features/google_map/presentation/views/google_map_view_controller.dart';
import '../features/home/data/data_sources/home_data-api_remote_data_source.dart';
import '../features/home/data/repositotys/home_repository.dart';
import '../features/home/data/repositotys/home_repositoty_impl.dart';
import '../features/home/presentation/views/home_view_controller.dart';
import '../features/i18n/domain/locale_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    sl.registerLazySingleton(() => Dio(
          BaseOptions(
            baseUrl: 'https://prod.eramex.eramapps.com/api',
          ),
        ));
    sl.registerLazySingleton<NetworkService>(() => NetworkServiceImpl(sl()));
    sl.registerLazySingleton<ConfigurationsRemoteDataSource>(
      () => ConfigurationsApiRemoteDataSource(
        networkService: sl(),
      ),
    );
    sl.registerLazySingleton<ConfigurationsRepository>(
      () => ConfigurationsRepositoryImpl(
        remoteDataSource: sl(),
      ),
    );

    //home
    sl.registerLazySingleton(
      () => const FlutterSecureStorage(),
    );
    sl.registerLazySingleton<TokensLocalDataSource>(
      () => TokensSecureStorageLocalDataSource(secureStorage: sl()),
    );
    sl.registerLazySingleton(
        () => HomeDataApiRemoteDataSource(networkService: sl()));
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
          remoteDataSource: sl(), tokensLocalDataSource: sl()),
    );
    sl.registerFactory(
        () => HomeViewController(homeRepo: sl(), bookingRepository: sl()));

    //booking
    sl.registerLazySingleton<BookingRemoteDataSource>(
        () => BookingApiRemoteDataSource(networkService: sl()));
    sl.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(
          bookingRemoteDataSource: sl(), tokensLocalDataSource: sl()),
    );
    sl.registerFactory(() => ExpansionTileCubit());

    //GoogleMap
    sl.registerLazySingleton<GoogleMapRemoteDataSource>(
      () => GoogleMapApiRemoteDataSource(networkService: sl(), dio: sl()),
    );
    sl.registerLazySingleton(() => LocationService());
    sl.registerLazySingleton(() => GoogleMapRepositoryImpl(
        googleMapRemoteDataSource: sl(), tokensLocalDataSource: sl()));
    sl.registerFactory(() => SearchViewController(
        googleMapRepository: sl(), authenticationRepository: sl()));
    sl.registerFactory(() => GoogleMapViewController(
        googleMapRepository: sl(), locationService: sl()));

//customer
    sl.registerLazySingleton<CustomerRemoteDataSource>(
        () => CustomerApiRemoteDataSource(networkService: sl()));
    sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(
        remoteDataSource: sl(), tokensLocalDataSource: sl()));
    sl.registerLazySingleton(() => CustomerService(
        customerRepository: sl(), authenticationRepository: sl()));

//Authentication

    sl.registerLazySingleton(() => AuthenticationService(
        authenticationRepository: sl(), customerRepository: sl()));
    sl.registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationApiRemoteDataSource(networkService: sl()));
    sl.registerLazySingleton<AuthenticationRepository>(() =>
        AuthenticationRepositoryImpl(
            authenticationRemoteDataSource: sl(),
            tokensLocalDataSource: sl(),
            customerRepository: sl()));

    sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());
  }
}
