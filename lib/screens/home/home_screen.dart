import 'package:application/screens/timer/timer_main_screen.dart';
import 'package:application/widget/menu_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Application",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF6F6EE4),
        ),
        body: Column(
          children: [
            Container(
              color: const Color(0xFF6F6EE4),
              height: 260,
              child: const Row(
                children: [
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(18.0),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "user123",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6F6EE4),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 15.0,
                      bottom: 0.0,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            MenuWidget(
                                cardTitle: "Timer",
                                icon: Icons.timer_sharp,
                                linkPage: "timer"),
                            MenuWidget(
                                cardTitle: "Calendar",
                                icon: Icons.calendar_month_outlined,
                                linkPage: "Calendar"),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Card(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.white,
                                child: Container(
                                  height: 180,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.white,
                                child: Container(
                                  height: 180,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
