import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMHelper {

  FCMHelper._();

  factory FCMHelper() => _instance;

  static final FCMHelper _instance = FCMHelper._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  Future<void> init() async {
    // For iOS request permission first.
    RemoteMessage? initialMessage =
    await _firebaseMessaging.getInitialMessage();
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      debugPrint('onMessage: ${event.data}');
      debugPrint(event.data['omar']);
    });
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      debugPrint('onMessageOpenedApp: ${event.notification!.title}');
    });

    // For testing purposes print the Firebase Messaging token
    String? token = await _firebaseMessaging.getToken();
    print(token!);


  }

  getToken() async{
    String? token = await _firebaseMessaging.getToken();
    // print(token!);
    return token!;
  }
  // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   print("Handling a background message");
  // }

// ignore: missing_return

}