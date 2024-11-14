import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/presentation/views/modals/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_text_style.dart';

import '../../Common/presentation/widgets/clickablebottomSheetItem.dart';
import '../../Common/presentation/widgets/empty_state_widget.dart';
import '../presentation/views/home_view_controller.dart';
import '../presentation/views/home_view_state.dart';
import '../presentation/widgets/top_bottom_model.dart';

class SelectSubCargoCategoryModal extends StatelessWidget {
  final HomeViewController cubit;
  const SelectSubCargoCategoryModal({
    Key? key,
    required this.cubit,
  }) : super(key: key);
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  context.tt("Select the load type","اختر نوع الحمولة"),
                  style: AppTextStyles.headingStyle,
                ),
              ),
              const Gap(12),
              Expanded(
                child: BlocBuilder<HomeViewController, HomeViewState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return EmptyLoadingWidget();
                    } else if (state.cargoSubCategories == null) {
                      return const Center(
                          child: Text('No categories available'));
                    } else {
                      return SingleChildScrollView(
                          child: Column(
                        children: state.cargoSubCategories!.map((cargo) {
                          return BlocSelector<HomeViewController,
                              HomeViewState, bool>(
                            selector: (state) => state.truckSize == cargo,
                            builder: (context, isSelected) {
                              return ClickBottomSheetItem(
                                  imageUrl: cargo.imageUrl,
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
                                          color: AppColor.blacktext,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 18.2 / 20,
                                        ),
                                      ),
                                      Text(
                                        cargo.capacity.toString(),
                                        style: TextStyle(
                                          color: AppColor.ligthText,
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
