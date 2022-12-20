import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void>initInfo() async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
   AndroidInitializationSettings  androidInitialize =  
    AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings  iOSInitialize =IOSInitializationSettings();
  InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitialize,
    iOS: iOSInitialize,);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,);
 }

 Future<void> showNot(var title,var body) async {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
     'SmartFarm', 'แจ้งเตือนทั่วไป',importance: Importance.high,
     ticker: 'ticker',
     priority: Priority.high,playSound: false,);
     
      NotificationDetails platformch = NotificationDetails(android: androidNotificationDetails,
     iOS: IOSNotificationDetails());

       await flutterLocalNotificationsPlugin.show(0, title, body, platformch,
   );

 }
 
