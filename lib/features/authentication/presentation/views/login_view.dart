import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../app/di.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../logic/cubit/authentication_cubit.dart';

class LoginView extends HookWidget {
  static const String route = '/login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedItem = useState<String?>(null);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              _goToHome();
            } else if (state is AuthenticationFailure) {
              _showError(context, state);
            }
          },
          child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('Item 1')),
                      DropdownMenuItem(value: '2', child: Text('Item 2')),
                      DropdownMenuItem(value: '3', child: Text('Item 3')),
                    ],
                    onChanged: (value) => selectedItem.value = value,
                  ),
                  const SizedBox(height: 32.0),
                  Text(
                    'Selected item: ${selectedItem.value}',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorDialog(AuthenticationFailure state, BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(state.message),
      actions: [
        TextButton(
          onPressed: () => navigationService.back(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  _goToHome() => navigationService.clearStackAndNavigateTo(HomeView.route);

  _showError(BuildContext context, AuthenticationFailure state) {
    showDialog(
      context: context,
      builder: (context) => _buildErrorDialog(state, context),
    );
  }
}
