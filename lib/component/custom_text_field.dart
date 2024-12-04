import 'package:application/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final bool oneLow;

  const CustomTextField({
    super.key,
    required this.label,
    required this.isTime,
    this.oneLow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(
          cursorColor: Colors.grey,
          maxLines: isTime || oneLow ? 1 : null,
          keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
          inputFormatters:
              isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300],
            suffixText: isTime ? '시' : null,
          ),
        ),
      ],
    );
  }
}
