import 'package:flutter/material.dart';
import 'package:my_app/UI/history/History.dart';
import 'package:my_app/UI/orders_Page.dart';
import 'package:my_app/UI/side_bar_menu.dart';
import '../const/Colors/colors.dart';

class home_page extends StatefulWidget {

  @override
  _home_pageState createState() => _home_pageState();
}
class _home_pageState extends State<home_page> {

  int ItemSelected = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BarColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            //Side Button Menu
            Container(
              width: MediaQuery.of(context).size.width*0.17,
              child: side_bar(onItemSelected: (v){
                setState(() {
                  ItemSelected = v;
                });
              },),
            ),


            //Mian Body
            ItemSelected == 3 ? Container(width:MediaQuery.of(context).size.width-327,height: MediaQuery.of(context).size.height,child: HistoryPage()): Expanded(
                flex: 4,
                child: Container(
                  child: orders_page(filter: ItemSelected,),
                )),

          ],
        ),
      ),

    );
  }
}
