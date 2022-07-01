import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win32/win32.dart';

import 'api_helper.dart';

class BLoC{


  Future<Null> login({String? username,String? Password}) async{

    Response response = await post(Uri.parse(API.login),body: {'email':username,'password':Password});
    print(response.body);
    Map<String, dynamic> data = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", response.body);
    // print(prefs.get('user'));
    switch(data['type']){
      case 'CallCenterAgent':
      case"Cashier":
        print(prefs.get('user'));
        Future.delayed(Duration(seconds: 1), () {
          ShellExecute(NULL, TEXT('open'), TEXT('.\\software\\pos\\pos.exe'), nullptr, TEXT(''), SW_SHOW);
          exit(0);
        });
        break;
      case "Dispatcher":
        print(prefs.get('user'));
        Future.delayed(Duration(seconds: 1), () {
          ShellExecute(NULL, TEXT('open'), TEXT('.\\software\\dispatcher\\pos.exe'), nullptr, TEXT(''), SW_SHOW);
          exit(0);
        });
        break;
      case "User":
        if(data['permissions'].toString().contains('counter')){
          print(prefs.get('user'));
          Future.delayed(Duration(seconds: 1), () {
            ShellExecute(NULL, TEXT('open'), TEXT('.\\software\\counter\\pos.exe'), nullptr, TEXT(''), SW_SHOW);
            exit(0);
          });
        }else if(data['permissions'].toString().contains('kitchen')){
          print(prefs.get('user'));
          Future.delayed(Duration(seconds: 1), () {
            ShellExecute(NULL, TEXT('open'), TEXT('.\\software\\kitchen\\pos.exe'), nullptr, TEXT(''), SW_SHOW);
            exit(0);
          });
        }
        break;
      default:
        showMessageBox(title: 'Error', message: 'Invalid User Type',type: 'error');
    }
  }



  showMessageBox({String? title,String? message,String? type}){

    int msgboxID = MessageBox(
        FindWindow(nullptr,TEXT("pos")),
        TEXT(message!),
        TEXT(title!),
        type == 'error'
            ? MB_ICONERROR
            : MB_ICONINFORMATION | // Warning
        MB_OK // Second button is the default
    );

    if (msgboxID == MB_OK) {}

    return msgboxID;
  }
  // BLoC(){
  //   setSettings();
  // }

}