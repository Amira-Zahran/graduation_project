import 'dart:math';

import 'package:flutter/cupertino.dart' hide MenuItem;
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Config/Printing.dart';
import 'package:pos/src/Models/OrderItem.dart';

class OrderDataRepo{
  bool ADDRESS = false;
  bool ITEMS = false;
  bool CUSTOMER = false;
  bool isEditing = false;
  TextEditingController comments = new TextEditingController(text: '');
  List<OrderItem> _orderItems = [];
  List<int> _toBeDeleted = [];
  String type = 'Floor';
  int? order_id = 0;

  double _total = 0.0;
  double _totalTaxes = 0.14;

  double get orderTotal => _countTotal();
  double get totalTaxes => _countTotal() + (_countTotal() * _totalTaxes);
  double get Taxes => double.parse((_countTotal() * _totalTaxes).toStringAsPrecision(4));
  List<OrderItem> get items => _orderItems;

  double _countTotal() {
    _total = 0.0;
    _orderItems.map((e) {
      _total = double.parse(
          (e.item_total_price! + _total).toStringAsPrecision(4));
    }).toList();
    return _total;
  }

  addItem({String? item_name, String? item_photo, int? item_id, double? item_price, int? item_quantity, String? comment,required VoidCallback callback}){
    OrderItem orderItem = OrderItem();
    orderItem.item_price = item_price;
    orderItem.item_quantity = item_quantity;
    orderItem.item_photo = item_photo;
    orderItem.item_name = item_name;
    orderItem.comment = comment;
    orderItem.item_id = item_id;
    orderItem.item_total_price = double.parse((item_quantity! * item_price!).toStringAsPrecision(4));
    orderItem.id = Random().nextInt(1000) +
        Random().nextInt(1000) * Random().nextInt(1000);
    _orderItems.add(orderItem);
    callback();
  }

  updateItem({String? comment,required String? item_name,required String? item_photo,required double? item_price,required int? item_quantity,required VoidCallback callback,required int? id}){
    var element = _orderItems[_orderItems.indexWhere((element) => element.id == id)];
    element.item_price = item_price;
    element.item_quantity = item_quantity;
    element.item_photo = item_photo;
    element.item_name = item_name;
    element.item_total_price = double.parse((item_quantity! * item_price!).toStringAsPrecision(4));
    if(comment!=null){
      element.comment = comment;
    }
    callback();
  }

  removeItem(item,VoidCallback callback) {
    _toBeDeleted.add(item.id);
    this._orderItems.removeWhere((element) => element == item);
    callback();
  }

  bool _validate(VoidCallback callback) {
    if(bLoC.user.type == 'CallCenterAgent'){
      if(customerData.selectedAddress?.id != null && customerData.customerData.id != null&& items.length != 0){
        print('true level one');
        return true;
      }
      else{
        CUSTOMER = customerData.selectedAddress?.id != null ? false : true;
        ADDRESS = customerData.selectedAddress != null ? false : true;
        ITEMS = items.length != 0 ? false : true;
        // showMessageBox(title: 'Error',message: 'Complete Missing Order Data',type: 'error');
        return false;
      }
    } else if(bLoC.user.type == 'Cashier'){
      if(_orderItems.length != 0){
        return true;
      } else{
        ITEMS = items.length != 0 ? false : true;
        return false;
      }
    } else {
      return false;
    }
  }

  createOrder(VoidCallback callback) async {
    if(_validate((){callback();})){
      Response response = await post(Uri.parse(API.createOrder),
          headers: {
            "Authorization":
            "Bearer ${bLoC.user.token}"
          },
          body: type.contains('Delivery') ? {
            'customer_id' : customerData.customerData.id.toString(),
            'address' : customerData.selectedAddress!.id.toString(),
            'order_type' : type,
            'branch' : bLoC.user.branch?.id.toString(),
            'order_total' : totalTaxes.toString(),
            'order_sub_total' : orderTotal.toString(),
            'taxes' : (orderTotal*_totalTaxes).toString(),
            'items' : json.encode(_orderItems)

          } :
          {
            'order_type' : type,
            'branch' : bLoC.user.branch?.id.toString(),
            'order_total' : totalTaxes.toString(),
            'order_sub_total' : orderTotal.toString(),
            'taxes' : (orderTotal*_totalTaxes).toString(),
            'items' : json.encode(_orderItems)
          }
      );
      print(response.body);
      Map<String,dynamic> data = json.decode(response.body);
      if(response.statusCode == 200) {
        showMessageBox(title: 'Order Created',
            message: 'Order Created With ID: ${data['order_id']}');
        bLoC.user.type == 'Cashier' ? PrintingServices().printFromURL(url: API.printReceipt,id: data['id'].toString(),printType: PrintType.DEFAULT_PRINTER) : null;
        clear();
        customerData.clear();
        callback();
      } else{
        callback();
        showMessageBox(title: 'Error',message: data['message'],type: 'error');
      }
    }
    else{
      callback();
      showMessageBox(title: 'Error',message: "Please Complete the Missing Order Data: ${ADDRESS ? 'Address' : ''}",type: 'error');
    }
  }

  updateOrder(VoidCallback callback) async {
    if(_validate((){callback();})){
      Response response = await post(Uri.parse(API.updateOrder),
          headers: {
            "Authorization":
            "Bearer ${bLoC.user.token}"
          },
          body: type.contains('Delivery') ? {
            'id' : order_id.toString(),
            'address' : customerData.selectedAddress!.id.toString(),
            'order_type' : type,
            'branch' : bLoC.user.branch?.id.toString(),
            'order_total' : totalTaxes.toString(),
            'order_sub_total' : orderTotal.toString(),
            'taxes' : (orderTotal*_totalTaxes).toString(),
            'items' : json.encode(_orderItems),
            'toBeDeleted' : json.encode(_toBeDeleted)

          } :
          {
            'id' : order_id.toString(),
            'order_type' : type,
            'branch' : bLoC.user.branch?.id.toString(),
            'order_total' : totalTaxes.toString(),
            'order_sub_total' : orderTotal.toString(),
            'taxes' : (orderTotal*_totalTaxes).toString(),
            'items' : json.encode(_orderItems),
            'toBeDeleted' : json.encode(_toBeDeleted)
          }
      );
      print(response.body);
      Map<String,dynamic> data = json.decode(response.body);
      if(response.statusCode == 200) {
        if(data.containsKey('success')) {
          showMessageBox(title: 'Order Updated',
              message: '${data['success']}');
          clear();
          customerData.clear();
          callback();
        }
        else{
          callback();
          showMessageBox(title: 'Error',message: data['error'],type: 'error');
        }
      } else{
        callback();
        showMessageBox(title: 'Error',message: data['error'],type: 'error');
      }
    }
    else{
      callback();
      showMessageBox(title: 'Error',message: "Please Complete the Missing Order Data: ${ADDRESS ? 'Address' : ''}",type: 'error');
    }
  }

  deleteOrder(VoidCallback callback) async {

    if(_validate((){callback();})){
      Response response = await post(Uri.parse(API.deleteOrder),
          headers: {
            "Authorization":
            "Bearer ${bLoC.user.token}"
          },
          body: {
        'id' : order_id.toString(),
          }
      );
      print(order_id.toString());
      print(response.body);
      Map<String,dynamic> data = json.decode(response.body);
      if(response.statusCode == 200) {
        showMessageBox(title: 'Order Deleted',
            message: 'Order Deleted With ID: ${data['order_id']}');
        clear();
        customerData.clear();
        callback();
      } else{
        callback();
        showMessageBox(title: 'Error',message: data['message'],type: 'error');
      }
    }
    else{
      callback();
      showMessageBox(title: 'Error',message: "Please Complete the Missing Order Data: ${ADDRESS ? 'Address' : ''}",type: 'error');
    }
  }

  void clear() {
    _orderItems.clear();
    _total = 0.0;
    customerData.clear();
    ADDRESS = false;
    CUSTOMER = false;
    ITEMS = false;
    isEditing = false;
    order_id = 0;
    _toBeDeleted.clear();
  }

}