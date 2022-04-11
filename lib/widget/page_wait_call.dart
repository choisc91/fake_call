import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
