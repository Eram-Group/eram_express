import 'package:eram_express/core/AppColors.dart';
import 'package:eram_express/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Common/presentation/utils/show_modal.dart';
import '../../../Common/presentation/widgets/SvgIcon.dart';
import '../../../Common/presentation/widgets/customButton.dart';
import '../../data/models/sizetrackModel.dart';

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

Widget _buildSelected(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: GestureDetector(
        onTap: () {
          showModalView(
            isScrollControlled: true,
            context: context,
            builder: (context) => _buildPickDateBottomSheet(),
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

Widget _buildSizetruckbottom() {
  List<SizeTrackModel> dummySizeTrackList = [
    SizeTrackModel(
      image: 'Cargo',
      sizeTruck: 'Large',
    ),
    SizeTrackModel(
      image: 'Cargo',
      sizeTruck: 'Medium',
    ),
    SizeTrackModel(
      image: 'Cargo',
      sizeTruck: 'Small',
    ),
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Choose the size of the truck",
        style: TextStyle(
          color: Color(0xff191D31),
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 23.4 / 20,
        ),
      ),
      const Gap(12),
      ...dummySizeTrackList.map((sizeTrack) {
        return clickbottomshteetItem(
          sizetrack: sizeTrack,
        );
      }).toList(),
    ],
  );
}

class clickbottomshteetItem extends StatelessWidget {
  final bool isSelected;
  final SizeTrackModel sizetrack;
  const clickbottomshteetItem({
    Key? key,
    this.isSelected = false,
    required this.sizetrack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: isSelected ? Colors.green : AppColor.bordercolor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffF2F4F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: SvgIcon(asset: sizetrack.image),
                    ),
                  ),
                  const Gap(8),
                  Text(
                    sizetrack.sizeTruck,
                    style: TextStyle(
                      color: AppColor.blacktext,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 18.2 / 20,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

Widget _buildPickDateBottomSheet() {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Container(
          width: 60,
          height: 5,
          decoration: BoxDecoration(
              color: Color(0xffDFE2EB), borderRadius: BorderRadius.circular(2)),
        )),
        Text(
          "Pick up date",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },

        
          enabledDayPredicate: (day) {
            return day.isAfter(DateTime.now().subtract(Duration(days: 1)));
          },
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: AppColor.blacktext,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            weekendStyle: TextStyle(
              color: AppColor.blacktext,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.secondaryColor,
              shape: BoxShape.rectangle,
            ),
            weekendTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Gap(6),
        CustomButton(
          text: "Select date",
          onPressed: () {
            print("yalhwwwwwwwwwwy");
          },
          TextColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        )
      ],
    ),
  );
}
