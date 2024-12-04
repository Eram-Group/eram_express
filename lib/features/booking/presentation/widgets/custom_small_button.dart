import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class CustomSmallButton extends StatelessWidget {
  final Color? color;
  final String text;
  final Color? colorText;
  final Color? colorBorder;
  final EdgeInsetsGeometry? padding;
  final void Function() onTap;
  const CustomSmallButton({
    this.color = AppColor.primaryColor,
    required this.text,
    this.colorText = Colors.white,
    this.colorBorder = AppColor.primaryColor,
    this.padding = const EdgeInsets.all(10.0),
  required  this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colorBorder ?? AppColor.borderColor,
            )),
        padding: padding,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colorText,
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
