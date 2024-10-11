import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BoxDecoration? decoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Clip clipBehavior;
  final void Function()? onTap;
  final Color? splashColor;
  final Color? overlayColor;

  const Clickable({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.child,
    this.clipBehavior = Clip.none,
    this.onTap,
    this.splashColor,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      color: color,
      decoration: decoration,
      constraints: constraints,
      margin: margin,
      clipBehavior: clipBehavior,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          overlayColor: WidgetStateProperty.all(overlayColor),
          borderRadius: decoration?.shape == BoxShape.circle
              ? BorderRadius.circular(100)
              : decoration?.borderRadius?.resolve(TextDirection.ltr),
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
