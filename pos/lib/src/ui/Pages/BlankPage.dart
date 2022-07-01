import 'package:flutter/material.dart';
import 'package:pos/src/Config/Imports.dart';
class BlankPage extends StatelessWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config.setSettings(context);
    return Container();
  }
}
