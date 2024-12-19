

import 'package:eram_express_shared/core/app_colors.dart';
import 'package:eram_express_shared/core/app_text_style.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/widgets/clickable.dart';
import 'package:eram_express_shared/presentation/widgets/skeleton.dart';
import 'package:eram_express_shared/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../Common/presentation/widgets/SvgIcon.dart';
import '../../../data/models/contact_us_local_model.dart';
import '../../../data/models/contact_us_model.dart';
import '../../widgets/customappbar.widgets.dart';

import 'contact_view_model.dart';
import 'contact_view_state.dart';

class ContactUsView extends StatelessWidget {
  ContactUsView({super.key});
  static const String route = "/contact_us";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.tt("Contact Us", "تواصل معنا"),
      ),
      body: BlocProvider<ContactViewModel>(
          create: (context) => sl()..getContactUs(),
          child: BlocBuilder<ContactViewModel, ContactViewState>(
              builder: (context, state) {
            if (state.isError) {
              return Center(child: Text(state.errorMessage!));
            } else if (state.isLoaded) {
              return SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCommunicationContainer(
                          context, state.contactUsModel!),
                      const Gap(20),
                     _buildSupportContiner(context, state.contactUsModel!),
                     // const Gap(20),
                      Text(context.tt("Follow Us", "تابعنا"), style: AppTextStyles().titleContact(context)),
                      _buildSocialMediaAccounts(
                          context, state.contactUsModel!),
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


Widget _buildSquareContainer( ContactUsLocalModel contactItem, BuildContext context) {

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
          style:AppTextStyles().titleContact(context, fontSize: 18),
        ),
        Text(
          textAlign: TextAlign.center,
          contactItem.subtitle!,
          style: AppTextStyles().subtitleContact(context),
        ),
      ],
    ),
  );
}

Widget _buildCommunicationContainer( BuildContext context, ContactUsModel contactUsModel) {
  List<ContactUsLocalModel> contactItems =ContactUsItems(context).generateContactItems(contactUsModel);
  return IntrinsicHeight(
      child: Row(
    children: [
      Expanded(
        child: _buildSquareContainer(contactItems[0], context),
      ),
      const Gap(20),
      Expanded(child: _buildSquareContainer(contactItems[1], context))
    ],
  ));
}

Widget _buildSupportContiner( BuildContext context, ContactUsModel contantusmodel) {
  List<ContactUsLocalModel> contactItems = ContactUsItems(context).generateSupportItems();
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
                style:AppTextStyles(). titleContact(context, fontSize: 18),
              ),
              Text(
                contactItems[0].subtitle!,
                style: AppTextStyles().subtitleContact(context, fontSize: 15),
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

Widget _buildSocialMediaAccounts( BuildContext context, ContactUsModel contantUsModel) {
  List<ContactUsLocalModel> contactItems = ContactUsItems(context).generateSocialMediaItems(contantUsModel);
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

