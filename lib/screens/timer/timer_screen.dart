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
      text = text.replaceAll(":", "").substring(0, 4); // 4자리 이상이면 잘라냄
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

class _TimerScreenState extends State<TimerScreen> {
  final CountDownController _controller = CountDownController();
  final TextEditingController _textController =
      TextEditingController(text: "00:10");
  var timerStatus = "init";
  bool _inputDisabled = false;
  int _totalTime = 100;

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
                          fillColor: Theme.of(context).secondaryHeaderColor,
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
                          labelText: 'Timer',
                          hintText: '00',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 5),
                      child: Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(Icons.refresh_outlined),
                          onPressed: () {
                            var timeString = _textController.value.text;
                            var timeInt =
                                int.parse(timeString.split(":")[0]) * 60 +
                                    int.parse(timeString.split(":")[1]);
                            setState(() {
                              _totalTime = timeInt;
                            });
                          },
                        ),
                      ),
                    )
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
                            child: Icon((timerStatus == "init" ||
                                    timerStatus == "pause")
                                ? Icons.play_arrow
                                : Icons.pause),
                            onPressed: () {
                              var status = "";
                              var inputDisabled = true;

                              switch (timerStatus) {
                                case "init":
                                  status = "play";
                                  inputDisabled = true;
                                  _controller.start();
                                  break;
                                case "play":
                                  status = "pause";
                                  inputDisabled = false;
                                  _controller.pause();
                                  break;
                                case "pause":
                                  status = "play";
                                  inputDisabled = true;
                                  _controller.resume();
                                  break;
                                default:
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
                                timerStatus = "init";
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
