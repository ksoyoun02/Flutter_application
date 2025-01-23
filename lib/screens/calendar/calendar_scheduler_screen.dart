import 'package:application/component/main_calender.dart';
import 'package:application/component/schedule_bottom_sheet.dart';
import 'package:application/component/schedule_card.dart';
import 'package:application/component/today_banner.dart';
import 'package:application/const/colors.dart';
import 'package:application/models/calendar_model.dart';
import 'package:application/service/calendar_service.dart';
import 'package:flutter/material.dart';

class CalendarSchedulerScreen extends StatefulWidget {
  const CalendarSchedulerScreen({super.key});

  @override
  State<CalendarSchedulerScreen> createState() =>
      _CalendarSchedulerScreenState();
}

class _CalendarSchedulerScreenState extends State<CalendarSchedulerScreen> {
  final service = ScheduleService();
  Future<List<CalendarModel>>? _schedulesFuture;
  int count = 0;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    _loadSchedules(selectedDate);
  }

  void _loadSchedules(DateTime selectedDate) async {
    _schedulesFuture = service.getSchedules(selectedDate);

    _schedulesFuture!.then((fetchedSchedules) {
      setState(() {
        count = fetchedSchedules.length;
      });
    }).catchError((e) {
      print('Error loading schedules: $e');
    });
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('알림'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 8, bottom: 8),
                    child: ScheduleBottomSheet(
                        eventDate: selectedDate,
                        onSaved: () => _loadSchedules(selectedDate)),
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
            TodayBanner(selectedDate: selectedDate, count: count),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: FutureBuilder<List<CalendarModel>>(
                future: _schedulesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No schedules available.'),
                    );
                  } else {
                    final schedules = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        children: schedules.map((schedule) {
                          return Dismissible(
                            key: Key(schedule.id.toString()), // 고유 키 설정
                            direction:
                                DismissDirection.endToStart, // 왼쪽으로 밀기만 허용
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) async {
                              deleteSchdule(schedule.id!);
                            },
                            child: ScheduleCard(
                              startTime: schedule.startTime!,
                              endTime: schedule.endTime!,
                              title: schedule.title!,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
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

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDate = selectedDay;
    });
    _loadSchedules(selectedDate);
  }

  void deleteSchdule(int id) async {
    CalendarModel scheduleData = CalendarModel(id: id);

    var result = await service.deleteSchedules(scheduleData);

    if (result['status'] == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('일정이 삭제되었습니다.'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2), // 메시지 표시 시간
        ),
      );

      _loadSchedules(selectedDate);
    } else {
      _showAlertDialog(result['message']);
    }
  }
}
