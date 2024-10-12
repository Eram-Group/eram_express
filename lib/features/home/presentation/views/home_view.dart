import 'package:eram_express/core/AppColors.dart';
import 'package:eram_express/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Common/presentation/utils/show_modal.dart';
import '../../../Common/presentation/widgets/SvgIcon.dart';
import '../../../Common/presentation/widgets/customButton.dart';
import '../../data/models/cargo-categoriesModel.dart';
import '../../data/models/cargo-subcategoryModel.dart';
import '../../modals/cargo_categories-modal.dart';
import '../../modals/pick_data-modal.dart';

class HomeView extends StatelessWidget {
  static const String route = '/home';
  const HomeView({super.key});

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
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: _buildSelected(context),
                ),
                const Gap(7),
                Expanded(
                  child: _buildSelected(context),
                )
              ],
            ),
            _buildSelected(context),
            _buildSelected(context),
            _buildSelected(context),
            const Gap(8),
            CustomButton(
              onPressed: () {},
              text: "Check Rates",
              backgroundColor: AppColor.primaryColor,
              TextColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildSelected(
  BuildContext context,
  /*void Function()? ontap */
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: GestureDetector(
        onTap: () {
          showModalView(
            isScrollControlled: false,
            context: context,
            builder: (context) => SelectCargoCategoryModal(),
            //PickDateBottomSheet(),   //ونخلي دي بترو لحد ما اكيد هيبق ي في حل تاني
          );
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
                  "Select ",
                  style: TextStyle(
                    color: AppColor.ligthText,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 25.2 / 20,
                  ),
                ),
                const SvgIcon(
                  asset: 'arrow-down',
                  size: 20,
                ),
              ],
            ),
          ),
        )),
  );
}
