import 'package:flutter/material.dart';

import '../../../../app/di.dart';
import '../../../authentication/presentation/views/screens/login/login_view.dart';

class HomeView extends StatelessWidget {
  static const String route = '/home';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => mainNavigationService.to(LoginView.route),
          child: const Text('Back to Login'),
        ),
      ),
    );
  }
}
