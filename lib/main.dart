import 'package:fake_call/widget/page_settings.dart';
import 'package:fake_call/widget/page_wait_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

// TimeOfDay class 에서 밀리초를 제공해주지 않아, 별도로 DateTIme 으로 생성.
extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const startColor = 0xff4e9fb6;

  static const endColor = 0xff7accb5;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'a Fake call screen app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SettingsPage(),
    );
  }
}
