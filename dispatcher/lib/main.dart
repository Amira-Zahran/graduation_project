import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_app/UI/home_page.dart';

import 'API/CertificateHandler.dart';
import 'API/GlobalDataRepo.dart';
import 'const/Colors/Config.dart';

void main(List<String> arguments) {
  HttpOverrides.global = new DevHttpOverrides();
  print(arguments);
  runApp(const MyApp());
  // bLoC.login('omarr','123456789');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dispatcher',
      home: BlankPage(),
      );
  }
}

class BlankPage extends StatelessWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config.setSettings(context);
    return Container();
  }
}
