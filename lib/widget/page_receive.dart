import 'package:fake_call/model/settings.dart';
import 'package:flutter/material.dart';

// 수신중 화면.
class ReceivePage extends StatefulWidget {
  final Settings settings;

  const ReceivePage({Key? key, required this.settings}) : super(key: key);

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
