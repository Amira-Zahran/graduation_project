import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter/material.dart';
import 'package:pos/src/Config/Config.dart';
import 'package:pos/src/Config/GlobalData.dart';

import 'package:pos/src/Config/ScrollConfiguration.dart';
import 'package:pos/src/Config/badCertificateHandler.dart';
import 'package:pos/src/ui/Pages/BlankPage.dart';
import 'package:pos/src/ui/Pages/MainPage.dart';

void main(List<String> arguments) {
  HttpOverrides.global = new DevHttpOverrides();
  print(arguments);
  var parser = ArgParser();
  var results = parser.parse(arguments);
  stdout.writeln(results.arguments);
  // Config.setSettings();
  // bLoC.login(results.arguments.where((element) => element.contains('--username=')).first.split('--username=')[1], results.arguments.where((element) => element.contains('--password=')).first.split('--password=')[1]);
  // bLoC.login('osharif','123456789');
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: BlankPage(),
    );
  }
}
