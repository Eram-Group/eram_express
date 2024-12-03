import 'package:eram_express_shared/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/utils/show_modal.dart';
import 'package:eram_express_shared/presentation/views/modals/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../data/models/language_model.dart';
import '../views/language_presentation/language_view_model.dart';
import '../views/language_presentation/language_view_state.dart';
import '../widgets/language_item.dart';

class LanguageModal extends StatelessWidget {
  const LanguageModal({Key? key}) : super(key: key);

  static const List<LanguageModel> languagesApp = [
    LanguageModel(language: "English", flag: "usa"),
    LanguageModel(language: "Arabic", flag: "sau"),
  ];
  Future<LanguageModel?> show(BuildContext context) async =>
      await showModal<LanguageModel?>(context, (context) => this);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageViewModel()..selectLanguage(languagesApp[0]), // Read from localcubit bs msh arafaa
      child: Builder(
        builder: (context) {
          return CustomModal(
              child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min, //حاولي ان تخليها قد ال child بس
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tt(' Select language', 'اختر اللغة'),
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize:
                        Responsive.getResponsiveFontSize(context, fontSize: 18),
                    height: 23.4 /
                        Responsive.getResponsiveFontSize(context, fontSize: 18),
                    color: AppColor.blacktext,
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...languagesApp
                            .map((language) =>
                                LanguageItemSelector(language: language))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}

class LanguageItemSelector extends StatelessWidget {
  final LanguageModel language;
  const LanguageItemSelector({Key? key, required this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LanguageViewModel, LanguageState, bool>(
      selector: (state) => state.selectedLanguage == language,
      builder: (context, isSelected) {
        return LanguageItem(
          languageoption: language,
          isSelected: isSelected,
          onTap: () 
          {
            context.read<LanguageViewModel>().selectLanguage(language);
          },
        );
      },
    );
  }
}
