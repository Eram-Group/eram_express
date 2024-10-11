import 'package:flutter/material.dart';

import 'clickable.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final bool enabled;
  final bool loading;
  final Widget? child;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    this.width = double.infinity,
    this.height = 44,
    this.enabled = true,
    this.loading = false,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Clickable(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF424BB3),
          borderRadius: BorderRadius.circular(10),
        ),
        splashColor: const Color(0xFF424BB3).withOpacity(0.5),
        onTap: onTap,
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
