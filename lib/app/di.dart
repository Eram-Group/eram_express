import 'package:dio/dio.dart';
import 'package:eram_express/features/i18n/domain/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/navigation_service.dart';


import 'navigation.dart';

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
