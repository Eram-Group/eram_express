import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view.dart';
import 'package:eram_express/features/profile/presentation/views/terms_presentation/terms_view.dart';
import 'package:flutter/material.dart';

import '../features/authentication/presentation/views/screens/complete_profile/complete_profile_view.dart';
import '../features/authentication/presentation/views/screens/login/login_view.dart';
import '../features/authentication/presentation/views/screens/otp/otp_view.dart';
import '../features/home/presentation/views/home_view.dart';
import '../features/init/presentation/views/init_view.dart';
import '../features/onboarding/presentation/views/onboarding.view.dart';
import '../features/profile/presentation/views/about_us_presentation/about_us_view.dart';
import '../features/profile/presentation/views/contact_us_presentation/contact_view.dart';
import '../features/profile/presentation/views/edit_profile_view.dart';
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
  } else if (name == OtpView.route) {
    final arguments = settings.arguments as OtpViewArguments;
    page = OtpView(arguments);
  } else if (name == CompleteProfileView.route) {
    page = CompleteProfileView();
  } else if (name == HomeView.route) {
    page = const HomeView();
  } else if (name == ProfileView.route) {
    page = ProfileView();
  } else if (name == AboutUsView.route) {
    page = AboutUsView();
  } else if (name == TermsView.route) {
    page = TermsView();
  }
  else if (name == TermsView.route) 
  {
    page = TermsView();
  }
  else if (name == ContactUsView.route) 
  {
    page = ContactUsView();
  }
   else if (name == EditProfileView.route) 
  {
    final arguments = settings.arguments as EditProfileViewArguments;
    page = EditProfileView(arguments);
  } 
  
  else 
  {
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
