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
  void initState() {
    super.initState();

    onDaySelected(selectedDate, selectedDate);
  }

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
            builder: (_) {
              return FractionallySizedBox(
                heightFactor: 0.7, // 화면 높이의 70%로 설정
                child: Container(
                  color: Colors.white,
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                    child: ScheduleBottomSheet(),
                  ),
                ),
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
              height: 5.0,
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'content',
                    ),
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'content',
                    ),
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'content',
                    ),
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'content',
                    ),
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'content',
                    ),
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'content',
                    ),
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'content',
                    ),
                    ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'content',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
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
