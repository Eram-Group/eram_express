import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../core/AppColors.dart';
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
            const Text(
              "Select type of goods",
              style: TextStyle(
                color: Color(0xff191D31),
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 23.4 / 20,
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
                          selector: (state) => state.selectgood == good,
                          builder: (context, isSelected) {
                            return ClickBottomSheetItem(
                              imageUrl: good.image,
                              isSelected: isSelected,
                              onTap: () {
                                //cubit.setTruckSize(cargo);
                                Navigator.of(context).pop(good);
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
