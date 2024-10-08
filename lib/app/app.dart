import 'package:eram_express/core/i18n/app_localizations_setup.dart';
import 'package:eram_express/features/i18n/domain/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/responsive.dart';
import '../features/init/presentation/views/init_view.dart';
import 'navigation.dart';
import 'router.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (_, Locale locale) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: InitView.route,
        onGenerateRoute: onGenerateRoute,
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localizationsDelegates: AppLocalizationsSetup.delegates,
        localeResolutionCallback:
            AppLocalizationsSetup.localeResolutionCallback,
        locale: locale,
      ),
    );
  }
}
