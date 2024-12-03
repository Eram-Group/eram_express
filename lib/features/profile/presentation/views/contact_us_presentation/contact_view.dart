import 'package:eram_express/features/profile/presentation/views/profile_presentation/profile_view.dart';
import 'package:eram_express_shared/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:eram_express_shared/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../app/di.dart';
import '../../../data/models/contact_us_model.dart';
import '../../../data/models/contact_us_local_model.dart';
import '../../widgets/customappbar.widgets.dart';
import 'contact_view_model.dart';
import 'contact_view_state.dart';

class ContactUsView extends StatelessWidget {
  ContactUsView({super.key});
  static const String route = "/contact_us";
  final ContactUsViewModel =
      ContactViewModel(profileRepository: profileRepository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.tt("Contact Us", "تواصل معنا"),
      ),
      body: BlocProvider(
          create: (context) => ContactUsViewModel..getContactUs(),
          child: BlocBuilder<ContactViewModel, ContactViewState>(
              builder: (context, state) {
            if (state is ContactViewErrorState) {
              return Center(child: Text(state.errormesseg));
            } else if (state is ContactViewLoadedState) {
              return SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCommuicationContainer(
                          context, state.contactUsViewModel),
                      const Gap(20),
                      _buildSupportContiner(context, state.contactUsViewModel),
                      const Gap(20),
                      Text(context.tt("Follow Us", "تابعنا"),
                          style: titleContact(context)),
                      _buildSocailMediaAccounts(
                          context, state.contactUsViewModel),
                    ],
                  ),
                ),
              );
            } else {
              return _buildLoadingContactUs();
            }
          })),
    );
  }
}

Widget _buildsquareContainer(
    ContactUsViewModel contactItem, BuildContext context) {
  return Clickable(
    onTap: contactItem.onTap,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        color: AppColor.bordercolor,
        width: 2,
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        contactItem.iconSvg,
        const Gap(10),
        Text(
          contactItem.title,
          textAlign: TextAlign.center,
          style: titleContact(context, fontSize: 18),
        ),
        Text(
          textAlign: TextAlign.center,
          contactItem.subtitle!,
          style: subtitleContact(context),
        ),
      ],
    ),
  );
}

Widget _buildCommuicationContainer(
    BuildContext context, ContactUsModel contantusmodel) {
  List<ContactUsViewModel> contactItems =
      ContactUsItems(context).generateContactItems(contantusmodel);
  return IntrinsicHeight(
      child: Row(
    children: [
      Expanded(
        child: _buildsquareContainer(contactItems[0], context),
      ),
      const Gap(20),
      Expanded(child: _buildsquareContainer(contactItems[1], context))
    ],
  ));
}

Widget _buildSupportContiner(
    BuildContext context, ContactUsModel contantusmodel) {
  List<ContactUsViewModel> contactItems =
      ContactUsItems(context).generateSupportItems();
  return Clickable(
      onTap: contactItems[0].onTap,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColor.bordercolor,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        children: [
          contactItems[0].iconSvg,
          const Gap(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contactItems[0].title,
                style: titleContact(context, fontSize: 18),
              ),
              Text(
                contactItems[0].subtitle!,
                style: subtitleContact(context, fontSize: 15),
              ),
            ],
          ),
          const Spacer(),
          const SvgIcon(
            asset: "arrow-left",
            size: 30,
          )
        ],
      ));
}

Widget _buildLoadingContactUs() {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                  child: Skeleton(
                borderRadius: 20,
                height: 180,
                shape: BoxShape.rectangle,
              )),
              const Gap(20),
              Expanded(
                child: Skeleton(
                  borderRadius: 20,
                  height: 180,
                  shape: BoxShape.rectangle,
                ),
              ),
            ],
          ),
          const Gap(20),
          const Skeleton(
            height: 80,
            shape: BoxShape.rectangle,
            borderRadius: 20,
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => const Skeleton(
                borderRadius: 5,
                width: 50,
                height: 50,
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ],
      ));
}

Widget _buildSocailMediaAccounts(
    BuildContext context, ContactUsModel contantusmodel) {
  List<ContactUsViewModel> contactItems =
      ContactUsItems(context).generateSocialMediaItems(contantusmodel);
  return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: contactItems.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                    onTap: contactItems[index].onTap,
                    child: contactItems[index].iconSvg));
          }));
}

//TODo Move it to Shared

TextStyle titleContact(BuildContext context, {double fontSize = 22}) {
  return TextStyle(
      fontSize: Responsive.getResponsiveFontSize(context, fontSize: fontSize),
      fontFamily: 'ourfit',
      fontWeight: FontWeight.w600,
      height:
          24.6 / Responsive.getResponsiveFontSize(context, fontSize: fontSize));
}

TextStyle subtitleContact(BuildContext context, {double fontSize = 12}) {
  return TextStyle(
    fontSize: Responsive.getResponsiveFontSize(context, fontSize: fontSize),
    fontFamily: 'ourfit',
    fontWeight: FontWeight.w500,
    height:
        24.6 / Responsive.getResponsiveFontSize(context, fontSize: fontSize),
    letterSpacing: -0.32,
    color: Color(0xff717171),
  );
}
