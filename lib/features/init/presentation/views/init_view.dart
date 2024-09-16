import 'package:eram_express/app/Sharded_preference_Keys.dart';
import 'package:eram_express/core/Services/Shared_preference_service.dart';
import 'package:eram_express/features/SplashView/splash_view.dart';

import 'package:eram_express/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:flutter/material.dart';

import '../../../../app/di.dart';
import '../../../authentication/presentation/views/login_view.dart';

class InitView extends StatefulWidget {
  static const String route = '/';
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) 
    {
      
      navigationService.clearStackAndNavigateTo(SharedPreferenceService.getbool(PrefsKeys.firstOpen) ==false? Onboardingview.route: LoginView.route );
    });
  }
}
