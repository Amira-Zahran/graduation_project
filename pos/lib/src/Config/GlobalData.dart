import 'package:flutter/material.dart';
import 'package:pos/src/Config/BLoC.dart';
import 'package:pos/src/Config/BriaController.dart';
import 'package:pos/src/Config/Imports.dart';
import 'package:pos/src/Repos/OrderDataRepo.dart';

BLoC bLoC = new BLoC();

CustomerData customerData = new CustomerData();

OrderDataRepo orderDataRepo = new OrderDataRepo();

BriaController briaController = new BriaController();

GlobalKey<ScaffoldState> scaffold = new GlobalKey<ScaffoldState>();
GlobalKey<ScaffoldState> scaffold2 = new GlobalKey<ScaffoldState>();

