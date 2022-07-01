import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/API/GlobalDataRepo.dart';
import 'package:my_app/API/orderModel.dart';
import 'package:my_app/const/Colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class side_bar extends StatefulWidget implements PreferredSizeWidget{

  ValueChanged<int>? onItemSelected;

  side_bar({Key? key, this.onItemSelected}) : super(key: key);

  @override
  _side_barState createState() => _side_barState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _side_barState extends State<side_bar> {
  ScrollController sideBar = new ScrollController();

  int activeButton =1 ;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.17,
        color: AppColors.BarColor,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            controller: sideBar,
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
                                    image: AssetImage('lib/const/images/Logo.png'),
                                    fit: BoxFit.contain)),
                          )]),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> home_page()));
                          setState(() {
                            print(currentOrder.id);
                            activeButton = 1;
                            widget.onItemSelected!(1);
                            vl.value = true;
                            vl.notifyListeners();
                            currentOrder = Orders(id: 0);
                            print(currentOrder.id);
                          });
                        },
                        child: Text(
                          'New',
                          style: TextStyle(
                              fontFamily: 'Cairo_Regular',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: (activeButton == 1
                                  ? AppColors.BarColor
                                  : AppColors.ButtonColor)),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all((
                                activeButton == 1
                                    ? AppColors.ButtonColor
                                    : AppColors.BarColor)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    side: BorderSide(
                                        color: AppColors.ButtonColor)))),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> on_the_way_orders()));
                          setState(() {
                            activeButton = 2;
                            widget.onItemSelected!(2);
                            vl.value = true;
                            vl.notifyListeners();
                            currentOrder = Orders(id: 0);
                          });
                        },
                        child: Text(
                          'On Way',
                          style: TextStyle(
                              fontFamily: 'Cairo_Regular',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: (activeButton == 2
                                  ? AppColors.BarColor
                                  : AppColors.ButtonColor)),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all((
                                activeButton == 2
                                    ? AppColors.ButtonColor
                                    : AppColors.BarColor)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    side: BorderSide(
                                        color: AppColors.ButtonColor)))),
                      ),
                    ),

                    SizedBox(
                      height: 60,
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> on_the_way_orders()));
                          setState(() {
                            activeButton = 3;
                            widget.onItemSelected!(3);
                            vl.value = true;
                            vl.notifyListeners();
                            currentOrder = Orders(id: 0);
                          });
                        },
                        child: Text(
                          'History',
                          style: TextStyle(
                              fontFamily: 'Cairo_Regular',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: (activeButton == 3
                                  ? AppColors.BarColor
                                  : AppColors.ButtonColor)),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all((
                                activeButton == 3
                                    ? AppColors.ButtonColor
                                    : AppColors.BarColor)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    side: BorderSide(
                                        color: AppColors.ButtonColor)))),
                      ),
                    ),

                    SizedBox(
                      height: 60,
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove('user');
                          Future.delayed(Duration(seconds: 1), () {
                            exit(0);
                          });
                        },
                        child: Text(
                          'Log out',
                          style: TextStyle(
                              fontFamily: 'Cairo_Regular',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: (activeButton == 4
                                  ? AppColors.BarColor
                                  : AppColors.ButtonColor)),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all((
                                activeButton == 4
                                    ? AppColors.ButtonColor
                                    : AppColors.BarColor)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                    side: BorderSide(
                                        color: AppColors.ButtonColor)))),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'System State :',
                              style: TextStyle(
                                  color: AppColors.ButtonColor,
                                  fontFamily: "Cairo_Regular",
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Text('Connected',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: "Cairo_Regular",
                                  fontSize: 17
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),

                  ],
                ))));
  }
}