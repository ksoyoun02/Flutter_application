import 'package:application/const/colors.dart';
import 'package:application/screens/dice/dice_screen.dart';
import 'package:application/screens/dice/dice_setting_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shake/shake.dart';

class DiceMainScreen extends StatefulWidget {
  const DiceMainScreen({super.key});

  @override
  State<DiceMainScreen> createState() => _DiceMainScreenState();
}

class _DiceMainScreenState extends State<DiceMainScreen>
    with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller!.addListener(tabListener);

    shakeDetector = ShakeDetector.autoStart(
      shakeSlopTimeMS: 100,
      shakeThresholdGravity: threshold,
      onPhoneShake: onPhoneShake,
    );
  }

  void onPhoneShake() {
    final rand = Random();
    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  tabListener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    shakeDetector!.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      const DiceScreen(number: 1),
      DiceSettingScreen(
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      )
    ];
  }

  void onThresholdChange(double val) {
    setState(
      () {
        threshold = val;
      },
    );
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.edgesensor_high_outlined),
          label: "주사위",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "설정",
        )
      ],
    );
  }
}
