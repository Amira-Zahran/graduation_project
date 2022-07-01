import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/UI/list_view.dart';
import 'package:my_app/const/Colors/colors.dart';
import 'head_bar.dart';

class orders_page extends StatefulWidget {

  int filter;
  orders_page({Key? key,required this.filter});

  @override
  _orders_pageState createState() => _orders_pageState();
}

class _orders_pageState extends State<orders_page> {

  int ActiveFilter = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:BoxDecoration( color: AppColors.BarColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          children: [
            head_bar(onFilter: (v){
              setState(() {
                ActiveFilter = v;
              });
            },),
            Expanded(child:
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Listview(filterMain: widget.filter,filterSecond: ActiveFilter,),
                )
              ],
            ) ),
          ],
        ),
      ),
    );
  }
}

