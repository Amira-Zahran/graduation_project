import 'dart:convert';

import 'package:flutter/services.dart';

import 'API_HELPR.dart';
import 'GlobalData.dart';

class Config{
  //0xffF9B700 yellow
  //0xff0E232E blue
  static final int yellowColor = 0xffF9B700;
  static final int darkColor = 0xff0E232E;

  static Future<void> setSettings(context) async {
    try {
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