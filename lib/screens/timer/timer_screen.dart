import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class Timeinputfomatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // 길이를 4자리로 맞추기
    if (text.length > 4) {
      text = text.replaceAll(":", "").substring(1, 5); // 4자리 이상이면 잘라냄
    }

    String formattedText = text.length < 4
        ? text.replaceAll(":", "")
        : "${text.substring(0, 2)}:${text.substring(2)}";

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

enum TimerStatus { init, play, pause }

TimerStatus timerStatus = TimerStatus.init;

class _TimerScreenState extends State<TimerScreen> {
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  final CountDownController _controller = CountDownController();
  final TextEditingController _textController =
      TextEditingController(text: "00:10");

  bool _inputDisabled = false;
  int _totalTime = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(
            bottom: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularCountDownTimer(
                          textFormat: CountdownTextFormat.MM_SS,
                          duration: _totalTime,
                          width: 200,
                          height: 200,
                          ringColor: Colors.grey[300]!,
                          fillColor: const Color(0xFF6F6EE4),
                          backgroundColor: Colors.white,
                          strokeWidth: 10.0,
                          strokeCap: StrokeCap.round,
                          textStyle: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                          isReverse: true,
                          isTimerTextShown: true,
                          autoStart: false,
                          controller: _controller,
                          onComplete: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Countdown Finished!')),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 70.0, right: 60, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextField(
                        controller: _textController,
                        enabled: !_inputDisabled,
                        textAlign: TextAlign.center,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // 숫자만 허용
                          Timeinputfomatter()
                        ],
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 23),
                          labelText: 'Timer',
                          hintText: 'MM:SS',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: (timerStatus != TimerStatus.play &&
                              timerStatus != TimerStatus.init)
                          ? IconButton(
                              icon: const Icon(Icons.refresh_outlined),
                              onPressed: () {
                                var timeString = _textController.value.text;

                                var timeInt = 0;
                                if (timeString.length < 5) {
                                  timeInt = int.parse(timeString);
                                } else {
                                  timeInt =
                                      int.parse(timeString.split(":")[0]) * 60 +
                                          int.parse(timeString.split(":")[1]);
                                }

                                setState(() {
                                  _textController.text =
                                      "${(timeInt ~/ 60).toString().padLeft(2, "0")}:${(timeInt % 60).toString().padLeft(2, "0")}";
                                  _totalTime = timeInt;
                                  _controller.restart(duration: _totalTime);
                                  timerStatus = TimerStatus.play;
                                  _inputDisabled = true;
                                });
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: FloatingActionButton(
                            heroTag: 'btn1',
                            child: Icon((timerStatus == TimerStatus.init ||
                                    timerStatus == TimerStatus.pause)
                                ? Icons.play_arrow
                                : Icons.pause),
                            onPressed: () {
                              TimerStatus status;
                              var inputDisabled = true;

                              switch (timerStatus) {
                                case TimerStatus.init:
                                  status = TimerStatus.play;
                                  inputDisabled = true;
                                  _controller.start(); // 타이머 시작
                                  break;
                                case TimerStatus.play:
                                  status = TimerStatus.pause;
                                  inputDisabled = false;
                                  _controller.pause(); // 타이머 일시정지
                                  break;
                                case TimerStatus.pause:
                                  status = TimerStatus.play;
                                  inputDisabled = true;
                                  _controller.resume(); // 타이머 재개
                                  break;
                                default:
                                  status = TimerStatus.init;
                              }
                              setState(() {
                                _inputDisabled = inputDisabled;
                                timerStatus = status;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: FloatingActionButton(
                            heroTag: 'btn2',
                            child: const Icon(Icons.stop),
                            onPressed: () {
                              _controller.reset();
                              setState(() {
                                timerStatus = TimerStatus.init;
                                _inputDisabled = false;
                              });
                            },
                          ),
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
    );
  }
}
