import 'dart:math';

import 'package:fake_call/main.dart';
import 'package:fake_call/model/settings.dart';
import 'package:fake_call/widget/page_wait.dart';
import 'package:flutter/material.dart';

// 설정 화면.
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPaGEState();
}

class _SettingsPaGEState extends State<SettingsPage> {
  final TextEditingController _nameCtrl = TextEditingController();

  final TextEditingController _numberCtrl = TextEditingController();

  final TextEditingController _timeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.green,
        child: const Icon(Icons.call),
        onPressed: () {
          // todo 확인처리.
          if (_nameCtrl.text.isNotEmpty && _numberCtrl.text.isNotEmpty) {
            final settings = Settings(
              name: _nameCtrl.text,
              number: _numberCtrl.text,
              waitTime: const Duration(milliseconds: 0),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WaitPage(settings: settings)),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                hintText: 'Please enter the caller\'s name',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _numberCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.call),
                hintText: 'Please enter the caller\'s number',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              readOnly: true,
              controller: _timeCtrl,
              onTap: _popTimePicker,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.punch_clock),
                hintText: 'Please pick a time for incoming calls',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 시간 선택하는 창 팝업.
  void _popTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((TimeOfDay? result) {
      // todo case 1. 현재 period 와 선택된 period 가 틀릴 경우.
      // todo case 2. 현재 시간보다 선택된 시간이 작을 경우.
      // todo == 위 두 케이스의 경우 selected 의 day 같을 하나 올려서 duration 을 구해야 할 듯 함.
      // ...
      if (result != null) {
        final now = DateTime.now();
        final selected =
            DateTime(now.year, now.month, now.day, result.hour, result.minute);

        setState(() {
          _timeCtrl.text = result.format(context);
        });

        // todo, Duration 객체 생성.
      }
    });
  }
}
