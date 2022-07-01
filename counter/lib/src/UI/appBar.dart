import 'dart:async';
import 'dart:collection';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled6/src/Controllers/Config.dart';
import 'package:untitled6/src/Controllers/GlobalData.dart';
import 'package:untitled6/src/Controllers/ScrollBehavior.dart';
import 'package:untitled6/src/Models/Category.dart';

class APPBar extends StatefulWidget {
  APPBar({Key? key, required this.onFilterChanged}) : super(key: key);

  ValueChanged<int>? onFilterChanged;

  @override
  State<APPBar> createState() => _APPBarState();
}

class _APPBarState extends State<APPBar> {
  int Activebutton = 0;
  Color color1 = const Color(0xFF0E232E);
  Color color2 = const Color(0xFFF9B700);

  // final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  //   onPrimary: (Activebutton == e.id) ? Config.BarColor
  //       : Config.ButtonColor,
  //   primary: const Color(0xFFF9B700),
  //   minimumSize: const Size(80, 30),
  //   padding: const EdgeInsets.all(5),
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(15)),
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: AppBar(
        flexibleSpace: Row(
          children: [
            Container(
                height: 100,
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.all(10),
                child: Image.asset("assets/3.png", fit: BoxFit.fill)),
            VerticalDivider(
              color: color2,
              thickness: 2,
              width: 30,
            ),
            StreamBuilder<UnmodifiableListView<Category>>(
              stream: bLoC.Categories,
                initialData: UnmodifiableListView<Category>([]),
                builder: (context, snapshot) {
                  return Container(
                    width: MediaQuery.of(context).size.width-300,
                    alignment: AlignmentDirectional.bottomCenter,
                    padding: EdgeInsets.all(10),
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: bLoC.categories.map((e) => Padding(
                            padding: const EdgeInsets.only(left:8.0,right: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: (Activebutton == e.id) ? Config.BarColor
                                    : Config.ButtonColor,
                                primary: (Activebutton == e.id) ? Config.BarColor
                                    : Config.ButtonColor,
                                minimumSize: const Size(80, 30),
                                padding: const EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(
                                    color: (Activebutton == e.id) ? Config.ButtonColor
                                        : Config.BarColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                widget.onFilterChanged!(e.id!);
                                Activebutton = e.id!;
                              },
                              child: Text(e.category_title!, style: TextStyle(color: (Activebutton == e.id) ? Config.ButtonColor
                                  : Config.BarColor, fontSize: 20)),
                            ),
                          )).toList(),
                        ),
                      ),
                    ),
                  );
                }
            )
          ],
        ),
        backgroundColor: color1,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Counter',
                style: TextStyle(
                    color: Color(0xFFF9B700),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal)),
          )
        ],
      ),
    );
  }
}
