import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DDayScreen extends StatefulWidget {
  const DDayScreen({super.key});

  @override
  State<DDayScreen> createState() => _DDayScreenState();
}

class _DDayScreenState extends State<DDayScreen> {
  DateTime firstDay = DateTime.now();

  void onHeartPressed() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  firstDay = date;
                });
              },
              mode: CupertinoDatePickerMode.date,
            ),
          ),
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
}

class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  const _DDay({
    required this.onHeartPressed,
    required this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        const Text(
          "U&I",
          style: TextStyle(
            color: Colors.white,
            fontSize: 80.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'parisienne',
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        const Text(
          "우리 처음 만난 날",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontFamily: 'sunflower'),
        ),
        Text(
          "${firstDay.year}.${firstDay.month}.${firstDay.day}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed,
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          "D+${DateTime(now.year, now.month, now.day).difference(firstDay).inDays + 1}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          'asset/img/middle_image.png',
          height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}
