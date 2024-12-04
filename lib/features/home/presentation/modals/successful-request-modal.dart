import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/utils/show_modal.dart';
import 'package:eram_express_shared/presentation/views/modals/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/app_text_style.dart';
import '../../../booking/presentation/widgets/custom_small_button.dart';
import '../../../booking/presentation/modals/cancel_order_modal.dart';

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
            assetName: "success",
          ),
          const Gap(10),
          Text(
            context.tt("The request has been added successfully.",  "تمت إضافة الطلب بنجاح"),
            style: AppTextStyles.headerModal,
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          Text(
            context.tt("You will wait for driver response to add there bid.", "ستنتظر رد السائق لإضافة عرضه."),
            style: AppTextStyles.subHeaderModal,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          Center(
              child: CustomSmallButton(
            onTap: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(12),
            text: context.tt("Back", "الرجوع"),
            colorText: AppColor.blackText,
            colorBorder: AppColor.lightGrey,
            color: Colors.white,
          ))
        ],
      ),
    )));
  }
}
