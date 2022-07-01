
import 'package:flutter/material.dart' hide MenuItem;
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Config/ScrollConfiguration.dart';
import 'package:pos/src/ui/Widgets/Receipt.dart';

import 'AddItemDialog.dart';

class menu extends StatefulWidget implements PreferredSizeWidget {
  menu({Key? key,required this.callback}) : super(key: key);
  VoidCallback callback;

  @override
  _menuState createState() => _menuState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _menuState extends State<menu> {
  TextEditingController searchController = TextEditingController();
  @override
  int bmb = 0;

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.62,
            child: Column(
              children: [
                Text(
                  '11:35AM',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      color: Color(Config.darkColor)
                  ),
                ),
                Divider(
                  color: Color(Config.darkColor),

                ),
                SizedBox(height: 10,),
                StreamBuilder<UnmodifiableListView<Category>>(
                    stream: bLoC.MenuCategory,
                    initialData: UnmodifiableListView<Category>([]),
                    builder: (context, snapshot) {
                      List<Category> _categories = [Category(category_title: 'All',id: 0)];
                      _categories.addAll(snapshot.data!.map((e) => e).toList());
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(

                            children: _categories.map((e) => Padding(
                              padding: const EdgeInsets.only(left: 2,right: 2),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      bmb = e.id!;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Color(bmb == e.id ? Config.yellowColor : Config.darkColor)),
                                    elevation: MaterialStateProperty.all(0),
                                    // shape: MaterialStateProperty.all(
                                    //     RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.all(Radius.circular(15)),
                                    //         side: BorderSide(color: Color(Config.yellowColor))
                                    //     )
                                    // )
                                  ),
                                  child: Text(
                                    e.category_title!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: 'Cairo_Regular',
                                        color: Color(bmb == e.id
                                            ? Config.darkColor
                                            : Config.yellowColor)),
                                  )),
                            )).toList(),
                          ),
                        ),
                      );
                    }
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 300,
                        height: 40,
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              // search = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Search Item',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Cairo_Regular',
                                color: Color(Config.darkColor)),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(Config.darkColor),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(2),
                          icon: Icon(Icons.search),
                          color: Color(Config.yellowColor),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 152,
                  child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: StreamBuilder<UnmodifiableListView<MenuItem>>(
                        stream: bLoC.MenuItems,
                        initialData: UnmodifiableListView<MenuItem>([]),
                        builder: (context, snapshot) {
                          return GridView.extent(
                              maxCrossAxisExtent: 200,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              shrinkWrap: true,
                              padding: EdgeInsets.all(5),
                              children: 
                              (bmb == 0 ? snapshot.data!.where((element) =>  element.item_name!.contains(searchController.text)) : snapshot.data!.where((element) => element.category?.id == bmb && element.item_name!.contains(searchController.text))).map((e) => InkWell(
                                onTap: (){
                                  addItemDialog(context: context,menuItem: e,callback: (){setState(() {

                                  });});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Color(Config.darkColor),
                                  ),

                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 105,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(e.item_photo!),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      ),
                                      Text('${e.item_name!}',style: TextStyle(
                                          color: Color(Config.yellowColor),
                                          fontSize: 18,
                                          fontFamily: 'Cairo_Regular',
                                          fontWeight: FontWeight.bold

                                      ),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,),
                                      Text(e.item_price!,style: TextStyle(
                                          color: Color(Config.yellowColor),
                                          fontSize: 18,
                                          fontFamily: 'Cairo_Regular',
                                          fontWeight: FontWeight.bold

                                      ),)
                                    ],
                                  ),
                                ),
                              )
                              ).toList()
                          );
                        }
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.21,
              child: Receipt(callback: (){widget.callback();},)
          ),
        ],
      ),
    );
  }
}
