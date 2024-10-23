import 'package:eram_express/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_text_style.dart';
import '../../Common/presentation/widgets/clickablebottomSheetItem.dart';
import '../presentation/views/ShippingFormCubit.dart';
import '../presentation/views/ShippingFormState.dart';
import '../presentation/widgets/top_bottom_model.dart';

class SelectGoodsModal extends StatelessWidget {
  final ShippingFormCubit cubit;
  const SelectGoodsModal({
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select type of goods",
                    style: AppTextStyles.headingStyle,
                  ),
                  TextButton(
                    onPressed: () 
                    {
                      final selectedGoods = cubit.state.selectgoods;
                      Navigator.of(context).pop(selectedGoods);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            Expanded(
              child: BlocBuilder<ShippingFormCubit, ShippingFormState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.goods == null) {
                    return const Center(child: Text('No goods available'));
                  } else {
                    return SingleChildScrollView(
                        child: Column(
                      children: state.goods!.map((good) {
                        return BlocSelector<ShippingFormCubit,
                            ShippingFormState, bool>(
                          selector: (state) {
                            final selectedGoods = state.selectgoods ?? [];
                            return selectedGoods.contains(good);
                          },
                          builder: (context, isSelected) {
                            return ClickBottomSheetItem2(
                              isSelected: isSelected,
                              onTap: () {
                                cubit.toggleGoodSelection(good);
                              },
                              content: Text(
                                good.nameEn,
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

class ClickBottomSheetItem2 extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget content;

  const ClickBottomSheetItem2({
    Key? key,
    this.isSelected = false,
    required this.onTap,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ).copyWith(bottom: 0),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: isSelected ? Colors.green : AppColor.bordercolor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  content,
                  InkWell(
                      onTap: onTap,
                      child: isSelected
                          ? Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.white, // Color of the inner hole
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xffA7A9B7),
                                  width: 5,
                                ),
                              ),
                            )),
                ]),
          ),
        ));
  }
}
