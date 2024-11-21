import 'dart:convert';

import 'package:application/models/calender_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

class CalendarMainScreen extends StatefulWidget {
  const CalendarMainScreen({super.key});

  @override
  State<CalendarMainScreen> createState() => _CalendarMainScreenState();
}

class _CalendarMainScreenState extends State<CalendarMainScreen> {
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<DateTime, List<CalenderModel>> _events = {};
  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  // 서버에서 이벤트 데이터를 가져오는 함수
  Future<void> _fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8080/calender/findScheduleList')); // local test시 10.0.2.2:port로 해야 찾아갈수있음.

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // 서버에서 받은 데이터를 Map 형식으로 변환
        Map<DateTime, List<CalenderModel>> events = {};

        for (var item in data) {
          CalenderModel event =
              CalenderModel.fromJson(item); // fromJson 사용하여 객체 생성
          DateTime date = event.eventDate; // 이벤트 날짜로 설정
          List<CalenderModel> eventList = events[date] ?? [];
          eventList.add(event);
          events[date] = eventList;
        }

        setState(() {
          _events = events; // 가져온 데이터를 상태로 설정
        });
      } else {
        throw Exception('Failed to load events');
      }
    } catch (error) {
      print('Error fetching events: $error');
    }
  }

  List<CalenderModel> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calendar Screen',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xFF6F6EE4),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                locale: 'ko-KR',
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(
                    () {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    },
                  );
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(
                    () {
                      _calendarFormat = format;
                    },
                  );
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                eventLoader: _getEventsForDay,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      size: 30,
                    ),
                  ),
                ],
              ),
              // 선택된 날짜의 이벤트 리스트
              Expanded(
                child: _getEventsForDay(_selectedDay).isEmpty
                    ? const Center(child: Text('No events for selected day'))
                    : ListView(
                        children: _getEventsForDay(_selectedDay)
                            .map(
                              (event) => ListTile(
                                title: Text(event.title),
                                subtitle: Text(
                                    '${event.startTime.substring(0, 5)} - ${event.endTime.substring(0, 5)}'),
                                onTap: () {
                                  // 상세 페이지로 이동하거나 다른 동작을 추가할 수 있습니다.
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(event.title),
                                      content: Text(
                                          'Description: ${event.description}'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
