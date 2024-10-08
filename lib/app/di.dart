import 'package:dio/dio.dart';
import 'package:eram_express/features/i18n/domain/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/navigation_service.dart';
import '../core/network/api_service.dart';
import '../features/authentication/logic/repositories/authentication_repository.dart';
import 'navigation.dart';

final apiService = ApiService(
  dio: dio,
);
final authenticationRepository = AuthenticationRepository(
  apiService: apiService,
);
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.example.com',
  ),
);

final navigationService = NavigationService(
  navigatorKey,
);

final List<BlocProvider> providers = [
  BlocProvider<LocaleCubit>(
    create: (_) => LocaleCubit(),
  ),
];
