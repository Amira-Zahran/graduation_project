import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos/src/Config/Config.dart';

import 'package:pos/src/ui/Widgets/CRM_SECTION.dart';
import 'package:pos/src/ui/Widgets/menu.dart';
import 'package:pos/src/Config/GlobalData.dart' as DataRepo;
import 'package:pos/src/ui/Widgets/newCustomer.dart';

import 'History.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  ScrollController sideBar = new ScrollController();

  // DataRepo.bLoC;
  int activeButton = 1;
  Widget _content = menu();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: DataRepo.scaffold,
      // appBar: AppBar(
      //   elevation: 0,
      //
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [NavigationBar(), _content],
        ),
      ),
    );
  }

//0xffF9B700 yellow
  //0xff0E232E blue
  Widget NavigationBar() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.17,
      color: Color(Config.darkColor),
      padding: EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    width: 170,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/imgs/Logo.png'),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 127,
                    width: 144,
                    child: Image.network('https://cdn-icons-png.flaticon.com/512/2922/2922506.png',scale: 5,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(Config.yellowColor)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${DataRepo.bLoC.user.name}',
                    style: TextStyle(
                        color: Color(Config.yellowColor),
                        fontSize: 30,
                        fontFamily: 'Cairo_Regular'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeButton = 1;
                          _content = menu();
                          DataRepo.orderDataRepo.clear();
                        });
                      },
                      child: Text(
                        'New Order',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(activeButton == 1
                                ? Config.darkColor
                                : Config.yellowColor)),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(
                              activeButton == 1
                                  ? Config.yellowColor
                                  : Config.darkColor)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(
                                      color: Color(Config.yellowColor))))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          activeButton = 2;
                          _content = history(onEvent: (v){
                            setState(() {
                              activeButton = v;
                              _content = menu();
                            });
                          },);
                        });
                      },
                      child: Text(
                        'History',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(activeButton == 2
                                ? Config.darkColor
                                : Config.yellowColor)),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(
                              activeButton == 2
                                  ? Config.yellowColor
                                  : Config.darkColor)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(
                                      color: Color(Config.yellowColor))))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  DataRepo.bLoC.user.type == 'CallCenterAgent' ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        newCustomerDialog(context,(){
                          setState(() {

                          });
                        });
                      },
                      child: Text(
                        'New Customer',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(activeButton == 3
                                ? Config.darkColor
                                : Config.yellowColor)),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(
                              activeButton == 3
                                  ? Config.yellowColor
                                  : Config.darkColor)),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(
                                      color: Color(Config.yellowColor))))),
                    ),
                  ) : Container(),
                  SizedBox(
                    height: 25,
                  ),
                  DataRepo.bLoC.user.type == 'CallCenterAgent' ? CRM_SECTION() : Container(),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(Config.darkColor)),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(
                                    color: Color(Config.yellowColor)))),


                      ),
                        onPressed: () {
                          exit(0);
                        },
                        child: Text('Logout',
                        style: TextStyle(
                          color: Color(Config.yellowColor),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular'
                        ),
                        )
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'System State:',
                        style: TextStyle(
                            color: Color(Config.yellowColor),
                            fontFamily: "Cairo_Regular",
                            //fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Connected',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: "Cairo_Regular",
                            //fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  )
                ],
              )
            ]),
      ),
    );
  }
}
