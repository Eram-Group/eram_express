import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Skeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BoxShape shape;
  const Skeleton({
    super.key,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
  });

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    controller
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: widget.shape == BoxShape.rectangle
            ? BorderRadius.circular(10)
            : null,
        shape: widget.shape,
      ),
    )
        .animate(
      controller: controller,
      onPlay: (controller) => controller.repeat(
        period: const Duration(
          seconds: 1,
        ),
      ),
      autoPlay: true,
    )
        .shimmer(
      colors: [
        Colors.black.withOpacity(0.15),
        Colors.black.withOpacity(0.05),
        Colors.black.withOpacity(0.15),
      ],
    );
  }
}
