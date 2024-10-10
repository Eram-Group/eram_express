import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/navigation_service.dart';
import '../core/network/dio_api_client.dart';
import '../features/common/data/configurations/data_sources/remote/configurations_api_remote_data_source.dart';
import '../features/common/data/configurations/repositories/configurations_repository_impl.dart';
import '../features/i18n/domain/locale_cubit.dart';
import 'navigation.dart';

final configurationsRemoteDataSource = ConfigurationsApiRemoteDataSource(
  dioClient: dioClient,
);
final configurationsRepository = ConfigurationsRepositoryImpl(
  remoteDataSource: configurationsRemoteDataSource,
);
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://prod.eramex.eramapps.com/api',
  ),
);
final dioClient = DioApiClient(
  dio: dio,
);

final localeCubit = LocaleCubit();

final navigationService = NavigationService(
  navigatorKey,
);

final List<BlocProvider> providers = [
  BlocProvider<LocaleCubit>(
    create: (_) => localeCubit,
  ),
];
