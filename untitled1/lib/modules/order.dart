import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled1/config/Config.dart';
import 'package:untitled1/modules/Login.dart';
import 'package:untitled1/modules/request_info.dart';
import 'package:untitled1/modules/request_info.dart';
class orders extends StatefulWidget {
  const orders({Key? key}) : super(key: key);

  @override
  _ordersState createState() => _ordersState();
}

class _ordersState extends State<orders> {
  var id='#467';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder:(context,index)=>request(),
      itemCount: 10,);
  }
  Widget request() => SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 100,
    child: ElevatedButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>request_info()));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Color(Config.yellowColor),
            child: SizedBox(
              child: Text('$id',
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
                  child: Text('Khaled Mahdy',
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
                  child: Text('20th Huda Shaarawy,Nasr City',
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
                  child: Text('450 LE',
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
  );
}
