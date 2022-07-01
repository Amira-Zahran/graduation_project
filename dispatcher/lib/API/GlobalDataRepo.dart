import 'package:flutter/material.dart';
import 'BloC.dart';
import 'orderModel.dart';


ValueNotifier vl  = ValueNotifier<bool>(true);
ValueNotifier SearchValue  = ValueNotifier<String>('');

TextEditingController SearchController = new TextEditingController();
BLoC bLoC = BLoC();
Orders currentOrder = Orders(id: 0);