import 'package:eram_express/app/navigation.dart';
import 'package:eram_express/features/nav_bar/nav-bar-cubit.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'app/app.dart';
import 'app/navigation.dart';
import 'app/service_locator.dart';
import 'features/i18n/domain/locale_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedServiceLocator.init();
  ServiceLocator().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => sl<LocaleCubit>(),
        ),
        BlocProvider<NavBarCubit>(
          create: (_) => NavBarCubit(),
        ),
      ],
      child: RequestsInspector(
        enabled: true,
        navigatorKey: NavigationService.navigatorKey,
        child: const App(),
      ),
    ),
  );
}
