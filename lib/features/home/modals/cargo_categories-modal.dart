import 'package:eram_express/features/Common/presentation/widgets/empty_state_widget.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:eram_express_shared/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../core/app_colors.dart';
import '../../Common/presentation/widgets/clickablebottomSheetItem.dart';
import '../presentation/views/home_view_controller.dart';
import '../presentation/views/home_view_state.dart';
import '../presentation/widgets/top_bottom_model.dart';

class SelectCargoCategoryModal extends StatelessWidget {
  final HomeViewController cubit;
  const SelectCargoCategoryModal({
    required this.cubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: cubit,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TopBottomModel(),
            Text(
              context.tt("Choose the size of the truck", "اختر حجم الشاحنة"),
              style: TextStyle(
                color: Color(0xff191D31),
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 23.4 / 20,
              ),
            ),
            const Gap(12),
            Expanded(
              child: BlocBuilder<HomeViewController, HomeViewState>(
                builder: (context, state) {
                  logger.debug("yaleeeeeeeeeeeey");
                  if (state.isLoading) {
                    return EmptyLoadingWidget();
                  } else if (state.cargoCategories == null) {
                    return const Center(child: Text('No categories available'));
                  } else {
                    return SingleChildScrollView(
                        child: Column(
                      children: state.cargoCategories!.map((cargo) {
                        return BlocSelector<HomeViewController, HomeViewState,
                            bool>(
                          selector: (state) => state.loadType == cargo,
                          builder: (context, isSelected) {
                            return ClickBottomSheetItem(
                              imageUrl: cargo.imageUrl,
                              isSelected: isSelected,
                              onTap: () {
                                //cubit.setTruckSize(cargo);
                                Navigator.of(context).pop(cargo);
                              },
                              content: Text(
                                cargo.nameEn,
                                style: TextStyle(
                                  color: AppColor.blacktext,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 18.2 / 20,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ));
                  }
                },
              ),
            ),
          ],
        ));
  }
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
