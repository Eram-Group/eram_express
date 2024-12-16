import 'package:dio/dio.dart';
import 'package:eram_express_shared/core/api/log_interceptor.dart';
import 'package:eram_express_shared/core/api/network-service.dart';
import 'package:eram_express_shared/data/configurations/data_sources/remote/configurations_api_remote_data_source.dart';
import 'package:eram_express_shared/data/configurations/data_sources/remote/configurations_remote_data_source.dart';
import 'package:eram_express_shared/data/configurations/repositories/configurations_repository.dart';
import 'package:eram_express_shared/data/configurations/repositories/configurations_repository_impl.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:eram_express_shared/tokens/local/tokens_local_data_source.dart';
import 'package:eram_express_shared/tokens/local/tokens_secure_storage_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../features/authentication/data/data_sources/authentication/remote/authentication_api_remote_data_source.dart';
import '../features/authentication/data/data_sources/authentication/remote/authentication_remote_data_source.dart';
import '../features/authentication/data/respositories/authentication_repository.dart';
import '../features/authentication/data/respositories/authentication_repository_impl.dart';
import '../features/authentication/data/services/authentication_service.dart';
import '../features/authentication/presentation/views/screens/complete_profile/complete_profile_view_model.dart';
import '../features/authentication/presentation/views/screens/login/login_view_model.dart';
import '../features/authentication/presentation/views/screens/otp/otp_view_model.dart';
import '../features/booking/data/remote/booking_api_remote_data_source.dart';
import '../features/booking/data/remote/booking_remote_data_source.dart';
import '../features/booking/data/repositories/booking_repository .dart';
import '../features/booking/data/repositories/booking_repository_impl.dart';
import '../features/booking/presentation/views/booking_request_view_controller.dart';
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
import '../features/home/data/data_sources/home_data_remote_data_source.dart';
import '../features/home/data/repositotys/home_repository.dart';
import '../features/home/data/repositotys/home_repositoty_impl.dart';
import '../features/home/presentation/views/home_view_controller.dart';
import '../features/i18n/domain/locale_cubit.dart';
import '../features/init/presentation/views/init_view_model.dart';

class ServiceLocator {
  void init() {
    sl.registerLazySingleton<ConfigurationsRemoteDataSource>(
      () => ConfigurationsApiRemoteDataSource(
        networkService: sl(),
      ),
    );
    sl.registerFactory(() => InitViewModel(
        authenticationRepository: sl(), configurationsRepository: sl()));

    sl.registerLazySingleton<ConfigurationsRepository>(
      () => ConfigurationsRepositoryImpl(
        remoteDataSource: sl(),
      ),
    );

    //home

    sl.registerLazySingleton<HomeDataRemoteDataSource>(
        () => HomeDataApiRemoteDataSource(networkService: sl()));
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerFactory(
        () => HomeViewController(homeRepo: sl(), bookingRepository: sl()));

    //booking
    sl.registerLazySingleton<BookingRemoteDataSource>(
        () => BookingApiRemoteDataSource(networkService: sl()));
    sl.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(
        bookingRemoteDataSource: sl(),
      ),
    );
    sl.registerFactory(
        () => BookingRequestViewController(bookingRepository: sl()));

    sl.registerFactory(() => ExpansionTileCubit());

    //GoogleMap
    sl.registerLazySingleton<GoogleMapRemoteDataSource>(
      () => GoogleMapApiRemoteDataSource(networkService: sl(), dio: sl()),
    );
    sl.registerLazySingleton(() => LocationService());
    sl.registerLazySingleton(() => GoogleMapRepositoryImpl(
          googleMapRemoteDataSource: sl(),
        ));
    sl.registerFactory(() => SearchViewController(
        googleMapRepository: sl(), authenticationRepository: sl()));
    sl.registerFactory(() => GoogleMapViewController(
        googleMapRepository: sl(), locationService: sl()));

//customer
    sl.registerLazySingleton<CustomerRemoteDataSource>(
        () => CustomerApiRemoteDataSource(networkService: sl()));
    sl.registerLazySingleton<CustomerRepository>(() => CustomerRepositoryImpl(
          remoteDataSource: sl(),
        ));
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
            customerRepository: sl(),
            notificationService: sl()));

//log in
    sl.registerFactory(() => LoginViewModel(
        configurationsRepository: sl(), authenticationService: sl()));

//Otp
    sl.registerFactory(() => OtpViewModel(authenticationService: sl()));

//completprofile
    sl.registerFactory(() => CompleteProfileViewModel(customerService: sl()));

//localization
    sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());

//Notification
   
  }
}
