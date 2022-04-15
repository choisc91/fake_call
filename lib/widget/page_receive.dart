import 'package:fake_call/model/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 수신중 화면.
class ReceivePage extends StatefulWidget {
  final Settings settings;

  const ReceivePage({Key? key, required this.settings}) : super(key: key);

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        children: const [
                          Icon(Icons.call, color: Colors.white, size: 16.0),
                          SizedBox(width: 4.0),
                          Text('00:08', style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
                      '휴대전화 ${widget.settings.number}',
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
                          _buildIconButton(Icons.voicemail_outlined, '녹음'),
                          _buildIconButton(Icons.videocam_off_outlined, '영상통화'),
                          _buildIconButton(Icons.bluetooth, '블루투스'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconButton(Icons.volume_up, '스피커'),
                          _buildIconButton(Icons.mic_off_outlined, '내 소리 차단'),
                          _buildIconButton(Icons.dialpad, '키패드'),
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
      ),
    );
  }

  //
  Widget _buildIconButton(IconData icons, String label) {
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          Icon(icons, color: Colors.black, size: 24.0),
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
