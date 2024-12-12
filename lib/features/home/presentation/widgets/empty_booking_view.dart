import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/app_text_style.dart';
import '../../../Common/presentation/widgets/SvgIcon.dart';

class EmptyBookingView extends StatelessWidget {
  const EmptyBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgIcon(
            asset: "empty-state-request",
            size: 60,
          ),
          const Gap(10),
          Text(
            context.tt("No Request add yet ", "لم يتم إضافة أي طلب بعد."),
            style: AppTextStyles.headerModal,
          ),
          const Gap(10),
          Text(
            context.tt("Right now no Request add, you can add new order",
                "لا يوجد أي طلب مضاف حاليًا، يمكنك إضافة طلب جديد."),
            style: AppTextStyles.smallTitle,
          ),
        ],
      ),
    );
  }
}
