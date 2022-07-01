
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_app/API/GlobalDataRepo.dart';
import 'package:my_app/API/apiHelper.dart';
import 'package:flutter/cupertino.dart';

class Config{
  //0xffF9B700 yellow
  //0xff0E232E blue
  static const int yellowColor = 0xffF9B700;
  static const int darkColor = 0xff0E232E;
  static const int green = 0x46FF5F4C;
  static const int Purple = 0xFF7B4DFD;
  static const int white = 0xFFFFFFFF;
  static const int red = 0xFFFF2E2E;

  static Color BarColor =Color(0xFF0E232E);
  static Color ButtonColor =Color(0xFFF9B700);
  static Color purple =Color(0x4C46FF5F);
  static Future<void> setSettings(context) async {
    try {
      Map<String, dynamic> parsed =
      json.decode(await rootBundle.loadString('lib/const/settings.json'));
      API.url = parsed['url'];
      bLoC.login(context);
    } on Exception catch (e) {
      API.url = '';
      throw Exception(e);
    }
  }

  }