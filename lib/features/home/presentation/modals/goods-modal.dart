import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_text_style.dart';
import '../views/home_view_controller.dart';
import '../views/home_view_state.dart';
import '../widgets/top_bottom_model.dart';

class SelectGoodsModal extends StatelessWidget {
  final HomeViewController cubit;
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
                      context.tt("Select type of goods", "اختر نوع البضائع"),
                      style: AppTextStyles.headingStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        final selectedGoods = cubit.state.selectGoods;
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
                child: BlocBuilder<HomeViewController, HomeViewState>(
                  builder: (context, state) {
                    if (state.homeModel!.goods.isEmpty) {
                      return const Center(child: Text('No goods available'));
                    } else {
                      return ListView.builder(
                        itemCount: state.homeModel!.goods.length,
                        itemBuilder: (context, index) {
                          final good = state.homeModel!.goods[index];
                          final isSelected = state.selectGoods == null
                              ? false
                              : state.selectGoods!.contains(good);
                        
                          return ClickBottomSheetItem2(
                            isSelected: isSelected,
                            onTap: () {
                              cubit.toggleGoodSelection(good);
                            },
                            content: Text(
                              good.nameEn,
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
                    }
                  },
                ),
              )
            ]));
  }
}

class ClickBottomSheetItem2 extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget content;

  const ClickBottomSheetItem2({
    super.key,
    this.isSelected = false,
    required this.onTap,
    required this.content,
  });

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
                color: isSelected ? Colors.green : AppColor.borderColor,
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
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  color: const Color(0xffA7A9B7),
                                  width: 5,
                                ),
                              ),
                            )),
                ]),
          ),
        ));
  }
}
