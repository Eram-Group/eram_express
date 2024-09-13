import 'package:flutter/material.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: InitView.route,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
