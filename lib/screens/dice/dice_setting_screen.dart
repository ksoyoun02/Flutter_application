import 'package:application/const/colors.dart';
import 'package:flutter/material.dart';

class DiceSettingScreen extends StatelessWidget {
  final double threshold;
  final ValueChanged<double> onThresholdChange;

  const DiceSettingScreen({
    super.key,
    required this.threshold,
    required this.onThresholdChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Text(
                '민감도',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        Slider(
          min: 0.1,
          max: 10.0,
          divisions: 101,
          label: threshold.toStringAsFixed(1),
          value: threshold,
          onChanged: onThresholdChange,
        )
      ],
    );
  }
}
