import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final Widget child;
  const CustomModal({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFE2EB),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
