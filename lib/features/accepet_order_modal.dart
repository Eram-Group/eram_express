import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express/features/booking/presentation/temp_offers_view.dart';
import 'package:eram_express/features/home/presentation/views/home_view.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/utils/show_modal.dart';
import 'package:eram_express_shared/presentation/views/modals/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../core/app_text_style.dart';
import 'booking/presentation/widgets/custom_small_button.dart';
import 'cancel_order_modal.dart';

class AcceptOrderModal extends StatelessWidget {
  const AcceptOrderModal({super.key});
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
            context.tt("Accept the Person", "قبول الشخص"),
            style: AppTextStyles.HeaderModal,
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          Text(
            "Congratulation! your package will be picked up by the courier, please wait a moment",
            style: AppTextStyles.subHeaderModal,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: CustomSmallButton(
                  onTap: () {},
                  text: context.tt("Go to your order", "اذهب إلى طلبك"),
                  padding: EdgeInsets.all(12),
                ),
              ),
              const Gap(10),
              Expanded(
                child: CustomSmallButton(
                onTap: () 
                {
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, HomeView.route);
                },
                padding:const EdgeInsets.all(12),
                text: context.tt("Go to Home", "الذهاب إلى الصفحة الرئيسية"),
                colortext: AppColor.blacktext,
                colorborder: AppColor.lightGrey,
                color: Colors.white,
              )),
            ],
          )
        ],
      ),
    )));
  }
}
