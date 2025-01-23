import 'package:application/const/colors.dart';
import 'package:application/service/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalender extends StatefulWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalender({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  State<MainCalender> createState() => _MainCalenderState();
}

class _MainCalenderState extends State<MainCalender> {
  final service = ScheduleService();
  Set<DateTime> _highlightedDates = {};
  late DateTime _selectedDate; // selectedDate를 상태 변수로 선언

  Future<void> _loadMonthlySchedules(DateTime date) async {
    final scheduleStrings =
        await service.getMonthlySchedules(date.year, date.month);
    // String 데이터를 DateTime으로 변환하여 저장
    setState(() {
      _highlightedDates = scheduleStrings
          .map((dateString) => DateTime.parse(dateString))
          .toSet();
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate; // 초기 selectedDate 설정
    _loadMonthlySchedules(_selectedDate); // 초기 데이터를 로드
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_kr',
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay; // 선택된 날짜 업데이트
        });
        widget.onDaySelected(selectedDay, focusedDay); // 외부 콜백 함수 호출
      },
      selectedDayPredicate: (date) =>
          date.year == _selectedDate.year &&
          date.month == _selectedDate.month &&
          date.day == _selectedDate.day,
      firstDay: DateTime(1800, 1, 1),
      lastDay: DateTime(3000, 1, 1),
      focusedDay: _selectedDate, // 상태 변수로 사용
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: BoxDecoration(
          color: LIGHT_GREY_COLOR,
          shape: BoxShape.circle, // 이 부분에서 shape를 원으로 지정
        ),
        weekendDecoration: BoxDecoration(
          color: LIGHT_GREY_COLOR,
          shape: BoxShape.circle, // shape를 원으로 지정
        ),
        selectedDecoration: BoxDecoration(
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1.0,
          ),
          shape: BoxShape.circle, // 선택된 날짜의 경우도 원 모양
        ),
        defaultTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        weekendTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        selectedTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: PRIMARY_COLOR,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12.0, // 글꼴 크기 조정
        ),
        weekendStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12.0, // 글꼴 크기 조정
          color: Colors.red, // 주말 색상 설정
        ),
      ),
      onPageChanged: (newFocusedDay) {
        DateTime today = DateTime.now();
        setState(() {
          if (today.year == newFocusedDay.year &&
              today.month == newFocusedDay.month) {
            _selectedDate = today;
          } else {
            _selectedDate = newFocusedDay; // 상태 변수로 selectedDate 변경
          }
        });
        _loadMonthlySchedules(_selectedDate);
        widget.onDaySelected(_selectedDate, _selectedDate);
      },
      calendarBuilders: CalendarBuilders(
        // 커스텀 빌더 추가
        defaultBuilder: (context, date, focusedDay) {
          final isHighlighted = _highlightedDates.contains(DateTime(
            date.year,
            date.month,
            date.day,
          ));
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isHighlighted
                  ? const Color.fromARGB(255, 136, 201, 255)
                  : LIGHT_GREY_COLOR,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: isHighlighted ? Colors.white : DARK_GREY_COLOR,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}
