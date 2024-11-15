import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var openYN = true;

  void btnClick() {
    setState(() {
      openYN = !openYN;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("test"),
          backgroundColor: const Color.fromARGB(255, 235, 238, 243),
        ),
        body: Column(
          children: [
            // 첫 번째 컨테이너
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: openYN ? 200 : 60, // 크기 조정
              color: Colors.red,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: btnClick,
                        icon: Icon(
                          openYN
                              ? Icons.keyboard_arrow_up_sharp
                              : Icons.keyboard_arrow_down_sharp,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 두 번째 컨테이너
            Expanded(
              child: Container(
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
