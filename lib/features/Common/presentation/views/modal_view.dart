import 'dart:ui';

import 'package:flutter/material.dart';

class ModalView extends StatelessWidget {
  final Widget child;
  const ModalView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(48),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: child,
    );
  }
}
