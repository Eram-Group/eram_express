import 'package:flutter/widgets.dart'; 
class ContactUsViewModel {
  final String title;
  final String? subtitle;
  final void Function() onTap;
  final Widget iconSvg;

  ContactUsViewModel({
    required this.title,
    this.subtitle,
    required this.onTap,
    required this.iconSvg,
  });
}
