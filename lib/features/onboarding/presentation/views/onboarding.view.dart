import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  static const route = '/onboarding';

  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMobileView(context),
    );
  }

  Stack _buildMobileView(BuildContext context) {
    final stupidImageOffset = Responsive.responsiveValue(
      screenWidth: MediaQuery.of(context).size.width,
      mobileValue: 120.0,
      tabletValue: 220.0,
    );

    return Stack(
      children: [
        Positioned(
          top: -1 * stupidImageOffset,
          left: stupidImageOffset * -1,
          child: Image.asset(
            'assets/images/onboarding.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width + stupidImageOffset,
          ),
        ),
        Positioned(
          bottom: 350,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to the app',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'This is a simple onboarding screen',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
