import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/view/timer_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      theme: ThemeData(
        // primaryColor: const Color.fromRGBO(109, 234, 255, 1),
        // colorScheme: const ColorScheme.light(
        //   secondary: Color.fromRGBO(72, 74, 126, 1),
        primaryColor: const Color.fromARGB(255, 236, 73, 14),
        colorScheme: const ColorScheme.light(
          secondary: Colors.amber,
        ),
      ),
      home: const TimerPage(),
    );
  }
}
