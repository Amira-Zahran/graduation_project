import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled1/config/Config.dart';
import 'package:untitled1/modules/Login.dart';
import 'package:untitled1/modules/request_info.dart';
import 'package:untitled1/modules/request_info.dart';
import 'package:untitled1/mainpage.dart';
import 'package:untitled1/modules/order.dart';

class request_info extends StatefulWidget {
  const request_info({Key? key}) : super(key: key);

  @override
  _request_infoState createState() => _request_infoState();
}

class _request_infoState extends State<request_info> {
  bool start_butt=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Config.darkColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Color(Config.yellowColor),),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('#467',
          style: TextStyle(
            color: Color(Config.yellowColor),
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.phone_in_talk),color: Color(Config.yellowColor),)
        ],
      ),
      body:
      Padding(
        padding: EdgeInsets.only(left: 8,top: 8,right: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                Text('Name:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(Config.darkColor)
                  ),

                ),
                SizedBox(width: 8,),
                Text('Khaled Mahdy',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(Config.darkColor)
                  ),

                ),

              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Text('Address:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(Config.darkColor)
                  ),

                ),
                SizedBox(width: 8,),
                Text('20th Huda Shaarawy, Nasr ',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(Config.darkColor)
                  ),

                ),

              ],
            ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text('Phone:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(Config.darkColor)
                    ),

                  ),
                  SizedBox(width: 8,),
                  Text('02022534456 ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(Config.darkColor)
                    ),

                  ),

                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text('Delivery fee:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(Config.darkColor)
                    ),

                  ),
                  SizedBox(width: 8,),
                  Text('20 LE ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(Config.darkColor)
                    ),

                  ),

                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text('Total:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(Config.darkColor)
                    ),

                  ),
                  SizedBox(width: 8,),
                  Text('450 LE ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(Config.darkColor)
                    ),

                  ),

                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text('Time:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(Config.darkColor)
                    ),

                  ),
                  SizedBox(width: 8,),
                  Text('12:35AM',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(Config.darkColor)
                    ),

                  ),

                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 125,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: (){},
                        child: Text('Use Navigator',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(Config.darkColor)
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(Config.yellowColor)),
                          elevation: MaterialStateProperty.all(0)

                        ),
                      )
                  )
                ],
              ),
              SizedBox(height: 15,),
              Divider(
                thickness: 1,
                color: Color(Config.yellowColor),
              ),
              Text('Order Items',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(Config.darkColor)
                ),
              ),
              SizedBox(height: 15,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder: (context,index)=>order_items(),
                  separatorBuilder: (context,index)=>SizedBox(height: 5,),
                  itemCount: 6
              ),
              SizedBox(height: 15,),
              Divider(
                thickness: 1,
                color: Color(Config.yellowColor),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                    start_butt=!start_butt;
                    if(start_butt=false){
                      Navigator.pop(context);
                    }
                    });

                  },
                  child: Text(start_butt?'start':'end',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(Config.darkColor)
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(start_butt?Color(Config.yellowColor):Colors.red),
                      elevation: MaterialStateProperty.all(0)

                  ),
                ),
              ),
              SizedBox(height: 15,),
              

            ],
          ),
        ),
      ),


    );
  }
  Widget order_items()=>Container(
    width: MediaQuery.of(context).size.width,
    height: 55,
    decoration: BoxDecoration(
        color: Color(Config.darkColor),
        borderRadius: BorderRadius.all(Radius.circular(6))
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 150,
            child: Text('Pizza',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(Config.yellowColor)
              ),
            ),
          ),
          Text('X1',
            style: TextStyle(
                fontSize: 14,
                color: Color(Config.yellowColor)
            ),
          ),
          Container(width: 45,
            child: Text('150 Le',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(Config.yellowColor)
              ),
            ),
          ),
        ],
      ),
    ),
  );
  Widget s_buttom()=>Container(
    decoration: BoxDecoration(
      color: Color(Config.yellowColor)
    ),
    child: Center(
      child: Text('Start Order',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(Config.darkColor)
        ),
      ),
    ),
  );
  Widget f_buttom()=>ElevatedButton(
    onPressed: (){},
    child: Text('Start Order',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color(Config.darkColor)
      ),
    ),
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(Config.yellowColor)),
        elevation: MaterialStateProperty.all(0)

    ),
  );
}
