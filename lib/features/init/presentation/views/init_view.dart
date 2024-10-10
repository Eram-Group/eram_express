import 'package:flutter/material.dart';

import '../../../../app/di.dart';
import '../../../authentication/presentation/views/screens/login/login_view.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mainNavigationService.clearStackAndNavigateTo(LoginView.route);
    });
  }
}
