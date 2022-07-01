import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:delivery/src/Controllers/API_HEPLER.dart';
import 'package:delivery/src/Controllers/FCM.dart';
import 'package:delivery/src/Models/Order.dart';
import 'package:delivery/src/Models/User.dart';
import 'package:delivery/src/Pages/login_confirmation.dart';
import 'package:delivery/src/Pages/mainpage.dart';
import 'package:delivery/src/Pages/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BLoC {

  List<Order> orders = [];
  List<Order> ordersHistory = [];

  final _OrdersSubject = new BehaviorSubject<UnmodifiableListView<Order>>();
  final _ordersHistorySubject = new BehaviorSubject<UnmodifiableListView<Order>>();

  Stream<UnmodifiableListView<Order>> get Orders => _OrdersSubject.stream;
  Stream<UnmodifiableListView<Order>> get OrdersHistory => _ordersHistorySubject.stream;

  User user = User();

  Future<Null> login(context, {String? phone, String? id}) async {
    print('called');
    Response response = await post(Uri.parse(API.login),
        body: {"phone_number": phone, "id": id});
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => login_confirmation(
                  otp_request_id:
                      (json.decode(response.body))['otp_request_id'],
                  id: id!)));
    }
  }

  Future<Null> validateOTP(context, {String? otp, String? req_id,String? id}) async {
    print('called');
    Response response = await post(Uri.parse(API.otpValidate),
        body: {"otp": otp, "req_id": req_id,"id":id,"firebase_token":(await FCMHelper().getToken())});
    if (response.statusCode == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("user", response.body);
      user = User.fromJson(json.decode(response.body));
      afterLogin();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => mainpage()));
    }
  }

  RetriveUserFromStorage(context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString("user") != null && preferences.getString("user")!.isNotEmpty){
      user = User.fromJson(json.decode(preferences.getString("user")!));
      // preferences.remove("user");
      print("dattt" + user.name!);
      afterLogin();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => mainpage()));
    }
  }

  getOrders() async{
    Response response = await post(Uri.parse(API.Orders),headers: {
      "Authorization":
      "Bearer ${user.token}"
    },body: {"firebase_token":(await FCMHelper().getToken())});
   List<dynamic> data = json.decode(response.body)['orders'];
   orders = data.map((e) => Order.fromJson(e)).toList();
   _OrdersSubject.add(UnmodifiableListView(orders));
  }

  getHistory() async{
    Response response = await post(Uri.parse(API.History),headers: {
      "Authorization":
      "Bearer ${user.token}"
    },body: {"firebase_token":(await FCMHelper().getToken())});
   List<dynamic> data = json.decode(response.body)['orders'];
   ordersHistory = data.map((e) => Order.fromJson(e)).toList();
   _ordersHistorySubject.add(UnmodifiableListView(ordersHistory));
  }

  updateOPStatus({String? id, String? status}) async{
    Response response = await post(Uri.parse(API.updatedStatus),headers: {
      "Authorization":
      "Bearer ${user.token}"
    },body: {"id": id, "status": status});
    print(response.body);
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

  afterLogin(){
    Timer.periodic(Duration(seconds: 5), (timer) {
      getOrders();
      getHistory();
    });
  }
}
