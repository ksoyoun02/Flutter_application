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
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && widget.isTime) {
      _formatTime();
    }
  }

  void _formatTime() {
    String text = widget.controller?.text.replaceAll(':', '') ?? '';

    if (text.isEmpty) {
      text = '0000';
    } else {
      text = text.padLeft(4, '0');
    }

    text = '${text.substring(0, 2)}:${text.substring(2)}';

    if (!isValidTimeFormat(text)) {
      _showAlertDialog('잘못된 시간 형식입니다. 다시 입력해주세요');
      widget.controller?.clear();
    } else {
      widget.controller?.text = text;
      widget.controller?.selection =
          TextSelection.collapsed(offset: text.length);
    }
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
          controller: widget.controller,
          focusNode: _focusNode,
          cursorColor: Colors.grey,
          maxLines: widget.isTime || widget.oneLow ? 1 : 5,
          keyboardType:
              widget.isTime ? TextInputType.number : TextInputType.multiline,
          inputFormatters: widget.isTime
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                  TimeFormatter(),
                ]
              : [],
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

class TimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // 최대 5자리까지만 허용 (HH:MM)
    if (newText.length > 5) {
      newText = newText.substring(0, 5);
    }

    // HH:MM 형식으로 변환
    if (newText.length > 2) {
      newText = '${newText.substring(0, 2)}:${newText.substring(2)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

bool isValidTimeFormat(String time) {
  try {
    final format = DateFormat("HH:mm");
    format.parseStrict(time); // 엄격한 파싱
    return true;
  } catch (e) {
    return false;
  }
}
