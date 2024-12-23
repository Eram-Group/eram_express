import 'package:eram_express_shared/core/i18n/app_localizations_setup.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/notification_service.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/i18n/domain/locale_cubit.dart';
import '../features/init/presentation/views/init_view.dart';
import 'service_locator.dart';
import 'navigation.dart';
import 'presentation/theme.dart';
import 'router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final notificationService = sl<NotificationService>();
      await Future.wait([
        notificationService.cancelAll(),
        notificationService.getDeviceTokenId(),
      ]);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (_, Locale locale) => MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
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
