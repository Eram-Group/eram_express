import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/app_colors.dart';
import '../../../Common/presentation/widgets/clickablebottomSheetItem.dart';
import '../views/home_view_controller.dart';
import '../views/home_view_state.dart';
import '../widgets/top_bottom_model.dart';

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
              style: const TextStyle(
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
                  if (state.homeModel!.categories.isEmpty) {
                    return const Center(child: Text('No categories available'));
                  } else {
                    return SingleChildScrollView(
                        child: Column(
                         children: state.homeModel!.categories.map((cargo) {
                        return BlocSelector<HomeViewController, HomeViewState,
                            bool>(
                          selector: (state) => state.loadType == null
                              ? false
                              : state.loadType!.id == cargo.id,
                          builder: (context, isSelected) {
                            return ClickBottomSheetItem(
                              imageUrl: cargo.image,
                              isSelected: isSelected,
                              onTap: () {
                                Navigator.of(context).pop(cargo);
                              },
                              content: Text(
                                cargo.nameEn,
                                style: TextStyle(
                                  color: AppColor.blackText,
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
