import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled1/config/Config.dart';
import 'package:untitled1/modules/Login.dart';
import 'package:untitled1/modules/order.dart';
import 'package:untitled1/modules/request_info.dart';
import 'package:untitled1/modules/request_info.dart';
import 'package:untitled1/modules/finished_odrer_info.dart';
class finished_order extends StatefulWidget {
  const finished_order({Key? key}) : super(key: key);

  @override
  _finished_orderState createState() => _finished_orderState();
}

class _finished_orderState extends State<finished_order> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index)=>Padding(
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
                              MaterialPageRoute(builder: (context)=>finished_info()));
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('#467',
                            style: TextStyle(
                              color: Color(Config.darkColor),
                              fontSize: 16,

                            ),
                          ),
                          Text('12:35AM',
                            style: TextStyle(
                              color: Color(Config.darkColor),
                              fontSize: 16,

                            ),
                          ),
                          Text('450 LE',
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
        ),
        separatorBuilder: (context,indes)=>SizedBox(height: 5,),
        itemCount: 20);
  }
}

