import 'package:fake_call/model/settings.dart';
import 'package:fake_call/widget/page_receive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// 수신 화면.
// todo 현지화 작업 필요.
class WaitCallPage extends StatefulWidget {
  final Settings settings;

  const WaitCallPage({Key? key, required this.settings}) : super(key: key);

  @override
  State<WaitCallPage> createState() => _WaitCallPageState();
}

class _WaitCallPageState extends State<WaitCallPage> {
  static const String hero_call = 'CALL';

  static const String hero_reject = 'REJECT';

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    FlutterRingtonePlayer.playRingtone();
    // todo, 매너모드가 아닐시의 사운드는 확인, 매너모드 유무체크해서 진동 해주면 좋을 것 같음.
  }

  @override
  void dispose() {
    super.dispose();
    FlutterRingtonePlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0, left: 40.0, right: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Call button.
            RippleAnimation(
              repeat: true,
              color: Colors.white.withOpacity(0.5),
              minRadius: 40.0,
              ripplesCount: 4,
              child: SizedBox(
                width: 72.0,
                height: 72.0,
                child: FloatingActionButton(
                  heroTag: hero_call,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.call, color: Colors.green, size: 34.0),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceivePage(settings: widget.settings),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Reject button.
            RippleAnimation(
              repeat: true,
              color: Colors.white,
              minRadius: 40.0,
              ripplesCount: 4,
              child: SizedBox(
                width: 72.0,
                height: 72.0,
                child: FloatingActionButton(
                  heroTag: hero_reject,
                  backgroundColor: Colors.white,
                  onPressed: () => SystemNavigator.pop(),
                  child: const Icon(Icons.call_end, color: Colors.red, size: 34.0),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Text(
                  AppLocalizations.of(context)!.voice_data,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 60.0),
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
            Column(
              children: [
                Icon(Icons.call, color: Colors.white, size: 14.0),
                SizedBox(height: 2.0),
                Text(
                  AppLocalizations.of(context)!.recent_call,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(),
                Container(
                  width: 80.0,
                  height: 4.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 8.0),
                Text(
                  AppLocalizations.of(context)!.send_message,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
