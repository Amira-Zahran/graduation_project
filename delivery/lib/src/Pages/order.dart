import 'dart:collection';

import 'package:delivery/main.dart';
import 'package:delivery/src/Controllers/Config.dart';
import 'package:delivery/src/Models/Order.dart';
import 'package:delivery/src/Pages/request_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class orders extends StatefulWidget {
  const orders({Key? key}) : super(key: key);

  @override
  _ordersState createState() => _ordersState();
}

class _ordersState extends State<orders> {
  // var id='#467';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UnmodifiableListView<Order>>(
      stream: bLoC.Orders,
        initialData: UnmodifiableListView<Order>([]),
        builder: (context,snapshot) {
        return ListView(
            children: snapshot.data!.map((e) => SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>request_info(order: e,)));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(Config.yellowColor),
                      child: SizedBox(
                        child: Text('#${e.order_id}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(Config.darkColor)
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 220,
                      //height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('${e.customer!.name}',
                              style: TextStyle(
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                                color: Color(Config.darkColor),

                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          //SizedBox(height: 5),
                          Expanded(
                            child: Text('${e.address!.address}, ${e.address!.area}, build no. ${e.address!.building}, Floor no. ${e.address!.floor}, apart no. ${e.address!.apart_num}',
                              style: TextStyle(
                                  fontSize: 16,
                                  //fontWeight: FontWeight.bold,
                                  color: Color(Config.darkColor)
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          //SizedBox(height: 5),
                          Expanded(
                            child: Text('${e.total} LE',
                              style: TextStyle(
                                  fontSize: 14,
                                  //fontWeight: FontWeight.bold,
                                  color: Color(Config.yellowColor)
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_forward_ios_outlined,
                      color: Color(Config.yellowColor),
                      size: 15,
                    )

                  ],
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10,horizontal: 5)),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),


              ),
            )).toList()
        );
        }
    );
  }
  // Widget request() => ;
}
