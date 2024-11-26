import 'package:application/screens/blog/blog_screen.dart';
import 'package:application/screens/calendar/calendar_main_screen.dart';
import 'package:application/screens/d_day/d_day_screen.dart';
import 'package:application/screens/img/img_screen.dart';
import 'package:application/screens/timer/timer_main_screen.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final String cardTitle;
  final IconData icon;
  final String linkPage;

  const MenuWidget({
    super.key,
    required this.cardTitle,
    required this.icon,
    required this.linkPage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                switch (linkPage) {
                  case "blog":
                    return const BlogScreen();
                  case "img":
                    return const ImgScreen();
                  case "dday":
                    return const DDayScreen();
                  case "timer":
                    return const TimerMainScreen();
                  case "calendar":
                    return const CalendarMainScreen();
                  // value1에 해당하는 실행 코드
                  default:
                    return const BlogScreen();
                  // 위의 case에 모두 해당하지 않을 때 실행할 코드
                }
              },
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.all(10.0),
          color: Colors.white,
          child: SizedBox(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          icon,
                          size: 60,
                          color: const Color.fromARGB(255, 107, 105, 228),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cardTitle,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 75, 74, 160)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
