import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/local_notification_service.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/chat/chat_list.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/readings/modalities_reading.dart';

class FirebaseService{
  ProviderReference? _ref;
  FirebaseMessaging? firebaseMessaging;
  LoginVM? result;
  LocalNotificationService? localNotificationService;
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
     firebaseMessaging!.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
     localNotificationService = _ref!.read(localNotificationServiceProvider);
     // localNotificationService!.initLocalNoticationChannel();

    if (Platform.isAndroid) {
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

    FirebaseMessaging.onMessage.listen((event) {
      print("this is event${event.notification?.title}");
      if(event.notification?.title == "New Message Received"){

      }
      else{
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
      }

    });
    // FirebaseMessaging.onMessage.listen(localNotificationService!.onMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if(event.notification?.title == "New Message Received"){
        Navigator.pushReplacement(applicationContext!.currentContext!, PageTransition(
            child: ChatList(), type: PageTransitionType.topToBottom));
      }
      else{
        Navigator.pushReplacement(applicationContext!.currentContext!, PageTransition(
            child: ModalitiesReading(), type: PageTransitionType.topToBottom));
      }

    });

    print("///////////////  weather ///////////////////");
    result = _ref!.read(loginVMProvider);
    if (result?.currentUser != null) {
      await firebaseMessaging!
          .subscribeToTopic("${result?.currentUser?.appUserId}-NewDataReceived")
          .then((value) => print("${result?.currentUser?.appUserId}-NewDataReceived weather topic subscribe"));
      await firebaseMessaging!
          .subscribeToTopic("${result?.currentUser?.appUserId}-NewMsgReceived")
          .then((value) => print("${result?.currentUser?.appUserId}-NewMsgReceived weather topic subscribe"));
    }

  }

  // setPushNotification() async {
  //   if (result?.currentUser != null) {
  //     await firebaseMessaging!
  //       .se("${result?.currentUser?.appUserId}-NewDataReceived")
  //       .then((value) => print("${result?.currentUser?.appUserId}-NewDataReceived weather topic subscribe"));
  // }
  // }

  turnOfChatNotification() {
    var firebaseMessaging = FirebaseMessaging.instance;
    if(result?.currentUser!=null){
      firebaseMessaging
          .unsubscribeFromTopic(
          "${result?.currentUser?.appUserId}-NewMsgReceived")
          .then((value) => null);
    }

  }

  turnOfReadingNotification() {

    var firebaseMessaging = FirebaseMessaging.instance;
    if (result?.currentUser != null){
      firebaseMessaging
          .unsubscribeFromTopic(
          "${result?.currentUser?.appUserId}-NewDataReceived")
          .then((value) => print("UnSub Topic${result?.currentUser?.appUserId}-NewDataReceived"));
    }

  }

  turnOnChatNotification() {
    var firebaseMessaging = FirebaseMessaging.instance;
    if (result?.currentUser != null){
      // firebaseMessaging
      //     .unsubscribeFromTopic(
      //     "${result?.currentUser?.appUserId}-NewDataReceived")
      //     .then((value) => null);
    }
  }

  turnOnReadingNotification() {
    var firebaseMessaging = FirebaseMessaging.instance;
    if (result?.currentUser != null){
      firebaseMessaging
          .subscribeToTopic(
          "${result?.currentUser?.appUserId}-NewDataReceived")
          .then((value) => null);
    }
  }






  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    Navigator.push(applicationContext!.currentContext!, PageTransition(
        child: ModalitiesReading(), type: PageTransitionType.topToBottom));
  }


}