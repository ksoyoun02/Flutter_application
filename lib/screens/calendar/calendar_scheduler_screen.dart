import 'package:application/component/main_calender.dart';
import 'package:application/component/schedule_bottom_sheet.dart';
import 'package:application/component/schedule_card.dart';
import 'package:application/component/today_banner.dart';
import 'package:application/const/colors.dart';
import 'package:flutter/material.dart';

class CalendarSchedulerScreen extends StatefulWidget {
  const CalendarSchedulerScreen({super.key});

  @override
  State<CalendarSchedulerScreen> createState() =>
      _CalendarSchedulerScreenState();
}

class _CalendarSchedulerScreenState extends State<CalendarSchedulerScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            builder: (context) {
              return const FractionallySizedBox(
                heightFactor: 0.7, // 화면 높이의 80%
                child: ScheduleBottomSheet(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalender(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            const SizedBox(
              height: 8.0,
            ),
            TodayBanner(selectedDate: selectedDate, count: 0),
            const SizedBox(
              height: 8.0,
            ),
            const ScheduleCard(
              startTime: 12,
              endTime: 14,
              content: 'content',
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime forcusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
