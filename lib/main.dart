import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/service_locator.dart';
import 'app/app.dart';
import 'features/i18n/domain/locale_cubit.dart';
import 'features/home/presentation/views/home_view_controller.dart';

void main() {
  ServiceLocator().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => sl<LocaleCubit>(),
        ),
        BlocProvider<HomeViewController>(
          create: (context) => sl<HomeViewController>()..initialHomeData(),
        ),
      ],
      child: const App(),
    ),
  );
}
