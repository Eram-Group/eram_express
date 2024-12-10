import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/ServiceLocator.dart';
import 'app/app.dart';
import 'features/i18n/domain/locale_cubit.dart';

void main() {
  ServiceLocator().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => sl<LocaleCubit>(), 
          
        ),
      ],
      child: const App(),
    ),
  );
}
