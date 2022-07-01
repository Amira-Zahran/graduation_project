import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/main.dart';
import 'package:untitled6/src/Controllers/API.dart';
import 'package:untitled6/src/Models/User.dart';
import 'package:untitled6/src/Models/Item.dart';
import 'package:untitled6/src/Models/Category.dart';
import 'package:untitled6/src/Models/Order.dart';



class BLoC{

  late Timer _timer;

  User user = User();

  List<Order> _orders = [];

  List<Category> categories = [];

  final _ordersSubject = new BehaviorSubject<UnmodifiableListView<Order>>();

  Stream<UnmodifiableListView<Order>> get Orders => _ordersSubject.stream;
  final _categoriesSubject = new BehaviorSubject<UnmodifiableListView<Category>>();

  Stream<UnmodifiableListView<Category>> get Categories => _categoriesSubject.stream;

  Future<Null> getCategories() async{
    Response response = await get(Uri.parse(API.MenuRoute),headers: {"Authorization": "Bearer ${user.token}"});
    // print(response.body);
    if(response.statusCode == 200) {
      List data = json.decode(response.body)['categories'];
      print(data);
      categories = [];
      categories.add(Category(id: 0, category_title: 'All', category_icon: ''));
      categories.add(Category(id: -1, category_title: 'OverTime', category_icon: ''));
      data.map((e) => categories.add(Category.fromJson(e)))
          .toList();

      _categoriesSubject.add(UnmodifiableListView(categories));
    }
  }

  Future<Null> getOrders() async{
    Response response = await post(Uri.parse(API.getKitchenOrders),
        headers: {
          "Authorization":
          "Bearer ${user.token}"
        }
    );
    // print(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    _orders = (data['orders'] as List).map((e) => Order.fromJson(e)).toList();
    _ordersSubject.add(UnmodifiableListView(_orders));
  }

  Future<Null> updateItemStatus(id) async{
    await post(Uri.parse(API.updateItemStatus),
        headers: {
          "Authorization":
          "Bearer ${user.token}"
        },
        body: {
          'id' : id.toString(),
          'status': 'Prepared'
        }
    );
    this.getOrders();
  }

  Future<Null> updateStatus(id,status) async{
    Response response = await post(Uri.parse(API.updateStatus),
        headers: {
          "Authorization":
          "Bearer ${user.token}"
        },
        body: {
          'id' : id.toString(),
          'status': status
        }
    );
    print(response.body);
    this.getOrders();
  }

  Future<Null> login(context,{username, password}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = prefs.getString('user')!;
    print(userData);
    Map<String, dynamic> data = json.decode(userData);
    user = User.fromJson(data);
    afterLogin();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });

  }

  afterLogin(){
    getOrders();
    getCategories();
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      getOrders();
    });

  }

}