import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected; // 날짜 선택 후 콜백을 받기 위한 함수
  final DateTime? initDate;

  const DatePickerWidget({
    super.key,
    required this.onDateSelected,
    this.initDate,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.initDate ?? DateTime.now(), // 기본 날짜
      firstDate: DateTime(2000), // 선택 가능한 첫 날짜
      lastDate: DateTime(2100), // 선택 가능한 마지막 날짜
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate; // 선택된 날짜 상태 업데이트
      });
      widget.onDateSelected(_selectedDate!); // 날짜 선택 후 콜백 호출
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /*
          Text(
            _selectedDate != null
                ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
                : 'Select Date', // 날짜가 없으면 기본 메시지 표시
            style: const TextStyle(fontSize: 16),
          ),
         */
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today),
              ],
            ),
          ),
        )
      ],
    );
  }
}
