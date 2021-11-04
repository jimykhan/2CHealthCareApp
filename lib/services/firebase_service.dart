import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';

class FirebaseService{
  ProviderReference? _ref;
  FirebaseMessaging? firebaseMessaging;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  FirebaseService({ProviderReference? ref}){
    _ref = ref;
    initFirebase();
  }

  initFirebase(){
    print("try calling firebase initialzeApp");
    Firebase.initializeApp().whenComplete(() => print("firebase completed..."));
    Firebase.apps.forEach((element) {

    });
  }

  initNotification() async {
    firebaseMessaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await firebaseMessaging!.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    else {
      firebaseMessaging!.requestPermission();
    }
    _subNotification();
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    _subNotification();
    print('Handling a background message ${message.messageId}');
  }

  _subNotification() async {
    if (Platform.isAndroid) {
      firebaseMessaging!
          .getToken()
          .then((value) => print("this is mobile token ${value.toString()}"));
    }
    else {
      String? apnsToken = await firebaseMessaging!.getAPNSToken();
      firebaseMessaging!
          .getToken()
          .then((value) => print("this is mobile token ${value.toString()}"));
    }
    print("///////////////  weather ///////////////////");
    // await firebaseMessaging
    //     .subscribeToTopic("weather")
    //     .then((value) => print("weather topic subscribe"));
    LoginVM result = _ref!.read(loginVMProvider);
    if (result.currentUser != null) {
      // bool isValidTopic = RegExp(r'^[a-zA-Z0-9-_.~%]{1,900}$').hasMatch();
      await firebaseMessaging!
          .subscribeToTopic("${result.currentUser?.appUserId}-NewDataReceived")
          .then((value) => print("weather topic subscribe"));
      // await firebaseMessaging
      //     .subscribeToTopic("${result.currentUser.appUserId}-NewMsgReceived")
      //     .then((value) => print("weather topic subscribe"));
    }
    // deviceService?.currentUser?.appUserId
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // stop notifications on Foreground
      return;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription:channel.description,
                color: Colors.blue,
                playSound: true,
                icon: 'ic_launcher',
                largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
              ),
            ));
      }
      else {
        await firebaseMessaging!.getAPNSToken();
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification?.title??"",
            notification?.body??"",
            const NotificationDetails(
              iOS: IOSNotificationDetails(
                // this.presentAlert,
                // this.presentBadge,
                // this.presentSound,
                // this.sound,
                // this.badgeNumber,
                // this.attachments,
                // this.subtitle,
                // this.threadIdentifier,
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("this is notification body = ${message.toString()}");
      if (notification != null && android != null) {
        showDialog(
            context: applicationContext!.currentContext!,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title??""),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body??"")],
                  ),
                ),
              );
            });
      }
    });
  }
}