import 'package:flutter/widgets.dart'; 
class ContactUsLocalModel {
  final String title;
  final String? subtitle;
  final void Function() onTap;
  final Widget iconSvg;

  ContactUsLocalModel({
    required this.title,
    this.subtitle,
    required this.onTap,
    required this.iconSvg,
  });
}
