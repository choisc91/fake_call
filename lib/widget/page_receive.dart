import 'dart:async';

import 'package:fake_call/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:light/light.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 수신중 화면.
class ReceivePage extends StatefulWidget {
  final Settings settings;

  const ReceivePage({Key? key, required this.settings}) : super(key: key);

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  // 조도 센서 객체.
  final Light _lightSensor = Light();

  // 조도 센서 콜백.
  late StreamSubscription _subscription;

  // 조도센서 화면 꺼짐 여부.
  late bool _isDark = false;

  // 타이머 객체.
  late Timer _timer;

  // 타임 틱.
  late int _timerTick = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    initPlatformState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _timerTick = timer.tick);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    _timer.cancel();
  }

  //
  Future<void> initPlatformState() async {
    try {
      _subscription = _lightSensor.lightSensorStream.listen((int luxValue) {
        setState(() => _isDark = (luxValue > 10) ? false : true);
      });
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: (!_isDark)
          ? Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff4e9fb6),
                    Color(0xff7accb5),
                  ],
                ),
              ),
              child: Container(
                width: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: .0,
                            centerTitle: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.call, color: Colors.white, size: 16.0),
                                const SizedBox(width: 4.0),
                                Text(
                                  '00:${'${_timerTick}'.padLeft(2, '0')}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
                            ],
                          ),
                          const SizedBox(height: 48.0),
                          Text(
                            widget.settings.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36.0,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            '${AppLocalizations.of(context)!.call_type} ${widget.settings.number}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildIconButton(
                                    Icons.voicemail_outlined, AppLocalizations.of(context)!.record),
                                _buildIconButton(Icons.videocam_off_outlined,
                                    AppLocalizations.of(context)!.video_call),
                                _buildIconButton(
                                    Icons.bluetooth, AppLocalizations.of(context)!.bluetooth),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildIconButton(
                                    Icons.volume_up, AppLocalizations.of(context)!.speaker),
                                _buildIconButton(
                                    Icons.mic_off_outlined, AppLocalizations.of(context)!.mute),
                                _buildIconButton(
                                    Icons.dialpad, AppLocalizations.of(context)!.keypad),
                              ],
                            ),
                            SizedBox(
                              width: 72.0,
                              height: 72.0,
                              child: FloatingActionButton(
                                onPressed: () => SystemNavigator.pop(),
                                backgroundColor: Colors.red,
                                child: const Icon(
                                  Icons.call_end,
                                  color: Colors.white,
                                  size: 32.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  //
  Widget _buildIconButton(IconData icons, String label) {
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          Icon(icons, color: Colors.black, size: 28.0),
          const SizedBox(height: 12.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
