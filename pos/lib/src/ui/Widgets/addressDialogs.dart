import 'package:flutter/material.dart';
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Models/Addresse.dart';

import 'AlertDialogs.dart';

Widget? newAddressDialog(context,VoidCallback callback){
  TextEditingController address = new TextEditingController();
  TextEditingController building = new TextEditingController();
  TextEditingController floor = new TextEditingController();
  TextEditingController flat = new TextEditingController();

  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Color(Config.darkColor),
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Address',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo_Regular',
                    color: Color(Config.yellowColor)
                ),
              ),
              IconButton(
                  onPressed: (){
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: Icon(Icons.close_rounded,size: 30,color: Color(Config.yellowColor),)

              )
            ],
          ),
          content: Container(
            height: 300,
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                //SizedBox(height: 50,),
                Row(
                  children: [
                    Text('Address',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)
                      ),
                    ),
                    SizedBox(width:20,),
                    SizedBox(
                      width: 500,
                      height: 30,

                      child: TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),

                        ),
                      ),
                    )
                  ],
                ),
                //SizedBox(height: 50,),
                Row(
                  children: [
                    Text('Building',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)
                      ),
                    ),
                    SizedBox(width:20,),
                    SizedBox(
                      width: 60,
                      height: 30,

                      child: TextFormField(
                        controller: building,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),

                        ),
                      ),
                    ),
                    SizedBox(width:100,),
                    Text('Floor',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)
                      ),
                    ),
                    SizedBox(width:20,),
                    SizedBox(
                      width: 60,
                      height: 30,

                      child: TextFormField(
                        controller: floor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),

                        ),
                      ),
                    ),
                    SizedBox(width:100,),
                    Text('Flat',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)
                      ),
                    ),
                    SizedBox(width:20,),
                    SizedBox(
                      width: 60,
                      height: 30,

                      child: TextFormField(
                        controller: flat,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),

                        ),
                      ),
                    )

                  ],
                ),
                //SizedBox(height: 50,),
                SizedBox(
                  width: 130,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context, rootNavigator: true).pop();
                      showLoadingDialog(
                          scaffold.currentContext!);
                      customerData.insertAddress(context:scaffold.currentContext!,address: address.text, area: '.', building: building.text, floor: floor.text, apart_num: flat.text,callback: (){
                        callback();
                      } );

                    },
                    child: Text('Confirm',
                      style: TextStyle(
                          fontFamily: 'Cairo_Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(Config.yellowColor))
                    ),
                  ),

                )
              ],
            ),
          ),

        );
      }

  );
  return null;
}

Widget? editAddressDialog(context,Addresse addresse,VoidCallback callback){
  TextEditingController address = new TextEditingController(text: addresse.address);
  TextEditingController building = new TextEditingController(text: addresse.building);
  TextEditingController floor = new TextEditingController(text: addresse.floor);
  TextEditingController flat = new TextEditingController(text: addresse.apart_num);

  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Color(Config.darkColor),
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Address',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo_Regular',
                    color: Color(Config.yellowColor)
                ),
              ),
              IconButton(
                  onPressed: (){
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: Icon(Icons.close_rounded,size: 30,color: Color(Config.yellowColor),)

              )
            ],
          ),
          content: Container(
            height: 300,
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                //SizedBox(height: 50,),
                Row(
                  children: [
                    Text('Address',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)
                      ),
                    ),
                    SizedBox(width:20,),
                    SizedBox(
                      width: 500,
                      height: 30,

                      child: TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),

                        ),
                      ),
                    )
                  ],
                ),
                //SizedBox(height: 50,),
                Row(
                  children: [
                    Text('Building',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)
                      ),
                    ),
                    SizedBox(width:20,),
                    SizedBox(
                      width: 60,
                      height: 30,

                      child: TextFormField(
                        controller: building,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),

                        ),
                      ),
                    ),
                    SizedBox(width:100,),
                    Text('Floor',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)
                      ),
                    ),
                    SizedBox(width:20,),
                    SizedBox(
                      width: 60,
                      height: 30,

                      child: TextFormField(
                        controller: floor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),

                        ),
                      ),
                    ),
                    SizedBox(width:100,),
                    Text('Flat',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)
                      ),
                    ),
                    SizedBox(width:20,),
                    SizedBox(
                      width: 60,
                      height: 30,

                      child: TextFormField(
                        controller: flat,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),

                        ),
                      ),
                    )

                  ],
                ),
                //SizedBox(height: 50,),
                SizedBox(
                  width: 130,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context, rootNavigator: true).pop();
                      showLoadingDialog(
                          scaffold.currentContext!);
                      customerData.updateAddress(context:scaffold.currentContext,address: address.text, area: '', building: building.text, floor: floor.text, apart_num: flat.text,callback: (){callback();});

                    },
                    child: Text('Confirm',
                      style: TextStyle(
                          fontFamily: 'Cairo_Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(Config.yellowColor))
                    ),
                  ),

                )
              ],
            ),
          ),

        );
      }

  );
  return null;
}