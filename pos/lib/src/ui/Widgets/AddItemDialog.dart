import 'package:flutter/material.dart' hide MenuItem;
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Models/OrderItem.dart';

Widget? addItemDialog({context, MenuItem? menuItem, VoidCallback? callback}){
  TextEditingController quantity = new TextEditingController(text: '1');
  TextEditingController comment = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
  Widget closeButton = TextButton(
    child: Text("Close", style: TextStyle(color: Color(Config.yellowColor)),),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  Widget okButton = TextButton(
    child: Text("Add",style: TextStyle(color: Color(Config.yellowColor)),),
    onPressed: () {
      if (_formKey.currentState!.validate()) {
        orderDataRepo.addItem(callback: (){callback!();},item_id: menuItem?.id,comment: comment.text,item_name: menuItem?.item_name!,item_price: double.parse(menuItem!.item_price!),item_photo: menuItem.item_photo!,item_quantity: int.parse(quantity.text));
        print(orderDataRepo.items);
        print(orderDataRepo.orderTotal);
        print(orderDataRepo.totalTaxes);
        print(menuItem.id);
        // orderDataRepo.createOrder();
        Navigator.of(context, rootNavigator: true).pop();
      }
    },
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {

          return AlertDialog(
            contentTextStyle: TextStyle(color: Color(Config.yellowColor)),
            backgroundColor: Color(Config.darkColor),
            title: Text('Add Item',style: TextStyle(color: Color(Config.yellowColor)),),
            content: Container(
              // width: 715,
              height: 400,
              color: Color(Config.darkColor),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextFormField(
                              controller: quantity,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Color(Config.yellowColor)),
                              // initialValue: 1.toString(),
                              readOnly: true,
                              validator: (Value) {
                                if (Value == '') {
                                  return "من فضلك اكتب الكمية";
                                } else if (int.tryParse(Value!)! < 1) {
                                  return "الكمية لا يمكن ان تكون اقل من واحد";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                suffix: SizedBox(
                                  width: 80,
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        setState(() {
                                          quantity.text = (int.tryParse(quantity.text)! + 1).toString();
                                        });
                                      }, icon: Icon(Icons.add,color: Color(Config.yellowColor),)),
                                      IconButton(onPressed: (){
                                        setState(() {
                                          if(int.tryParse(quantity.text)! > 1){
                                            quantity.text = (int.tryParse(quantity.text)! - 1).toString();
                                          }
                                        });
                                      }, icon: Icon(Icons.remove,color: Color(Config.yellowColor),)),
                                    ],
                                  ),
                                ),
                                isCollapsed: false,
                                labelText: 'Quantity',
                                labelStyle: TextStyle(color: Color(Config.yellowColor)),
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 350,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: comment,
                              style: TextStyle(color: Color(Config.yellowColor)),
                              maxLines: 5,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                isCollapsed: false,
                                labelText: 'comment',
                                labelStyle: TextStyle(color: Color(Config.yellowColor)),
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ),
            actions: [okButton, closeButton],
          );
        },
      );
    },
  );
  return null;

}


Widget? updateItem({context, OrderItem? orderItem, VoidCallback? callback}){
  TextEditingController quantity = new TextEditingController(text: orderItem?.item_quantity.toString());
  TextEditingController comment = new TextEditingController(text: orderItem?.comment);
  var _formKey = GlobalKey<FormState>();
  Widget closeButton = TextButton(
    child: Text("Close", style: TextStyle(color: Color(Config.yellowColor)),),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  Widget okButton = TextButton(
    child: Text("update",style: TextStyle(color: Color(Config.yellowColor)),),
    onPressed: () {
      if (_formKey.currentState!.validate()) {
        orderDataRepo.updateItem(
            item_quantity: int.parse(quantity.text.toString()),
            item_photo: orderItem?.item_photo,
            item_name: orderItem?.item_name,
            comment: comment.text,
            callback: () { callback!(); },
            id: orderItem?.id,
            item_price: orderItem?.item_price);
        Navigator.of(context, rootNavigator: true).pop();
      }
    },
  );

  Widget removeButton = TextButton(
    child: Text("remove",style: TextStyle(color: Colors.red),),
    onPressed: () {
      if (_formKey.currentState!.validate()) {
        orderDataRepo.removeItem(orderItem, (){callback!();});
        Navigator.of(context, rootNavigator: true).pop();
      }
    },
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {

          return AlertDialog(
            contentTextStyle: TextStyle(color: Color(Config.yellowColor)),
            backgroundColor: Color(Config.darkColor),
            title: Text('Add Item',style: TextStyle(color: Color(Config.yellowColor)),),
            content: Container(
              // width: 715,
              height: 400,
              color: Color(Config.darkColor),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextFormField(
                              controller: quantity,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Color(Config.yellowColor)),
                              readOnly: true,
                              validator: (Value) {
                                if (Value == '') {
                                  return "من فضلك اكتب الكمية";
                                } else if (int.tryParse(Value!)! < 1) {
                                  return "الكمية لا يمكن ان تكون اقل من واحد";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                isCollapsed: false,
                                suffix: SizedBox(
                                  width: 80,
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        setState(() {
                                          quantity.text = (int.tryParse(quantity.text)! + 1).toString();
                                        });
                                      }, icon: Icon(Icons.add,color: Color(Config.yellowColor),)),
                                      IconButton(onPressed: (){
                                        setState(() {
                                          if(int.tryParse(quantity.text)! > 1){
                                            quantity.text = (int.tryParse(quantity.text)! - 1).toString();
                                          }
                                        });
                                      }, icon: Icon(Icons.remove,color: Color(Config.yellowColor),)),
                                    ],
                                  ),
                                ),
                                labelText: 'Quantity',
                                labelStyle: TextStyle(color: Color(Config.yellowColor)),
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 350,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: comment,
                              style: TextStyle(color: Color(Config.yellowColor)),
                              maxLines: 5,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                isCollapsed: false,
                                labelText: 'comment',
                                labelStyle: TextStyle(color: Color(Config.yellowColor)),
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            actions: [okButton, removeButton, closeButton],
          );
        },
      );
    },
  );
  return null;

}