import 'dart:collection';

import 'package:delivery/main.dart';
import 'package:delivery/src/Controllers/Config.dart';
import 'package:delivery/src/Models/Order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'finished_odrer_info.dart';
class finished_order extends StatefulWidget {
  const finished_order({Key? key}) : super(key: key);

  @override
  _finished_orderState createState() => _finished_orderState();
}

class _finished_orderState extends State<finished_order> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UnmodifiableListView<Order>>(
        builder: (context,snapshot){
          return ListView(
            children: snapshot.data!.map((e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(Config.yellowColor)),
                              elevation: MaterialStateProperty.all(0)
                          ),
                          onPressed: (){
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=>finished_info(order: e,)));
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('#${e.id}',
                                style: TextStyle(
                                  color: Color(Config.darkColor),
                                  fontSize: 16,

                                ),
                              ),
                              Text('${e.created_at}',
                                style: TextStyle(
                                  color: Color(Config.darkColor),
                                  fontSize: 16,

                                ),
                              ),
                              Text('${e.total} LE',
                                style: TextStyle(
                                  color: Color(Config.darkColor),
                                  fontSize: 16,

                                ),
                              ),
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),
            )).toList(),
          );
        },
        stream: bLoC.OrdersHistory,
        initialData: UnmodifiableListView<Order>([])
    );
  }
}

