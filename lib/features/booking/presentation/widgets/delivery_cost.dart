import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/cupertino.dart';

class DeliveryCost extends StatelessWidget {
  final String amountCurrency;
  final String amount;

  const DeliveryCost({
    super.key,
    required this.amountCurrency,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: context.tt('Delivery cost', "تكلفة التوصيل"),
        style: TextStyle(
          fontFamily: "outfit",
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 25.2 / 16,
          color: AppColor.lightGrey,
        ),
        children: <TextSpan>[
          TextSpan(text: "   "),
          TextSpan(
            text: amountCurrency,
            style: TextStyle(
              fontFamily: "outfit",
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.2,
              color: AppColor.primaryColor,
            ),
          ),
          TextSpan(
            text: amount,
            style: TextStyle(
              fontFamily: "outfit",
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1.2,
              color: AppColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
