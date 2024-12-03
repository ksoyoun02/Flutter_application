import 'package:application/screens/blog/blog_screen.dart';
import 'package:application/screens/calendar/calendar_main_screen.dart';
import 'package:application/screens/choolCheck/chool_check_screen.dart';
import 'package:application/screens/d_day/d_day_screen.dart';
import 'package:application/screens/dice/dice_main_screen.dart';
import 'package:application/screens/imageEditor/image_editor_screen.dart';
import 'package:application/screens/img/img_screen.dart';
import 'package:application/screens/timer/timer_main_screen.dart';
import 'package:application/screens/video/video_screen.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final String cardTitle;
  final IconData? iconData; // IconData 타입을 nullable로 받기
  final Icon? icon;
  final String linkPage;

  const MenuWidget({
    super.key,
    required this.cardTitle,
    required this.linkPage,
    this.icon,
    this.iconData,
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
                  case "dice":
                    return const DiceMainScreen();
                  case "video":
                    return const VideoScreen();
                  case "choolCheck":
                    return const ChoolCheckScreen();
                  case "imageEditor":
                    return const ImageEditorScreen();
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
                        icon != null
                            ? Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: icon!,
                              ) // Icon이 전달된 경우
                            : Icon(
                                // IconData가 전달된 경우
                                iconData,
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
