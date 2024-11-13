import 'package:eram_express/features/Common/presentation/widgets/SvgIcon.dart';
import 'package:eram_express/features/booking/presentation/temp_offers_view.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/utils/show_modal.dart';
import 'package:eram_express_shared/presentation/views/modals/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../core/app_text_style.dart';
import 'booking/presentation/widgets/custom_small_button.dart';

class CancelOrderModal extends StatelessWidget {
  const CancelOrderModal({super.key});
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
            assetname: "error",
          ),
          const Gap(10),
          Text(
            context.tt("You will pay fees on canceling order!",
                "ستدفع رسوم عند إلغاء الطلب!"),
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
                  text: context.tt("back", "العودة"),
                  padding: const EdgeInsets.all(12),
                ),
              ),
              Gap(10),
              Expanded(
                  child: CustomSmallButton(
                       onTap: () {},
                padding: const EdgeInsets.all(12),
                text: context.tt("Cancel Order", "إلغاء الطلب"),
                colortext: Colors.red,
                colorborder: Colors.red,
                color: Colors.white,
              )),
            ],
          )
        ],
      ),
    )));
  }
}

//common widget should move to eram shared
class StatusIconWidget extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color shadowColor;
  final String assetname;

  const StatusIconWidget({
    Key? key,
    this.size = 90.0,
    required this.assetname,
    this.backgroundColor = Colors.white,
    this.shadowColor = const Color(0xffB1B8C8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            blurRadius: 80,
            spreadRadius: 0,
            color: shadowColor.withOpacity(0.25),
          ),
        ],
      ),
      child: Center(
        child: SvgIcon(
          asset: assetname,
          size: size * 0.5,
        ),
      ),
    );
  }
}
