import 'package:eram_express/features/authentication/presentation/views/modals/registered_successfully_modal.dart';
import 'package:eram_express/features/profile/presentation/widgets/customappbar.widgets.dart';
import 'package:eram_express_shared/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
/*
class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tt("Support", "الدعم")),
      body: Column(
        children: [
          Text(
            context.tt(
                "Don’t hesitate to contact us whether you have a suggestion on our improvement, a complain to discuss or an issue to solve.",
                "لا تتردد في التواصل معنا سواء كان لديك اقتراح لتحسين خدماتنا، شكوى ترغب في مناقشتها، أو مشكلة تحتاج إلى حل"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Responsive.getResponsiveFontSize(context, fontSize: 15),
              fontFamily: 'ourfit',
              fontWeight: FontWeight.w500,
              height: 24.6 /
                  Responsive.getResponsiveFontSize(context, fontSize: 15),
              letterSpacing: -0.32,
              color: Color(0xff717171),
            ),
          ),
          _title(context.tt("Select reason", "اختار السبب"), context),
          //dropdonww
          _title(context.tt("Detail message", "تفاصيل الرسالة"), context),
          _description(context)
        ],
      ),
    );
  }
}

_title(String title, BuildContext context) {
  return Text(
    title,
    style: TextStyle(
      fontSize: Responsive.getResponsiveFontSize(context, fontSize: 14),
      fontFamily: 'ourfit',
      fontWeight: FontWeight.w500,
      height: 15.6 / Responsive.getResponsiveFontSize(context, fontSize: 14),
      letterSpacing: -0.32,
      color: AppColor.blacktext,
    ),
  );
}

Widget _description(BuildContext context) {
  return TextFormField(
    maxLines: 4,
    decoration: InputDecoration(
      hintText: context.tt('YOUR MESSAGE ', ' رسالتك '),
      hintStyle: TextStyle(
        color: const Color(0xffA7A9B7),
        fontSize: Responsive.getResponsiveFontSize(context, fontSize: 15),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColor.bordercolor,
        ),
      ),
    ),
    onChanged: (value) => () {},
  );
}
*/