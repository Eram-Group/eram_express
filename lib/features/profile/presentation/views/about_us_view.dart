import 'package:eram_express/features/authentication/presentation/views/screens/login/login_view.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';

import '../widgets/customappbar.widgets.dart';

class AboutUsView extends StatelessWidget
 {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: CustomAppBar(title: context.tt("About Us", "معلومات عنا"),),
      body: SafeArea(child:Container(),
      ),


    );
  }
}