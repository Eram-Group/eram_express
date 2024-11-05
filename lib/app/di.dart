import 'package:dio/dio.dart';
import 'package:eram_express/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:eram_express/features/booking/domain/repositories/booking_repository.dart';
import 'package:eram_express/features/booking/domain/services/booking_service.dart';
import 'package:eram_express_shared/core/api/dio_api_client.dart';
import 'package:eram_express_shared/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../features/authentication/data/data_sources/authentication/remote/authentication_api_remote_data_source.dart';
import '../features/authentication/data/data_sources/tokens/local/tokens_secure_storage_local_data_source.dart';
import '../features/authentication/data/respositories/authentication_repository_impl.dart';
import '../features/authentication/domain/services/authentication_service.dart';
import '../features/booking/data/remore/booking_api_remote_data_source.dart';
import '../features/booking/data/remore/booking_remote_data_source.dart';
import '../features/customer/data/data_sources/remote/customer_api_remote_data_source.dart';
import '../features/customer/data/repositories/customer_repository_impl.dart';
import '../features/customer/domain/services/customer_service.dart';
import '../features/google_map/data/data_sources/googlemap_ApiRemoteDataSource.dart';
import '../features/google_map/data/repositories/google_map_repositiory.dart';
import '../features/google_map/domain/services/locationservice.dart';
import '../features/home/data/data_sources/HomeData-api_remote_data_source.dart';
import '../features/home/data/repositotys/home_repositoty_impl.dart';
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

//Home
final HomeRepository =
    HomeRepositoryImpl(remoteDataSource: HomeDataRemoteDataSource);
final HomeDataRemoteDataSource = HomeDataApiRemoteDataSource(
  dioClient: dioClient,
);

//GoogleMap

final googleMapRemoteDataSource = GoogleMapApiRemoteDataSource();
final googlemapRepository = GoogleMapRepositoryImpl(
    googlemapRemoteDataSource: googleMapRemoteDataSource);
final locationservice = Locationservice();

//Booking

final bookingRemoteDataSource = BookingApiRemoteDataSource(
  dioClient: dioClient,
);
final bookingRepository = BookingRepositoryImpl(
    bookingRemoteDataSource: bookingRemoteDataSource,
    tokensLocalDataSource: tokensLocalDataSource);

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://prod.eramex.eramapps.com/api',
  ),
);

final dioClient = DioApiClient(
  dio: dio,
);

final localeCubit = LocaleCubit();

final List<BlocProvider> providers = [
  BlocProvider<LocaleCubit>(
    create: (_) => localeCubit,
  ),
];

final tokensLocalDataSource =
    TokensSecureStorageLocalDataSource(secureStorage: secureStorage);
