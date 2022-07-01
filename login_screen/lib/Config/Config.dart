import 'dart:convert';

import 'package:flutter/services.dart';

import 'api_helper.dart';

class Config{
  static Future<void> setSettings() async {
    try {
      Map<String, dynamic> parsed =
      json.decode(await rootBundle.loadString('assets/settings.json'));
      API.url = parsed['url'];
    } on Exception catch (e) {
      API.url = '';
      throw Exception(e);
    }
  }
}