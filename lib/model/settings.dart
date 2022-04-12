import 'package:flutter/material.dart';

class Settings {
  // 발신인.
  String name;

  // 발신 전화번호.
  String number;

  // 대기 화면에서의 대기 시간.
  Duration waitTime;

  Settings({required this.name, required this.number, required this.waitTime});
}
