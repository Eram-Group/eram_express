
import 'package:eram_express/features/home/presentation/widgets/top_bottom_model.dart';
import 'package:eram_express_shared/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gap/gap.dart';
import '../../../app/di.dart';
import '../../../core/app_colors.dart';
import '../../Common/presentation/widgets/customButton.dart';

class PickDateBottomSheet extends StatefulWidget {
  const PickDateBottomSheet({super.key});

  @override
  _PickDateBottomSheetState createState() => _PickDateBottomSheetState();
}

class _PickDateBottomSheetState extends State<PickDateBottomSheet> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
         
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopBottomModel(),
          const Text(
            "Pick up date",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          const Gap(10),
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
              defaultDecoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              weekendDecoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              disabledDecoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              outsideDecoration: const BoxDecoration(
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
              logger.debug("Selected date: $_selectedDay");
              mainNavigationService
                  .back(DateFormat('yyyy-MM-dd').format(_selectedDay));
            },
            TextColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ],
      ),
    );
  }
}
