import 'package:eram_express/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:flutter/material.dart';

import '../features/authentication/presentation/views/login_view.dart';
import '../features/home/presentation/views/home_view.dart';
import '../features/init/presentation/views/init_view.dart';

import 'presentation/views/not_found.view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  Widget page;

  final name = settings.name;

  if (name == null) {
    return null;
  }

  if (name == InitView.route) {
    page = const InitView();
  } else if (name == Onboardingview.route) {
    page = const Onboardingview();
  } else if (name == LoginView.route) {
    page = const LoginView();
  } else if (name == HomeView.route) {
    page = const HomeView();
  } else {
    page = const NotFoundView();
  }

  return _buildPageRoute(settings, page);
}

MaterialPageRoute<void> _buildPageRoute(RouteSettings settings, Widget page) {
  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => page,
  );
}
