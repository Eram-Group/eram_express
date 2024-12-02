import 'package:eram_express/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../home/presentation/modals/cargo_categories-modal.dart';

//ToDo   convert to skenelozier

class EmptyLoadingWidget extends StatelessWidget {
  const EmptyLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildemptyContainer();
        });
  }
}
Widget _buildemptyContainer() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ).copyWith(bottom: 0),
    child: Skeleton(
      child: Container(
        height: 90,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColor.bordercolor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
        ),
      ),
    ),
  );
}


class Skeleton extends StatefulWidget {
  final Widget child;
  const Skeleton({
    super.key,
    required this.child,
  });

  @override
  State<Skeleton> createState() => _SkeletonState();

  static circle({required double radius}) => Skeleton(
        child: Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            //color: TailwindPalette.slate.shade100,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );
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
    return widget.child
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
        Colors.black.withOpacity(0.45),
        Colors.black.withOpacity(0.35),
        Colors.black.withOpacity(0.45),
      ],
    );
  }
}
