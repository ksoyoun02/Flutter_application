import 'package:application/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool isTime;
  final bool oneLow;
  final DateTime? eventDate;
  final bool? isDisabled;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.isTime,
    this.oneLow = false,
    this.eventDate,
    this.isDisabled = false,
    required this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!widget.isTime)
          TextFormField(
            controller: widget.controller,
            cursorColor: Colors.grey,
            maxLines: widget.oneLow ? 1 : 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[300],
            ),
            enabled: widget.isDisabled != true,
          ),
        if (widget.isTime)
          TextFormField(
            controller: widget.controller,
            cursorColor: Colors.grey,
            maxLines: 1,
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                // 시간 형식을 HH:mm으로 변환
                String formattedTime =
                    '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                widget.controller?.text = formattedTime;
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[300],
            ),
            enabled: widget.isDisabled != true,
          ),
      ],
    );
  }
}
