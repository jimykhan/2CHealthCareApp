import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
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

class LocalNotificationService{
  ProviderReference? _ref;
  AuthServices? _authServices;
  ApplicationRouteService? _applicationRouteService;
  FirebaseService? firebaseService;
  late AndroidNotificationChannel channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  LocalNotificationService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);
    _applicationRouteService = _ref!.read(applicationRouteServiceProvider);
    firebaseService = _ref!.read(firebaseServiceProvider);
  }
  initLocalNoticationChannel() async {

    if (Platform.isAndroid){
      channel =  const AndroidNotificationChannel(
        'test_1', // id
        'High Importance Notifications', // title
        // 'This channel is used for important notifications.', // description
        importance: Importance.max,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  onMessage(RemoteMessage message) async {
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
              priority: Priority.max,
              importance: Importance.max,

            ),
          ));
    }
    else {
      // await firebaseMessaging!.getAPNSToken();
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification?.title??"",
          notification?.body??"",
           const NotificationDetails(
            iOS: DarwinNotificationDetails(
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

  onMessageOpenedApp(RemoteMessage message){
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
}