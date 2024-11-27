import 'package:application/const/colors.dart';
import 'package:flutter/material.dart';

class DiceScreen extends StatelessWidget {
  final int number;

  const DiceScreen({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset("asset/img/dice_$number.png"),
        ),
        const SizedBox(
          height: 32.0,
        ),
        Text(
          '행운의 숫자',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          number.toString(),
          style: TextStyle(
            color: secondaryColor,
            fontSize: 60.0,
            fontWeight: FontWeight.w200,
          ),
        )
      ],
    );
  }
}
