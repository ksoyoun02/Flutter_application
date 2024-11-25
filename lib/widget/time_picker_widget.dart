import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final void Function(TimeOfDay? selectedTime) onTimeSelected;

  const TimePickerWidget({
    super.key,
    required this.onTimeSelected,
  });

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Text(
            _selectedTime != null
                ? _selectedTime!.format(context)
                : 'Select Time',
            style: const TextStyle(color: Colors.black87),
          ),
        ]),
        InkWell(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (pickedTime != null) {
              setState(() {
                _selectedTime = pickedTime;
              });
              widget.onTimeSelected(pickedTime);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [Icon(Icons.access_time)],
            ),
          ),
        ),
      ],
    );
  }
}
