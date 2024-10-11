import 'package:flutter/material.dart';

import '../../../../app/di.dart';
import 'init_view_model.dart';

class InitView extends StatelessWidget {
  static const String route = '/';

  final viewModel =
      InitViewModel(authenticationRepository: authenticationRepository);
  InitView({super.key}) {
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
