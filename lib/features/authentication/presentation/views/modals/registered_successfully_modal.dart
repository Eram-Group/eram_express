import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/utils/show_modal.dart';
import 'package:eram_express_shared/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../widgets/custom_modal.dart';

class RegisteredSuccessfullyModal extends StatelessWidget {
  const RegisteredSuccessfullyModal({super.key});

  Future<void> show(BuildContext context) async =>
      await showModal(context, (context) => this);

  @override
  Widget build(BuildContext context) {
    return CustomModal(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 210,
              child: OverflowBox(
                alignment: Alignment.topCenter,
                minHeight: 0,
                maxHeight: 320,
                child: SvgPicture.asset(
                  'assets/illustrations/registered-successfully.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(20),
            Text(
              context.tt('Registered Successfully', 'تم التسجيل بنجاح'),
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 22,
                height: 1.3,
                color: Color(0xFF191D31),
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            Text(
              context.tt(
                'You have successfully registered to Eram Express. You can now start shipping with us.',
                'لقد قمت بالتسجيل بنجاح في إيرام إكسبريس. يمكنك الآن البدء في الشحن معنا.',
              ),
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.8, // 25.2px / 14px = 1.8
                color: Color(0xFFA7A9B7),
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            CustomButton(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                context.tt('Awesome! Let\'s Go', 'رائع! هيا بنا'),
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.3,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
