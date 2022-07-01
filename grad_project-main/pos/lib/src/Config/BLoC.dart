import 'dart:async';

import 'package:flutter/material.dart' hide MenuItem;
import 'package:pos/main.dart';
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Models/HistoryOrder.dart';
import 'package:pos/src/Models/OrderItem.dart';


class BLoC{

  User user = User();

  late Timer _time;

  List<Category> _menuCategory = [];
  List<MenuItem> _menuItem = [];
  List<HistoryOrder> _historyOrders = [];

  List<MenuItem> get menuItem => _menuItem;

  final _MenuCategory = new BehaviorSubject<UnmodifiableListView<Category>>();
  final _HistoryOrdersSubject = new BehaviorSubject<UnmodifiableListView<HistoryOrder>>();
  final _MenuItem = new BehaviorSubject<UnmodifiableListView<MenuItem>>();

  Stream<UnmodifiableListView<Category>> get MenuCategory => _MenuCategory.stream;
  Stream<UnmodifiableListView<HistoryOrder>> get History => _HistoryOrdersSubject.stream;
  Stream<UnmodifiableListView<MenuItem>> get MenuItems => _MenuItem.stream;

  Future<Null> getMenu() async{
    // MenuItem(item_name: 'fai')
    Response response = await get(Uri.parse(API.MenuRoute), headers: {
      "Authorization":
          "Bearer ${user.token}"
    });
    // print(response.body);
    Map<String, dynamic> data = json.decode(response.body);

    _menuCategory = (data['categories'] as List).map((e) => Category.fromJson(e)).toList();

    // _menuCategory = (data['categories'] as List).map((e) => Category.fromJson(e)).toList();
    _menuItem = (data['items'] as List).map((e) => MenuItem.fromJson(e)).toList();

    _MenuCategory.add(UnmodifiableListView(_menuCategory));
    _MenuItem.add(UnmodifiableListView(_menuItem));

  }

  Future<Null> login(username, password) async{
    Response response = await post(Uri.parse(API.login),body: {'email':username,'password':password});
    // print(response.request);
    print(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    user = User.fromJson(data);
    if(user.type == 'CallCenterAgent'){
      orderDataRepo.type = 'Delivery';
    }
    afterLogin();
    runApp(const MyApp());
  }

  Future<Null> getHistory() async{
    Response response = await post(Uri.parse(API.history),
      headers: {
        "Authorization":
        "Bearer ${user.token}"
      }
    );
    Map<String,dynamic> data = json.decode(response.body);
    _historyOrders = (data['orders'] as List).map((e) => HistoryOrder.fromJson(e)).toList();
    _HistoryOrdersSubject.add(UnmodifiableListView(_historyOrders));
  }

  Future<int> getOrder(int? OrderID) async {
    customerData.clear();
    orderDataRepo.clear();
    Response response = await post(Uri.parse(API.getOrder),
        body: {'id': OrderID.toString()},
        headers: {"Authorization": "Bearer ${user.token}"});
    print(response.body);
    Map<String, dynamic> data = json.decode(response.body);

    data['customer'] != null
        ? customerData.updateData(Customer.fromJson(data['customer']))
        : null;

    data['customer'] != null
        ? customerData.selectedAddress = customerData.customerData.addresses!
        .firstWhere((element) => element.id == data['address'])
        : null;

    orderDataRepo.type = data['type'];

    data['items'].map((e) {
      OrderItem item = OrderItem.fromJson(e);
      item.item_photo =
          _menuItem.firstWhere((element) => element.id == item.item_id).item_photo;
      item.item_name =  _menuItem.firstWhere((element) => element.id == item.item_id).item_name;
      orderDataRepo.items.add(item);
    }).toList();
    orderDataRepo.isEditing = true;
    orderDataRepo.order_id = data['id'];
    return 1;
  }

  // void printRecipt(int id) async{
  //   Response response = await post(Uri.parse(API.printReceipt),
  //       body: {'id': id.toString()},
  //       headers: {"Authorization": "Bearer ${user.token}"});
  //   print(response.body);
  // }

  afterLogin(){
    getMenu();
    getHistory();
    _time = Timer.periodic(Duration(seconds: 5), (timer) {
      getMenu();
      getHistory();
    });
  }

}