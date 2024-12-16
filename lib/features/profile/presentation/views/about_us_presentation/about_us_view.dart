import 'package:eram_express_shared/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eram_express/features/authentication/presentation/views/screens/login/login_view.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter_html/flutter_html.dart';


import '../../widgets/customappbar.widgets.dart';
import 'about_us_view_model.dart';
import 'about_us_view_state.dart';

class AboutUsView extends StatelessWidget {
  static const String route = "/about_us";
  AboutUsView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.tt("About Us", "معلومات عنا"),
      ),
      body: BlocProvider<AboutUsViewModel>(
        create: (context) => sl()..getAboutUs(),
        child: SafeArea(
          child: BlocBuilder<AboutUsViewModel, AboutUsViewState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.isLoaded) {
                return Container(
                  padding:const EdgeInsets.all(16.0),
                  child: Html(
                    data: context.tt(state.aboutUsModel!.contentEn,
                        state.aboutUsModel
                        !.contentEn),
                  ),
                );
              } else if (state.isError) {
                return const Center(child: Text("Failed to load about us data"));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
