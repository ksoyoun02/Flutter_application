import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              Flexible(
                flex: 2,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  color: Colors.yellow,
                ),
              )
            ],
          )),
    );
  }
}
