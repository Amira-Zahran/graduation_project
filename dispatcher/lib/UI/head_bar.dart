import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/API/GlobalDataRepo.dart';
import 'package:my_app/API/orderModel.dart';
import 'package:my_app/const/Colors/Config.dart';
import 'package:my_app/const/Colors/colors.dart';

class head_bar extends StatefulWidget {

  ValueChanged<int> onFilter;


  head_bar({Key? key,required this.onFilter});
  @override
  _head_barState createState() => _head_barState();
}
class _head_barState extends State<head_bar> {
  TextEditingController? _textEditingController=TextEditingController();
  int activeButton =0 ;


  @override
  Widget build(BuildContext context) {
    List<Orders> _orders = [];
    return Container(
      height: 57,
      color: AppColors.BarColor,
      child:Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(
              width: 30,
            ),

            Container(
              width: 190,
              height: 35,
              decoration: BoxDecoration(color: AppColors.ButtonColor,borderRadius: BorderRadius.all(Radius.circular(30),)),
              child: TextField(

                onChanged: (value){

                 setState(() {
                   SearchValue.value = value;
                   SearchValue.notifyListeners();
                 });

                  },
                controller: SearchController,
                decoration:  InputDecoration(
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Search",
                ),
              ),
            ),

            SizedBox(
              width: 30,
            ),

            SizedBox(
              width:145,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> Waitingorders()));
                  setState(() {
                    widget.onFilter(0);
                    activeButton = 0;
                  });
                },
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        '      All  ',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: (activeButton == 0
                                ? AppColors.BarColor
                                : AppColors.ButtonColor)),
                      ),
                    ),
                    Icon(
                      Icons.present_to_all,
                      color:activeButton==0
                          ? Config.BarColor
                          : Config.ButtonColor,
                      size: 20,
                    )
                  ],
                ),

                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all((
                        activeButton == 0
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
              width: 30,
            ),
            SizedBox(
              width:145,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> Waitingorders()));
                  setState(() {
                    widget.onFilter(1);
                    activeButton = 1;
                  });
                },
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        '  Waiting ',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: (activeButton == 1
                                ? AppColors.BarColor
                                : AppColors.ButtonColor)),
                      ),
                    ),
                    Icon(
                      Icons.add_alert_sharp,
                      color:activeButton==1
                          ? Config.BarColor
                          : Config.ButtonColor,
                      size: 20,
                    )
                  ],
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
              width: 30,
            ),

            SizedBox(
              width:145,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> Preparingorders()));
                  setState(() {
                    widget.onFilter(2);
                    activeButton = 2;
                  });
                },
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        'Preparing',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: (activeButton == 2
                                ? AppColors.BarColor
                                : AppColors.ButtonColor)),
                      ),
                    ),
                    Icon(
                      Icons.lunch_dining,
                      color:activeButton==2
                          ? Config.BarColor
                          : Config.ButtonColor,
                      size: 20,
                    )
                  ],
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
              width: 30,
            ),

            // SizedBox(
            //   width:120,
            //   height: 40,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Navigator.push(context, MaterialPageRoute(builder: (context)=> Doneorders()));
            //       setState(() {
            //         widget.onFilter(3);
            //         activeButton = 3;
            //       });
            //     },
            //     child: Row(
            //       children: [
            //         Center(
            //           child: Text(
            //             '  Done  ',
            //             style: TextStyle(
            //                 fontFamily: 'Cairo_Regular',
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //                 color: (activeButton == 3
            //                     ? AppColors.BarColor
            //                     : AppColors.ButtonColor)),
            //           ),
            //         ),
            //         Icon(
            //           Icons.done_all_sharp,
            //           color:activeButton==3
            //               ? Config.BarColor
            //               : Config.ButtonColor,
            //           size: 20,
            //         )
            //       ],
            //     ),
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all((
            //             activeButton == 3
            //                 ? AppColors.ButtonColor
            //                 : AppColors.BarColor)),
            //         shape: MaterialStateProperty.all(
            //             RoundedRectangleBorder(
            //                 borderRadius:
            //                 BorderRadius.all(Radius.circular(15)),
            //                 side: BorderSide(
            //                     color: AppColors.ButtonColor)))),
            //   ),
            // ),

            Expanded(child:   Text("Dispatcher",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo_Regular',
                color: AppColors.ButtonColor,
              ),),),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),

          ],
        ),
      ),
    );
  }
}

