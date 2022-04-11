import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

// 수신 화면.
class WaitCallPage extends StatefulWidget {
  const WaitCallPage({Key? key}) : super(key: key);

  @override
  State<WaitCallPage> createState() => _WaitCallPageState();
}

class _WaitCallPageState extends State<WaitCallPage> {
  @override
  void initState() {
    super.initState();
    _vibration();
  }

  // 진동.
  void _vibration() async {
    final bool? isChecked = await Vibration.hasVibrator();
    if (isChecked != null && isChecked) {
      Vibration.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
