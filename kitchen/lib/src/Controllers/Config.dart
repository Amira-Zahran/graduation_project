import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'API.dart';
import 'GlobalData.dart';

class Config{
  //0xffF9B700 yellow
  //0xff0E232E blue
  static final int yellowColor = 0xffF9B700;
  static final int darkColor = 0xff0E232E;
  static Color BarColor =Color(0xFF0E232E);
  static Color ButtonColor =Color(0xFFF9B700);

  static Future<void> setSettings(context) async {
    try {
      // print(await rootBundle.loadString('assets/settings.json'));
      Map<String, dynamic> parsed =
      json.decode(await rootBundle.loadString('assets/settings.json'));
      API.url = parsed['url'];
      bLoC.login(context);
    } on Exception catch (e) {
      API.url = '';
      throw Exception(e);
    }
  }
}