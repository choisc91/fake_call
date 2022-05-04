import 'package:fake_call/model/settings.dart';
import 'package:fake_call/widget/page_wait.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 설정 화면.
// todo 현지화 작업 필요.
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

  // 선택된 대기 시간.
  int _minute = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings_title,
          style: TextStyle(fontFamily: 'Yache'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_nameCtrl.text.isNotEmpty && _numberCtrl.text.isNotEmpty && _minute != 0) {
                final settings = Settings(
                  name: _nameCtrl.text,
                  number: _numberCtrl.text,
                  // todo 테스트 용, 실제 분으로 바꾸기 바람.
                  waitTime: Duration(seconds: _minute),
                  // waitTime: Duration(minutes: _minute),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WaitPage(settings: settings)),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            // 발신자 이름 입력 필드.
            TextField(
              controller: _nameCtrl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: TextStyle(fontFamily: 'Yache'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                labelText: AppLocalizations.of(context)!.input_name,
              ),
            ),
            const SizedBox(height: 12.0),
            // 전화번호 입력 필드.
            TextField(
              controller: _numberCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              style: TextStyle(fontFamily: 'Yache'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.call),
                labelText: AppLocalizations.of(context)!.input_number,
              ),
            ),
            const SizedBox(height: 16.0),
            // 선택된 시간을 식별하는 필드.
            Text(
              AppLocalizations.of(context)!.wait_time_header,
              style: TextStyle(
                fontFamily: 'Yache',
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 16.0),
            NumberPicker(
              value: _minute,
              minValue: 0,
              maxValue: 60,
              step: 1,
              itemHeight: 100.0,
              textStyle: TextStyle(fontFamily: 'Yache'),
              axis: Axis.horizontal,
              onChanged: (value) => setState(() => _minute = value),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.black26),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() {
                    final newValue = _minute - 1;
                    _minute = newValue.clamp(0, 60);
                  }),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '$_minute ${AppLocalizations.of(context)!.wait_time_value}',
                  style: TextStyle(
                    fontFamily: 'Yache',
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() {
                    final newValue = _minute + 1;
                    _minute = newValue.clamp(0, 60);
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
