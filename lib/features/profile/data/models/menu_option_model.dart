import 'package:flutter/material.dart';

class MenuOptionModel {
  final String title;
  final void Function() onTap;
  final Widget icon;

  MenuOptionModel({
    required this.title,
    required this.onTap,
    required this.icon,
  });
}
