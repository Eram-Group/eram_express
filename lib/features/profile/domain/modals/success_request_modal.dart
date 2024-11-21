import 'package:eram_express_shared/core/app_colors.dart';
import 'package:eram_express_shared/core/app_text_style.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/utils/show_modal.dart';
import 'package:eram_express_shared/presentation/views/modals/custom_modal.dart';
import 'package:eram_express_shared/presentation/widgets/custom_small_button.dart';
import 'package:eram_express_shared/presentation/widgets/status_icon_widgets.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../presentation/views/contact_us_presentation/contact_view.dart';

class SuccessfulRequestModal extends StatelessWidget {
  const SuccessfulRequestModal({super.key});
  Future<void> show(BuildContext context) async =>
      await showModal(context, (context) => this);
  @override
  Widget build(BuildContext context) {
    return CustomModal(
        child: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 30),
      child: Column(
        children: [
          const StatusIconWidget(
            assetname: "success",
          ),
          const Gap(10),
          Text(
            context.tt("Your request has been successfully submitted.",
                "تم إرسال طلبك بنجاح."),
            style: AppTextStyles.HeaderModal,
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          Text(
            context.tt(
                "Our dedicated team will review your request and get back to you as soon as possible",
                "سيقوم فريقنا المختص بمراجعة طلبك والرد عليك في أقرب وقت ممكن"),
            style: AppTextStyles.subHeaderModal,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          Center(
              child: CustomSmallButton(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pushNamed(context, ContactUsView.route);
            },
            padding: const EdgeInsets.all(12),
            text: context.tt("Back", "الرجوع"),
            colortext: AppColor.blacktext,
            colorborder: AppColor.lightGrey,
            color: Colors.white,
          ))
        ],
      ),
    )));
  }
}
