import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImgScreen extends StatefulWidget {
  const ImgScreen({super.key});

  @override
  State<ImgScreen> createState() => _ImgScreenState();
}

class _ImgScreenState extends State<ImgScreen> {
  PageController pageController = PageController();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int? nextPage = pageController.page?.toInt();

      if (nextPage == null) {
        return;
      }

      if (nextPage == 4) {
        nextPage = 0;
      } else {
        nextPage++;
      }
      pageController.animateToPage(nextPage,
          duration: const Duration(microseconds: 600), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Timer 해제
    pageController.dispose(); // PageController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5]
            .map((number) => Image.asset(
                  "asset/img/image_$number.jpeg",
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}
