import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  // StopWatchTimer 객체 생성
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // 위젯이 빌드된 후 최 하단으로 스크롤을 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  // 타이머 값을 저장할 리스트
  final int maxListLength = 20;
  final List<String> timerList = [];

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(
            top: 70.0,
            bottom: 70.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: 0,
                    builder: (context, snapshot) {
                      final displayTime = StopWatchTimer.getDisplayTime(
                        snapshot.data ?? 0,
                        hours: true,
                        minute: true,
                        second: true,
                        milliSecond: true,
                      );
                      return Text(
                        displayTime,
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // 스톱워치 시간 표시
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                if (_stopWatchTimer.isRunning) {
                                  _stopWatchTimer.onStopTimer();
                                } else {
                                  setState(() {
                                    _stopWatchTimer.onStartTimer();
                                  });
                                }
                              });
                            },
                            child: Icon(_stopWatchTimer.isRunning
                                ? Icons.pause
                                : Icons.play_arrow)),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: FloatingActionButton(
                            onPressed: () {
                              setState(
                                () {
                                  final displayTime =
                                      StopWatchTimer.getDisplayTime(
                                    _stopWatchTimer.rawTime.value,
                                    hours: true,
                                    minute: true,
                                    second: true,
                                    milliSecond: true,
                                  );

                                  if (displayTime != "00:00:00.00") {
                                    // 리스트 길이 제한 체크
                                    if (timerList.length >= maxListLength) {
                                      timerList.removeAt(0); // 첫 번째 항목 삭제
                                    }
                                    timerList.add(displayTime);

                                    _scrollToBottom();
                                  }
                                },
                              );
                            },
                            child: const Icon(Icons.check),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: FloatingActionButton(
                          onPressed: () {
                            _stopWatchTimer.onResetTimer();
                            setState(() {
                              timerList.clear();
                              _scrollToBottom();
                            });
                          },
                          child: const Icon(Icons.refresh),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // 그림자 효과
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(10.0),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              for (var item in timerList)
                                Row(
                                  children: [
                                    Text(
                                      item,
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  ],
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
