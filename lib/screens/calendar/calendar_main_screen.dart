import 'dart:convert';

import 'package:application/models/calendar_model.dart';
import 'package:application/widget/date_picker_widget.dart';
import 'package:application/widget/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

/*
class CalendarMainScreen extends StatefulWidget {
  const CalendarMainScreen({super.key});

  @override
  State<CalendarMainScreen> createState() => _CalendarMainScreenState();
}
class _CalendarMainScreenState extends State<CalendarMainScreen> {
  final CalendarModel _calendarEvent = CalendarModel();
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  final _addSelectDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<DateTime, List<CalendarModel>> _events = {};
  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  // 서버에서 이벤트 데이터를 가져오는 함수
  Future<void> _fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(
          'http://125.133.70.52:8080/calendar/findScheduleList')); // local test시 10.0.2.2:port로 해야 찾아갈수있음.

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // 서버에서 받은 데이터를 Map 형식으로 변환
        Map<DateTime, List<CalendarModel>> events = {};

        for (var item in data) {
          CalendarModel event =
              CalendarModel.fromJson(item); // fromJson 사용하여 객체 생성
          DateTime date = event.eventDate!; // 이벤트 날짜로 설정
          List<CalendarModel> eventList = events[date] ?? [];
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

  List<CalendarModel> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Widget _buildInputField(Function(String) onChanged, {String? initialValue}) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
      ),
    );
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
          centerTitle: true,
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
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      size: 30,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 1, // 기본 높이 (50%)
                            minChildSize: 0.3, // 최소 높이
                            maxChildSize: 1, // 최대 높이
                            builder: (context, scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  children: [
                                    Container(
                                      color: const Color(0xFF6F6EE4),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Text(
                                              "일정",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.save_alt,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text("일정"),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: _buildInputField(
                                                    (value) {
                                                  _calendarEvent.title = value;
                                                },
                                                    initialValue:
                                                        _calendarEvent.title),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("일자"),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    // TextField 위젯
                                                    Expanded(
                                                      // TextField가 가변적으로 크기를 차지하도록 Expanded 사용
                                                      child: TextFormField(
                                                        enabled: false,
                                                        initialValue:
                                                            formatDate(
                                                                _focusedDay),
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                        ),
                                                      ),
                                                    ),
                                                    // DatePickerWidget 위젯
                                                    DatePickerWidget(
                                                      initDate: _focusedDay,
                                                      onDateSelected:
                                                          (selectedDate) {
                                                        setState(() {
                                                          _calendarEvent
                                                                  .eventDate =
                                                              selectedDate; // 날짜 선택 후 _calendarEvent의 eventDate 업데이트
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("시간"),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    TimePickerWidget(
                                                      onTimeSelected:
                                                          (selectedTime) {
                                                        _calendarEvent
                                                                .startTime =
                                                            selectedTime
                                                                ?.format(
                                                                    context);
                                                      },
                                                    ),
                                                    TimePickerWidget(
                                                      onTimeSelected:
                                                          (selectedTime) {
                                                        _calendarEvent.endTime =
                                                            selectedTime
                                                                ?.format(
                                                                    context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("장소"),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: _buildInputField(
                                                    (value) {
                                                  _calendarEvent.location =
                                                      value;
                                                },
                                                    initialValue: _calendarEvent
                                                        .location),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text("내용"),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: _buildInputField(
                                                    (value) {
                                                  _calendarEvent.description =
                                                      value;
                                                },
                                                    initialValue: _calendarEvent
                                                        .description),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
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
                                title: Text(event.title!),
                                subtitle: Text(
                                    '${event.startTime!.substring(0, 5)} - ${event.endTime!.substring(0, 5)}'),
                                onTap: () {
                                  // 상세 페이지로 이동하거나 다른 동작을 추가할 수 있습니다.
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(event.title!),
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
*/