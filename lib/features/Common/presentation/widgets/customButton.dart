import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? TextColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    super.key,
    this.onPressed,
    this.TextColor,
    required this.text,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    this.backgroundColor = Colors.white,
  });

  ButtonStyle _buttonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      side: BorderSide(
        strokeAlign: BorderSide.strokeAlignCenter,
        color: borderColor ?? Color(0xffA7A9B7),
      ),
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
          onPressed: onPressed,
          style: _buttonStyle(context),
          child: Text(
            text,
            style: TextStyle(
                color: TextColor,
                fontWeight: FontWeight.w500,
                height: 20.8 / 20,
                fontSize:
                    Responsive.getResponsiveFontSize(context, fontSize: 18)),
          )),
    );
  }
}
