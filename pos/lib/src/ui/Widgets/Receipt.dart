import 'package:flutter/material.dart';

import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Models/OrderItem.dart';
import 'package:win32/win32.dart';

import 'AddItemDialog.dart';

class Receipt extends StatefulWidget implements PreferredSizeWidget {
  Receipt({Key? key,required this.callback}) : super(key: key);
  VoidCallback callback;

  @override
  _ReceiptState createState() => _ReceiptState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _ReceiptState extends State<Receipt> {
  ScrollController _items = new ScrollController();

  //take away or delivery botton
  // int receipt=1;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(children: [
          Text(
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo_Regular',
                color: Color(Config.darkColor)),
          ),
          Divider(
            color: Color(Config.darkColor),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: AlignmentDirectional.topStart,
            child: Text(
              'Receipt',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo_Regular',
                  color: Color(Config.darkColor)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: bLoC.user.type == 'CallCenterAgent'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderDataRepo.type = 'DeliveryTakeAway';
                            });
                          },
                          child: Text(
                            'TakeAway',
                            style: TextStyle(
                              color: Color(
                                  orderDataRepo.type == 'DeliveryTakeAway'
                                      ? Config.darkColor
                                      : Config.yellowColor),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo_Regular',
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(
                                orderDataRepo.type == 'DeliveryTakeAway'
                                    ? Config.yellowColor
                                    : Config.darkColor)),
                            elevation: MaterialStateProperty.all(0),
                            // shape: MaterialStateProperty.all(
                            //     RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.all(Radius.circular(15)),
                            //         side: BorderSide(color: Color(Config.yellowColor))
                            //     )
                            // )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderDataRepo.type = 'Delivery';
                            });
                          },
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                              color: Color(orderDataRepo.type == 'Delivery'
                                  ? Config.darkColor
                                  : Config.yellowColor),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo_Regular',
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(
                                orderDataRepo.type == 'Delivery'
                                    ? Config.yellowColor
                                    : Config.darkColor)),
                            elevation: MaterialStateProperty.all(0),
                            // shape: MaterialStateProperty.all(
                            //     RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.all(Radius.circular(15)),
                            //         side: BorderSide(color: Color(Config.yellowColor))
                            //     )
                            // )
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderDataRepo.type = 'Floor';
                            });
                          },
                          child: Text(
                            'Floor',
                            style: TextStyle(
                              color: Color(orderDataRepo.type == 'Floor'
                                  ? Config.darkColor
                                  : Config.yellowColor),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo_Regular',
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(
                                orderDataRepo.type == 'Floor'
                                    ? Config.yellowColor
                                    : Config.darkColor)),
                            elevation: MaterialStateProperty.all(0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              orderDataRepo.type = 'FloorTakeAway';
                            });
                          },
                          child: Text(
                            'TakeAway',
                            style: TextStyle(
                              color: Color(orderDataRepo.type == 'FloorTakeAway'
                                  ? Config.darkColor
                                  : Config.yellowColor),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo_Regular',
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(
                                orderDataRepo.type == 'FloorTakeAway'
                                    ? Config.yellowColor
                                    : Config.darkColor)),
                            elevation: MaterialStateProperty.all(0),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      color: Color(Config.darkColor)),
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Quantity',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      color: Color(Config.darkColor)),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Price',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      color: Color(Config.darkColor)),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 435,
            child: ListView(
              controller: _items,
              children:
                  orderDataRepo.items.map((e) => ReceiptListTile(e)).toList(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width,
            //height: 100,
            child: TextFormField(
              maxLines: 2,
              controller: orderDataRepo.comments,
              decoration: InputDecoration(
                labelText: 'Notes',
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
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Color(Config.darkColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Taxes',
                  style: TextStyle(
                      color: Color(Config.yellowColor),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      fontSize: 16),
                ),
                Text(
                  '${orderDataRepo.Taxes}LE',
                  style: TextStyle(
                      color: Color(Config.yellowColor),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      fontSize: 16),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Color(Config.darkColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                      color: Color(Config.yellowColor),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      fontSize: 16),
                ),
                Text(
                  '${orderDataRepo.totalTaxes}LE',
                  style: TextStyle(
                      color: Color(Config.yellowColor),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      fontSize: 16),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          orderDataRepo.isEditing
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          orderDataRepo.updateOrder(() {
                            setState(() {});
                          });
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Cairo_Regular',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(Config.yellowColor)),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(Config.darkColor)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          showConfirmationBoxBox(title: 'Are you sure ?',
                              message: 'Do you want to delete this order ?',
                              type: 'error') == IDYES ? orderDataRepo.deleteOrder(() {setState(() {
                              });}) : print('no');
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontFamily: 'Cairo_Regular',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(Config.yellowColor)),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(Config.darkColor)),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  width: 130,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      orderDataRepo.createOrder(() {
                        setState(() {});
                        widget.callback();
                      });
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          fontFamily: 'Cairo_Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(Config.yellowColor)),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(Config.darkColor)),
                    ),
                  ))
        ]));
  }

  Widget ReceiptListTile(OrderItem item) {
    return InkWell(
      onTap: () {
        updateItem(
            context: context,
            orderItem: item,
            callback: () {
              setState(() {});
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          //width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Color(Config.yellowColor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  item.item_name!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo_Regular',
                      color: Color(Config.darkColor)),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        setState(() {
                          if (item.item_quantity! - 1 < 1) {
                          } else {
                            orderDataRepo.updateItem(
                                item_quantity: item.item_quantity! - 1,
                                item_photo: item.item_photo,
                                item_name: item.item_name,
                                callback: () {
                                  setState(() {});
                                },
                                id: item.id,
                                item_price: item.item_price);
                          }
                        });
                      });
                    },
                    icon: Icon(Icons.remove),
                    iconSize: 16,
                  ),
                  Text(
                    '${item.item_quantity}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Cairo_Regular'),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        orderDataRepo.updateItem(
                            item_quantity: item.item_quantity! + 1,
                            item_photo: item.item_photo,
                            item_name: item.item_name,
                            callback: () {
                              setState(() {});
                            },
                            id: item.id,
                            item_price: item.item_price);
                      });
                    },
                    icon: Icon(Icons.add),
                    iconSize: 16,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${item.item_total_price}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo_Regular',
                        color: Color(Config.darkColor)),
                  ),
                  // IconButton(onPressed: () {},
                  //   icon: Icon(Icons.edit),
                  //   iconSize: 16,
                  //
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
