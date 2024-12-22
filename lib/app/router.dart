import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import '../features/authentication/presentation/views/screens/complete_profile/complete_profile_view.dart';
import '../features/authentication/presentation/views/screens/login/login_view.dart';
import '../features/authentication/presentation/views/screens/otp/otp_view.dart';
import '../features/booking/presentation/views/all_booking_request_view.dart';
import '../features/booking/presentation/views/offers_view.dart';
import '../features/google_map/presentation/search_model_view/search_view.dart';
import '../features/google_map/presentation/views/google_map_view.dart';
import '../features/home/presentation/views/home_view.dart';
import '../features/init/presentation/views/init_view.dart';
import '../features/nav_bar/bottom_nav_bar.view.dart';
import '../features/profile/presentation/views/about_us_presentation/about_us_view.dart';
import '../features/profile/presentation/views/contact_us_presentation/contact_view.dart';
import '../features/profile/presentation/views/edit_profile_view.dart';
import '../features/profile/presentation/views/profile_presentation/profile_view.dart';
import '../features/profile/presentation/views/support_presentation/support_view.dart';
import '../features/profile/presentation/views/terms_presentation/terms_view.dart';
import 'presentation/views/not_found.view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  Widget page;

  final name = settings.name;

  if (name == null) {
    return null;
  }

  if (name == InitView.route) {
    page = const InitView();
  } else if (name == LoginView.route) {
    page = const LoginView();
  } else if (name == NavigationView.route) {
    page = const NavigationView();
  } else if (name == OtpView.route) {
    final arguments = settings.arguments as OtpViewArguments;
    page = OtpView(arguments);
  } else if (name == CompleteProfileView.route) {
    page = const CompleteProfileView();
  } else if (name == HomeView.route) {
    page = const HomeView();
  } else if (name == GoogleMapView.route) {
    final arguments = settings.arguments as GoogleMapViewArguments?;
    page = GoogleMapView(
      googleMapViewArguments: arguments,
    );
  } else if (name == SearchView.route) {
    page = const SearchView();
  } else if (name == OffersView.route) {
    final arguments = settings.arguments as OfferViewArguments;
    page = OffersView(
      arguments: arguments,
    );
  } else if (name == AllBookingRequestView.route) {
    final arguments = settings.arguments as AllBookingRequestViewArguments;
    page = AllBookingRequestView(
      arguments: arguments,
    );
  } else if (name == ProfileView.route) {
    page = ProfileView();
  } else if (name == AboutUsView.route) {
    page = AboutUsView();
  } else if (name == TermsView.route) {
    page = TermsView();
  } else if (name == TermsView.route) {
    page = TermsView();
  } else if (name == ContactUsView.route) {
    page = ContactUsView();
  } else if (name == SupportView.route) {
    page = SupportView();
  } else if (name == EditProfileView.route) {
    final arguments = settings.arguments as EditProfileViewArguments;
    page = EditProfileView(arguments);
  } else {
    //logger.debug(name);
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
