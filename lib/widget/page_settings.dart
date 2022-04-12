import 'package:fake_call/model/settings.dart';
import 'package:fake_call/widget/page_wait.dart';
import 'package:fake_call/widget/page_wait_call.dart';
import 'package:flutter/material.dart';

// 설정 화면.
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPaGEState();
}

class _SettingsPaGEState extends State<SettingsPage> {
  // 발신인 이름.
  final TextEditingController _nameCtrl = TextEditingController();

  // 전화번호.
  final TextEditingController _numberCtrl = TextEditingController();

  // 식별 시간.
  final TextEditingController _timeCtrl = TextEditingController();

  // 선택된 대기 시간.
  int _duration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.green,
        child: const Icon(Icons.check),
        onPressed: () {
          // todo, 필드 에러 내면 더 좋을것 같음. From field 로 변경 고려해 볼 것.
          if (_nameCtrl.text.isNotEmpty && _numberCtrl.text.isNotEmpty && _duration != 0) {
            final settings = Settings(
              name: _nameCtrl.text,
              number: _numberCtrl.text,
              waitTime: Duration(milliseconds: _duration),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WaitPage(settings: settings)),
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 발신자 이름 입력 필드.
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
            // 전화번호 입력 필드.
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
            // 선택된 시간을 식별하는 필드.
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
      if (result != null) {
        final now = DateTime.now(); // 현재 시간.
        final selected =
            DateTime(now.year, now.month, now.day, result.hour, result.minute); // 선택된 시간.

        final distance = selected.millisecondsSinceEpoch - now.millisecondsSinceEpoch;

        if (distance > 0) {
          // 선택된 시간과 현재시간의 차만큼의 대기시간 생성.
          _duration = (selected.millisecondsSinceEpoch - now.millisecondsSinceEpoch).abs();
          setState(() {
            _timeCtrl.text = result.format(context);
          });
        } else {
          // todo 시간을 뒤로 땡기지 말라는 토스트 생성 바람.
        }
      }
    });
  }
}
