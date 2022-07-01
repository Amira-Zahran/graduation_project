import 'dart:collection';
import 'dart:io';
import 'package:untitled6/src/Controllers/Config.dart';
import 'package:untitled6/src/Controllers/badCertificateHandler.dart';
import 'package:untitled6/src/UI/Order.dart'as ord;
import 'package:untitled6/src/Controllers/GlobalData.dart';
import 'package:untitled6/src/Models/Order.dart';
import 'src/UI/appBar.dart';
import 'package:flutter/material.dart';
// import 'Order.dart' as ord;

void main(List<String> arguments) {
  HttpOverrides.global = new DevHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POS APP',
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


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color color1() => const Color(0xFF0E232E);

  int filter = 0;

  Color color2() => const Color(0xFFF9B700);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: APPBar(onFilterChanged: (v){
          setState((){
            filter = v;
          });
        }),
      ),
      body: StreamBuilder<UnmodifiableListView<Order>>(
        stream: bLoC.Orders,
        initialData: UnmodifiableListView<Order>([]),
        builder: (context, snapshot) {
          return GridView(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 550,
                childAspectRatio: 2/1,
                crossAxisSpacing:10,
                mainAxisSpacing: 0),
            children: snapshot.data!.where((element) => filter == -1 ? DateTime.now()
                .difference(
                DateTime.parse(
                    element.created_at!))
                .inMinutes > 20 : (filter == 0 ? element.status!.contains('') : element.items!.where((element) => element.category == filter).length > 0) ).map((e) =>
                ord.OrderItem(order: e,)
            ).toList(),
          );
        }
      ),
    );
  }
}
