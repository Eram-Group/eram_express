import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_text_style.dart';
import '../../../Common/presentation/widgets/clickablebottomSheetItem.dart';
import '../views/home_view_controller.dart';
import '../views/home_view_state.dart';
import '../widgets/top_bottom_model.dart';

class SelectSubCargoCategoryModal extends StatelessWidget {
  final HomeViewController cubit;
  const SelectSubCargoCategoryModal({
    super.key,
    required this.cubit,
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
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 16),
                child: Text( context.tt("Select the load type", "اختر نوع الحمولة"),
                  style: AppTextStyles.headingStyle,
                ),
              ),
              const Gap(12),
              Expanded(
                child: BlocBuilder<HomeViewController, HomeViewState>(
                  builder: (context, state) {
                     if (state.cargoSubCategories == null)
                      {
                      return const Center(
                          child: Text('No categories available'));
                    }
                     else
                      {
                      return SingleChildScrollView(
                          child: Column(
                        children: state.cargoSubCategories!.map((cargo) {
                          return BlocSelector<HomeViewController, HomeViewState,bool>(
                            selector: (state) => state.truckSize == null? false: state.truckSize!.id == cargo.id,
                            builder: (context, isSelected) {
                              return ClickBottomSheetItem(
                                  imageUrl: cargo.image,
                                  isSelected: isSelected,
                                  onTap: () {
                                    Navigator.of(context).pop(cargo);
                                  },
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cargo.nameEn,
                                        style: TextStyle(
                                          color: AppColor.blackText,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 18.2 / 20,
                                        ),
                                      ),
                                      Text(
                                        cargo.capacity.toString(),
                                        style: TextStyle(
                                          color: AppColor.lightText,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          height: 15.2 / 14,
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        }).toList(),
                      ));
                    }
                  },
                ),
              ),
            ]));
  }
}
