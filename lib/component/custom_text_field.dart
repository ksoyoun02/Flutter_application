import 'package:application/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        TextFormField(
          controller: widget.controller,
          cursorColor: Colors.grey,
          maxLines: widget.isTime || widget.oneLow ? 1 : 5,
          keyboardType:
              widget.isTime ? TextInputType.number : TextInputType.multiline,
          inputFormatters: widget.isTime
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(5),
                  TimeFormatter()
                ]
              : [],
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300],
            suffixText: widget.isTime ? '시' : null,
          ),
          enabled: !widget.isDisabled!,
          onEditingComplete: () {
            if (widget.isTime) {
              _formatTime();
            }
          },
        )
      ],
    );
  }

  // 포커스가 풀릴 때 시간 형식으로 수정하는 함수
  void _formatTime() {
    String text = widget.controller?.text ?? '';

    // 1자리 숫자일 경우 앞에 '0' 추가
    if (text.length == 1) {
      text = '0$text';
    }

    // 2자리 숫자만 입력되면 :을 추가하여 HH:MM 형식으로
    if (text.length == 2 && !text.contains(':')) {
      text = '${text.substring(0, 2)}:${text.substring(2)}';
    }

    // 3자리 숫자라면 두 번째 `:` 뒤에 0을 추가하여 HH:MM 형식으로 완성
    if (text.length == 3) {
      text = '${text}0';
    }

    // 형식에 맞게 텍스트 업데이트
    if (widget.controller != null) {
      widget.controller!.text = text;
      widget.controller!.selection =
          TextSelection.collapsed(offset: text.length);
    }
  }
}

class TimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 숫자만 허용
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
