import 'package:flutter/material.dart';
import '../features/authentication/presentation/views/screens/login/login_view.dart';
import '../features/google_map/presentation/search_model_view/search_view.dart';
import '../features/home/presentation/views/home_view.dart';
import '../features/init/presentation/views/init_view.dart';
import '../features/onboarding/presentation/views/onboarding.view.dart';
import '../features/tempgooglemap.dart';
import 'presentation/views/not_found.view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  Widget page;

  final name = settings.name;

  if (name == null) {
    return null;
  }

  if (name == InitView.route) {
    page = InitView();
  } else if (name == OnboardingView.route) {
    page = const OnboardingView();
  } else if (name == LoginView.route) {
    page = LoginView();
  } else if (name == HomeView.route) {
    page = HomeView();
  } else if (name == GoogleMapScreen.route) {
    page = GoogleMapScreen();
  } else if (name == SearchView.route) {
    page = SearchView();
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
