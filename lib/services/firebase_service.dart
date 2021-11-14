import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/readings/modalities_reading.dart';

class FirebaseService{
  ProviderReference? _ref;
  FirebaseMessaging? firebaseMessaging;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'HighNotifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true,
      showBadge: true,

  );

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
    // firebaseMessaging.
    // NotificationSettings notificationSettings = await firebaseMessaging!.getNotificationSettings();
    // var requestPermission = firebaseMessaging!.requestPermission(
    //   alert: true,
    //   announcement: true,
    //   badge: true,
    //   carPlay: true,
    //   criticalAlert: true,
    //   provisional: true,
    //   sound: true,
    // );


    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await firebaseMessaging!.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      firebaseMessaging!
          .getToken()
          .then((value) => print("this is mobile token ${value.toString()}"));
    }
    else {
      firebaseMessaging!.requestPermission();
      String? apnsToken = await firebaseMessaging!.getAPNSToken();
      firebaseMessaging!
          .getToken()
          .then((value) => print("this is mobile token ${value.toString()}"));
    }
    _subNotification();


  }


  _subNotification() async {
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((event) {
      Navigator.pushAndRemoveUntil(
        applicationContext!.currentContext!,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              Home(),
        ),
            (route) => false,
      );
      Navigator.push(applicationContext!.currentContext!, PageTransition(
          child: ModalitiesReading(), type: PageTransitionType.fade));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.push(applicationContext!.currentContext!, PageTransition(
          child: ModalitiesReading(), type: PageTransitionType.topToBottom));
    });

    print("///////////////  weather ///////////////////");
    LoginVM result = _ref!.read(loginVMProvider);
    if (result.currentUser != null) {
      await firebaseMessaging!
          .subscribeToTopic("${result.currentUser?.appUserId}-NewDataReceived")
          .then((value) => print("weather topic subscribe"));
    }

    //
    // FirebaseMessaging.onMessage.listen(_onMessage);
    //
    // FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    // // firebaseMessaging.on
    //
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  }

  _onMessage(RemoteMessage message) async {
    print('Handling a _onMessage message ${message.messageId}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    // stop notifications on Foreground
    // return;
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
  }

  _onMessageOpenedApp(RemoteMessage message){
    print("data  = ${message.data}");
    print('Handling a _onMessageOpenedApp message ${message.messageId??""}');
    print('A new onMessageOpenedApp event was published!');
    Navigator.push(applicationContext!.currentContext!, PageTransition(
        child: ModalitiesReading(), type: PageTransitionType.topToBottom));
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
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    // _subNotification();
    print('Handling a background message ${message.messageId}');
    Navigator.push(applicationContext!.currentContext!, PageTransition(
        child: ModalitiesReading(), type: PageTransitionType.topToBottom));
  }


}