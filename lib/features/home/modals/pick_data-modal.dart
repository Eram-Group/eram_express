import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gap/gap.dart';

import '../../../core/AppColors.dart';
import '../../../core/navigation_service.dart';
import '../../Common/presentation/widgets/customButton.dart'; // Assuming you use the gap package

class PickDateBottomSheet extends StatefulWidget {
  const PickDateBottomSheet({super.key});

  @override
  _PickDateBottomSheetState createState() => _PickDateBottomSheetState();
}

class _PickDateBottomSheetState extends State<PickDateBottomSheet> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  //final NavigationService navigationService = getIt<NavigationService>();

  @override
  Widget build(BuildContext context) {
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
                color: Color(0xffDFE2EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Pick up date",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          const SizedBox(height: 10),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            enabledDayPredicate: (day) {
              return day.isAfter(
                DateTime.now().subtract(const Duration(days: 1)),
              );
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
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              disabledDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              outsideDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              todayDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
              ),
              selectedDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.secondaryColor,
                shape: BoxShape.rectangle,
              ),
              weekendTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            headerStyle: const HeaderStyle(
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
              print("Selected date: $_selectedDay");
              Navigator.pop(context);
            },
            TextColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ],
      ),
    );
  }
}
