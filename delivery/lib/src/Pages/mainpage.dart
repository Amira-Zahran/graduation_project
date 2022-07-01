import 'package:delivery/src/Controllers/Config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Login.dart';
import 'finished_order.dart';
import 'order.dart';

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
int currentIndex=0;
List<Widget>screens=[
  orders(),
  finished_order()
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(Config.darkColor),
        elevation: 0,
        leading: IconButton(onPressed:(){

        },
          icon:Icon(Icons.account_circle,
        color: Color(Config.yellowColor),
          size: 25,
        ),

        ),
        title: Container(
          width: 220,
          height: 45,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/imgs/Logo.png')
              )
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout,
            size: 25,
              color: Color(Config.yellowColor),
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
            },
          )
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.done),label: 'Finished'),
        ],
      ),
    );
  }

}
