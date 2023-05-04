import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/views/rpm_view/readings/modalities_reading.dart';

import 'auth_services/auth_services.dart';

class NotificationService{
  ProviderReference? _ref;
  AuthServices? _authServices;
  ApplicationRouteService? _applicationRouteService;

  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance ;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationService({ProviderReference? ref}){
    _ref = ref;
    // initService();
  }
  // initService(){
  //   requestNotificationPermission();
  //   forgroundMessage();
  //   firebaseInit();
  //   setupInteractMessage();
  //   _authServices = _ref!.read(authServiceProvider);
  //   _applicationRouteService = _ref!.read(applicationRouteServiceProvider);
  // }
  //
  // //function to initialise flutter local notification plugin to show notifications for android when app is active
  // void initLocalNotifications(RemoteMessage message)async{
  //   var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var iosInitializationSettings = const IOSInitializationSettings();
  //
  //   var initializationSetting = InitializationSettings(
  //       android: androidInitializationSettings ,
  //       iOS: iosInitializationSettings
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.initialize(
  //       initializationSetting,
  //       onSelectNotification: (payload){
  //         // handle interaction when app is active for android
  //         handleMessage(message);
  //       }
  //   );
  // }
  //
  //
  // void firebaseInit(){
  //
  //   FirebaseMessaging.onMessage.listen((message) {
  //
  //     RemoteNotification? notification = message.notification ;
  //     AndroidNotification? android = message.notification!.android ;
  //
  //     if (kDebugMode) {
  //       print("notifications title:${notification!.title}");
  //       print("notifications body:${notification.body}");
  //       print('count:${android!.count}');
  //       print('data:${message.data.toString()}');
  //     }
  //
  //     if(Platform.isIOS){
  //       forgroundMessage();
  //     }
  //
  //     if(Platform.isAndroid){
  //       initLocalNotifications(message);
  //       showNotification(message);
  //     }
  //   });
  // }
  //
  // void requestNotificationPermission() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: true,
  //     badge: true,
  //     carPlay: true,
  //     criticalAlert: true,
  //     provisional: true,
  //     sound: true ,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     if (kDebugMode) {
  //       print('user granted permission');
  //     }
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     if (kDebugMode) {
  //       print('user granted provisional permission');
  //     }
  //   } else {
  //     //appsetting.AppSettings.openNotificationSettings();
  //     if (kDebugMode) {
  //       print('user denied permission');
  //     }
  //   }
  // }
  //
  // // function to show visible notification when app is active
  // Future<void> showNotification(RemoteMessage message)async{
  //
  //   AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     message.notification!.android!.channelId.toString(),
  //     message.notification!.android!.channelId.toString() ,
  //     importance: Importance.max  ,
  //     showBadge: true ,
  //   );
  //
  //   AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
  //     channel.id.toString(),
  //     channel.name.toString() ,
  //     channelDescription: 'your channel description',
  //     importance: Importance.high,
  //     priority: Priority.high ,
  //     ticker: 'ticker' ,
  //     //  icon: largeIconPath
  //   );
  //
  //   const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
  //       presentAlert: true ,
  //       presentBadge: true ,
  //       presentSound: true
  //   ) ;
  //
  //   NotificationDetails notificationDetails = NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: iosNotificationDetails
  //   );
  //
  //   Future.delayed(Duration.zero , (){
  //     _flutterLocalNotificationsPlugin.show(
  //         0,
  //         message.notification!.title.toString(),
  //         message.notification!.body.toString(),
  //         notificationDetails);
  //   });
  // }
  //
  //
  // //handle tap on notification when app is in background or terminated
  // Future<void> setupInteractMessage()async{
  //
  //   // when app is terminated
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  //
  //   if(initialMessage != null){
  //     handleMessage(initialMessage);
  //   }
  //
  //
  //   //when app ins background
  //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //     handleMessage(event);
  //   });
  //
  // }
  //
  //
  //
  //
  //
  // void handleMessage( RemoteMessage message) {
  //   if(message.data['type'] =='msj'){
  //     // Navigator.push(context,
  //     //     MaterialPageRoute(builder: (context) => MessageScreen(
  //     //       id: message.data['id'] ,
  //     //     )));
  //   }
  // }
  //
  // Future forgroundMessage() async {
  //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }
}