import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/app_colors.dart';

class CustomSmallButton extends StatelessWidget {
  final Color? color;
  final String text;
  final Color? colortext;
  final Color? colorborder;
  final EdgeInsetsGeometry? padding;
  const CustomSmallButton({
    this.color = AppColor.primaryColor,
    required this.text,
    this.colortext = Colors.white,
    this.colorborder = AppColor.primaryColor,
    this.padding = const EdgeInsets.all(10.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //await AcceptOrderModal().show(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colorborder ?? AppColor.bordercolor,
            )),
        padding: padding,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colortext,
            fontWeight: FontWeight.w500,
            fontFamily: "outfit",
            fontSize: Responsive.getResponsiveFontSize(context, fontSize: 16),
            height:
                20.8 / Responsive.getResponsiveFontSize(context, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
