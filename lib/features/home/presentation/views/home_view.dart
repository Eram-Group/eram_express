import 'package:eram_express/core/app_colors.dart';
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
        _buildHeader(),
        _builddataContainer(context),
      ],
    )));
  }

  Widget _buildHeader() {
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                const Column(
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
                      "Have a nice day !",
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 130)
              .copyWith(bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Ship your goods with us",
                    style: TextStyle(
                      //fontFamily: 'Outfit',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16), // استبدال Gap بـ SizedBox
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelected(
                          onTap: () => viewModel.cargosubCategoryOnClicked(
                              context), // هيبقي بدالها جوجل ماب
                          context: context,
                          label: state.truckSize?.nameAr ?? "Pick up",
                          iconName: 'Pick_Up',
                        ),
                      ),
                      const Gap(7),
                      Expanded(
                        child: _buildSelected(
                          onTap: () => viewModel.cargosubCategoryOnClicked(
                              context), // هيبقي بدالها جوجل ماب
                          context: context,
                          label: state.truckSize?.nameAr ?? "Destination",
                          iconName: 'destination',
                        ),
                      ),
                    ],
                  ),

                  _buildSelected(
                    onTap: () => viewModel.cargoCategoryOnClicked(context),
                    context: context,
                    label: state.loadType?.nameEn ?? "Select the load type",
                    iconName: 'arrow-down',
                  ),

                  _buildSelected(
                    onTap: () => viewModel.cargosubCategoryOnClicked(context),
                    context: context,
                    label: state.truckSize?.nameEn ??
                        "Choose the size of the truck",
                    iconName: 'sizeTrack',
                  ),
                  _buildSelected(
                    onTap: () => viewModel.PickdateOnClicked(context),
                    context: context,
                    label: state.pickupDate ?? "pick up date",
                    iconName: 'calendar',
                  ),
                  
                  _buildSelected(
                    onTap: () => viewModel.GoodsOnClicked(context),
                    context: context,
                    label: state.selectgoods?[0].nameAr ?? "Select Goods",
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
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ],
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
  }) {
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
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColor
                          .ligthText, //افتكري غيري اللون  لو كان خلاص اختار
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 25.2 / 20,
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
