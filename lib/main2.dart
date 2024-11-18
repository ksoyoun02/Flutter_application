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
          title: const Text(
            "test",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF6F6EE4),
        ),
        body: Column(
          children: [
            // 첫 번째 컨테이너
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: openYN ? 230 : 45, // 크기 조정
              color: Colors.white,
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
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.white24,
                          child: Container(
                            padding: const EdgeInsets.all(16.0), // 적당한 패딩 추가
                            decoration: BoxDecoration(
                              color: Colors.white, // 배경색
                              borderRadius:
                                  BorderRadius.circular(12), // 모서리 둥글게
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3), // 그림자 효과
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 프로필 사진
                                CircleAvatar(
                                  radius: 50, // 원형 크기
                                  child: Icon(
                                    Icons.person, // 사용자 아이콘
                                    size: 50, // 아이콘 크기
                                    color: Colors.grey, // 아이콘 색상
                                  ),
                                ),
                                SizedBox(height: 10), // 사진과 ID 사이의 간격
                                // 사용자 ID
                                Text(
                                  "user123", // 사용자 ID
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // 두 번째 컨테이너
            Expanded(
              child: Container(
                color: Colors.yellow,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.blue,
                            child: Container(
                              height: 100,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.blue,
                            child: Container(
                              height: 100,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
