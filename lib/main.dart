import 'package:eram_express_shared/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'app/app.dart';
import 'app/service_locator.dart';
import 'features/i18n/domain/locale_cubit.dart';

void main()
 {
  SharedServiceLocator().init();
  ServiceLocator().init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LocaleCubit>(
        create: (_) => sl<LocaleCubit>(),
      ),
    ],
    child: const RequestsInspector(
      enabled: true,
      child: App(),
    ),
  ));
}
