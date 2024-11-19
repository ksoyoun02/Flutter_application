import 'package:application/screens/timer/timer_screen.dart';
import 'package:flutter/material.dart';

class TimerMainScreen extends StatefulWidget {
  const TimerMainScreen({super.key});

  @override
  State<TimerMainScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TimerMainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Timer Screen',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.hourglass_bottom_rounded),
              ),
              Tab(
                icon: Icon(Icons.timer_sharp),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: TimerScreen(),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
