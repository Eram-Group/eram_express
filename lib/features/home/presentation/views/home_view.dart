import 'package:eram_express/core/app_colors.dart';
import 'package:eram_express_shared/core/i18n/context_extension.dart';
import 'package:eram_express_shared/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../app/di.dart';
import '../../../Common/presentation/widgets/SvgIcon.dart';
import '../../../Common/presentation/widgets/customButton.dart';

import 'ShippingFormCubit.dart';
import 'ShippingFormState.dart';

class HomeView extends StatelessWidget {
  static const String route = '/home';
  final ShippingFormCubit viewModel = ShippingFormCubit(
    homerepo: HomeRepository,
  );

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        _buildHeader(context),
        _builddataContainer(context),
      ],
    )));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
        width: Responsive.screenWidth,
        height: Responsive.screenHeight! * .3,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/homePic.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: Image.asset("assets/image/Image.jpg"),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ahmed Adel",
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      context.tt("Have a nice day !", 'يوم سعيد'),
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            )));
  }

  Widget _builddataContainer(BuildContext context) {
    return BlocBuilder<ShippingFormCubit, ShippingFormState>(
      bloc: viewModel,
      builder: (_, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 130)
              .copyWith(bottom: 0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1C000000), // Hex value for #0000001C
                    offset: Offset(0, 4), // Equivalent to "0px 4px"
                    blurRadius: 24, // Equivalent to "24px"
                    spreadRadius: 0, // Equivalent to "0px"
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.tt("Ship your goods with us", "اشحن بضائعك معنا"),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSelected(
                            onTap: () => viewModel.PickClicked(context),
                            selectedValue: state.pickup?.address ?? " ",
                            context: context,
                            label: state.pickup?.address ?? "Pick up",
                            iconName: 'Pick_Up',
                          ),
                        ),
                        const Gap(7),
                        Expanded(
                          child: _buildSelected(
                            onTap: () => viewModel.destinationClicked(context),
                            context: context,
                            selectedValue: state.destination?.address ?? " ",
                            label: state.destination?.address ?? "Destination",
                            iconName: 'destination',
                          ),
                        ),
                      ],
                    ),
                    _buildSelected(
                      onTap: () => viewModel.cargoCategoryOnClicked(context),
                      selectedValue: context.tt(state.loadType?.nameEn ?? " ",
                          state.loadType?.nameAr ?? " "),
                      context: context,
                      label: context.tt(
                          state.loadType?.nameEn ?? "Select the load type",
                          state.loadType?.nameAr ?? "اختر نوع الحمولة"),
                      iconName: 'arrow-down',
                    ),
                    _buildSelected(
                      onTap: () => viewModel.cargosubCategoryOnClicked(context),
                      context: context,
                      selectedValue: context.tt(state.truckSize?.nameEn ?? " ",
                          state.truckSize?.nameAr ?? " "),
                      label: context.tt(
                          state.truckSize?.nameEn ??
                              "Choose the size of the truck ",
                          state.truckSize?.nameAr ?? "اختر حجم حمولتك "),
                      iconName: 'sizeTrack',
                    ),
                    _buildSelected(
                      onTap: () => viewModel.PickdateOnClicked(context),
                      context: context,
                      selectedValue: context.tt(
                        state.pickupDate ?? " ",
                        state.pickupDate ?? " ",
                      ),
                      label: context.tt(
                        state.pickupDate ?? "pick up date",
                        state.pickupDate ?? "اختر التاريخ",
                      ),
                      iconName: 'calendar',
                    ),
                    _buildSelected(
                      onTap: () => viewModel.GoodsOnClicked(context),
                      context: context,
                      selectedValue: context.tt(
                        state.selectgoodsString ?? " ",
                        state.selectgoodsString ?? " ",
                      ),
                      label: context.tt(
                        state.selectgoodsString ?? "Select Goods",
                        state.selectgoodsString ?? "اختر نوع البضائع",
                      ),
                      iconName: 'calendar',
                    ),
                    const Gap(8),
                    CustomButton(
                      onPressed: () {
                        print(state.truckSize?.nameAr);
                      },
                      text: "Check Rates",
                      backgroundColor: AppColor.primaryColor,
                      TextColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelected({
    required Future<void> Function() onTap,
    required BuildContext context,
    required String label,
    required String iconName,
    required String? selectedValue,
  }) {
    Color textColor = selectedValue != null && selectedValue != " "
        ? Colors.black
        : AppColor.ligthText;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
          onTap: () async {
            await onTap();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColor.bordercolor,
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 25.2 / 20,
                      ),
                    ),
                  ),
                  SvgIcon(
                    asset: iconName,
                    size: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
