import 'package:application/widget/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Application",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
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
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 15.0,
                      bottom: 0.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            MenuWidget(
                                cardTitle: "Blog",
                                iconData: Icons.web_rounded,
                                linkPage: "blog"),
                            MenuWidget(
                                cardTitle: "Scheduler",
                                iconData: Icons.calendar_month_outlined,
                                linkPage: "calendarScheduler"),
                          ],
                        ),
                        Row(
                          children: [
                            MenuWidget(
                                cardTitle: "D-day",
                                iconData: Icons.favorite_border,
                                linkPage: "dday"),
                            MenuWidget(
                                cardTitle: "Timer",
                                iconData: Icons.timer_sharp,
                                linkPage: "timer"),
                          ],
                        ),
                        Row(
                          children: [
                            MenuWidget(
                                cardTitle: "Map Check",
                                iconData: Icons.gps_fixed_outlined,
                                linkPage: "choolCheck"),
                            MenuWidget(
                                cardTitle: "Video",
                                iconData: Icons.videocam,
                                linkPage: "video"),
                          ],
                        ),
                        Row(
                          children: [
                            MenuWidget(
                                cardTitle: "Image Editor",
                                iconData: Icons.switch_account,
                                linkPage: "imageEditor"),
                            MenuWidget(
                                cardTitle: "Youtube",
                                iconData: Icons.ondemand_video,
                                linkPage: "youtube"),
                          ],
                        ),
                        Row(
                          children: [
                            MenuWidget(
                                cardTitle: "Img",
                                iconData: Icons.image_outlined,
                                linkPage: "img"),
                            MenuWidget(
                                cardTitle: "Dice",
                                icon: Icon(
                                  FontAwesomeIcons.dice,
                                  size: 60,
                                  color: Color.fromARGB(255, 107, 105, 228),
                                ),
                                linkPage: "dice"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
