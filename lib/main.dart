import 'package:fake_call/widget/page_settings.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

// TimeOfDay class 에서 밀리초를 제공해주지 않아, 별도로 DateTIme 으로 생성.
extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const startColor = 0xff4e9fb6;

  static const endColor = 0xff7accb5;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'a Fake call screen app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingsPage(),
      // home: WaitPage(
      //   settings: Settings(
      //     name: 'NAME',
      //     number: 'CALL_NUMBER',
      //     waitTime: const Duration(seconds: 5),
      //   ),
      // ),
    );
  }

  //
  Widget _sample() {
    return Scaffold(
      body: Column(
        children: [
          RippleAnimation(
            repeat: true,
            color: Colors.blue,
            minRadius: 90,
            ripplesCount: 6,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
