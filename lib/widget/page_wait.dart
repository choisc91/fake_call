import 'package:fake_call/model/settings.dart';
import 'package:fake_call/widget/page_wait_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 수신 대기 화면.
class WaitPage extends StatefulWidget {
  final Settings settings;

  const WaitPage({Key? key, required this.settings}) : super(key: key);

  @override
  State<WaitPage> createState() => _WaitPageState();
}

class _WaitPageState extends State<WaitPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _wait();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(),
    );
  }

  // 현재 페이지 대기.
  void _wait() async {
    final duration = widget.settings.waitTime;
    await Future.delayed(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WaitCallPage()),
      );
    });
  }
}
