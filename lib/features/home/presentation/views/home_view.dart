import 'package:cached_network_image/cached_network_image.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/views/modals/image_picker_modal/image_picker_modal.dart';
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
      body: Column(
        children: [
          FutureBuilder(
            future: authenticationRepository.authenticatedCustomer,
            builder: (context, snapshot) {
              return Column(
                children: [
                  if (snapshot.data != null &&
                      snapshot.data!.image != null &&
                      snapshot.data!.image!.isNotEmpty)
                    CachedNetworkImage(imageUrl: snapshot.data!.image!),
                  Text(snapshot.data?.fullName ?? 'Anonymous'),
                ],
              );
            },
          ),
          ElevatedButton(
            onPressed: () =>
                ImagePickerModal(onImagePicked: (_) {}).show(context),
            child: Text(
              context.tt(
                'Pick image',
                'اختر صورة',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => authenticationService.logout(
              onLogout: () => Navigator.of(context).pushNamedAndRemoveUntil(
                LoginView.route,
                (route) => false,
              ),
            ),
            child: Text(context.tt('Logout', 'تسجيل الخروج')),
          ),
        ],
      ),
    );
  }
}
