import 'package:flutter/material.dart';
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/ui/Widgets/AlertDialogs.dart';

Widget? newCustomerDialog(context, VoidCallback? onPressed) {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = new TextEditingController();
  TextEditingController phone =
      new TextEditingController(text: customerData.phone_number.text);
  TextEditingController address = new TextEditingController();
  TextEditingController building = new TextEditingController();
  TextEditingController floor = new TextEditingController();
  TextEditingController flat = new TextEditingController();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(Config.darkColor),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Customer',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo_Regular',
                    color: Color(Config.yellowColor)),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: 30,
                    color: Color(Config.yellowColor),
                  ))
            ],
          ),
          content: Form(
            key: _formKey,
            child: Container(
              height: 300,
              width: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo_Regular',
                            color: Color(Config.yellowColor)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 170,
                        // height: 30,
                        child: TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(3),
                            fillColor: Color(Config.yellowColor),
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        'Phone',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo_Regular',
                            color: Color(Config.yellowColor)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 170,
                        // height: 30,
                        child: TextFormField(
                          controller: customerData.phone_number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            RegExp regExp = new RegExp(r'[a-zA-Z]');
                            // setState(() {
                            print(regExp.hasMatch(v));
                            if (regExp.hasMatch(v)) {
                              // print(regExp.hasMatch(v.splitMapJoin('')));

                              customerData.phone_number.text =
                                  v.substring(0, v.length);
                            }
                            // });
                          },
                          // controller: phone,
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
                      Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo_Regular',
                            color: Color(Config.yellowColor)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 500,
                        // height: 30,
                        child: TextFormField(
                          controller: address,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
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
                      Text(
                        'Building',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo_Regular',
                            color: Color(Config.yellowColor)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 60,
                        // height: 30,
                        child: TextFormField(
                          controller: building,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter building';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(3),
                            fillColor: Color(Config.yellowColor),
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        'Floor',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo_Regular',
                            color: Color(Config.yellowColor)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 60,
                        // height: 30,
                        child: TextFormField(
                          controller: floor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter floor';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(3),
                            fillColor: Color(Config.yellowColor),
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        'Flat',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Cairo_Regular',
                            color: Color(Config.yellowColor)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 60,
                        // height: 30,
                        child: TextFormField(
                          controller: flat,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter flat';
                            }
                            return null;
                          },
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context, rootNavigator: true).pop();
                          showLoadingDialog(context);
                          customerData.newCustomer(
                              callback: () {
                                // setState((() {
                                onPressed!();
                                // }));
                              },
                              phone_number: customerData.phone_number.text,
                              building: building.text,
                              area: '  ',
                              apart_num: flat.text,
                              address: address.text,
                              floor: floor.text,
                              name: name.text,
                              context: context);
                        }
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                            fontFamily: 'Cairo_Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(Config.yellowColor))),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
  return null;
}

Widget? editCustomerDialog(context, VoidCallback callback) {
  // TextEditingController name = new TextEditingController(text: customerData.customerData.name);
  // TextEditingController phone = new TextEditingController(text: customerData.customerData.phones?.first.phone_number);
  // TextEditingController phone2 = new TextEditingController(text: );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(Config.darkColor),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Customer',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo_Regular',
                    color: Color(Config.yellowColor)),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    size: 30,
                    color: Color(Config.yellowColor),
                  ))
            ],
          ),
          content: Container(
            height: 300,
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 170,
                      height: 30,
                      child: TextFormField(
                        controller: customerData.customerName,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          fillColor: Color(Config.yellowColor),
                          filled: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      'Phone',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo_Regular',
                          color: Color(Config.yellowColor)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 170,
                      height: 30,
                      child: TextFormField(
                        controller: customerData.phone_number,
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
                    onPressed: () {
                      print('post');
                      Navigator.of(context, rootNavigator: true).pop();
                      showLoadingDialog(scaffold.currentContext!);
                      customerData.updateCustomer(() {
                        callback();
                      });
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          fontFamily: 'Cairo_Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color(Config.yellowColor))),
                  ),
                )
              ],
            ),
          ),
        );
      });
  return null;
}
