import 'package:flutter/material.dart';

class MenuOptionEntity {
  final String title;
  final void Function() onTap;
  final Widget icon;

  MenuOptionEntity({
    required this.title,
    required this.onTap,
    required this.icon,
  });
}
