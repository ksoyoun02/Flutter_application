import 'package:application/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool isTime;
  final bool oneLow;
  final DateTime? eventDate;
  final bool? isDisabled;

  const CustomTextField({
    super.key,
    required this.label,
    required this.isTime,
    this.oneLow = false,
    this.eventDate,
    this.isDisabled = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();

    // eventDate가 있을 경우, 해당 날짜를 텍스트 필드에 세팅
    if (widget.eventDate != null) {
      _controller.text = widget.eventDate!
          .toLocal()
          .toString()
          .split(' ')[0]; // DateTime을 String으로 변환후 날짜만 자름
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // 메모리 해제
    super.dispose();
  }

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
        TextFormField(
          controller: _controller,
          cursorColor: Colors.grey,
          maxLines: widget.isTime || widget.oneLow ? 1 : 5,
          keyboardType:
              widget.isTime ? TextInputType.number : TextInputType.multiline,
          inputFormatters:
              widget.isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300],
            suffixText: widget.isTime ? '시' : null,
          ),
          enabled: !widget.isDisabled!,
        )
      ],
    );
  }
}
