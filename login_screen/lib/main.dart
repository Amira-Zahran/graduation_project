import 'package:flutter/material.dart';
import 'package:login_screen/Config/Bloc.dart';
import 'package:login_screen/my_login.dart';

import 'Config/Config.dart';

BLoC bLoC = BLoC();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Config.setSettings();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      home: LoginScreen(),
    );
  }
}
