import 'dart:collection';

import 'package:untitled6/Order.dart'as ord;
import 'package:untitled6/src/Controllers/GlobalData.dart';
import 'package:untitled6/src/Models/Order.dart';
import 'appBar.dart';
import 'package:flutter/material.dart';
// import 'Order.dart' as ord;

void main() => bLoC.login('osharif', '123456789');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POS APP',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color color1() => const Color(0xFF0E232E);

  Color color2() => const Color(0xFFF9B700);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: APPBar(),
      ),
      body: StreamBuilder<UnmodifiableListView<Order>>(
        stream: bLoC.Orders,
        initialData: UnmodifiableListView<Order>([]),
        builder: (context, snapshot) {
          return GridView(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
                childAspectRatio: 3/2,
                crossAxisSpacing:20,
                mainAxisSpacing: 0),
            children: snapshot.data!.map((e) => ord.OrderItem(order: e,)).toList(),
          );
        }
      ),
    );
  }
}
