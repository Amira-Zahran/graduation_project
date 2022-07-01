import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:untitled6/main.dart';
import 'package:untitled6/src/Controllers/API.dart';
import 'package:untitled6/src/Models/Order.dart';
import 'package:untitled6/src/Models/User.dart';

class BLoC{

  late Timer _timer;

  User user = User();

  List<Order> _orders = [];
  
  final _ordersSubject = new BehaviorSubject<UnmodifiableListView<Order>>();
  
  Stream<UnmodifiableListView<Order>> get Orders => _ordersSubject.stream;
  
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

  Future<Null> login(username, password) async{
    Response response = await post(Uri.parse(API.login),body: {'email':username,'password':password});
    // print(response.request);
    print(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    user = User.fromJson(data);
    afterLogin();
    runApp(const MyApp());
  }

  afterLogin(){
    getOrders();

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      getOrders();
    });

  }

}