import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../app/di.dart';
import '../../widgets/customappbar.widgets.dart';
import 'terms_view_model.dart';
import 'terms_view_state.dart';

class TermsView extends StatelessWidget {
  static const String route = "/terms";
  TermsView({super.key});

  final termsViewModel = TermsViewModel(profileRepository: profileRepository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.tt("About Us", "معلومات عنا"),
      ),
      body: BlocProvider(
        create: (context) => termsViewModel..getTerms(),
        child: SafeArea(
          child: BlocBuilder<TermsViewModel, TermViewState>(
            builder: (context, state) {
              if (state is TermsViewLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TermsViewLoadedState) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Html(
                    data: context.tt(state.termsContent.contentEn,
                        state.termsContent.contentEn),
                  ),
                );
              } else if (state is TermsViewErrorState) {
                return Center(child: Text("Failed to load about us data"));
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
