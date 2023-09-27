import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/local_notification_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/views/rpm_view/readings/modalities_reading.dart';

class FirebaseService {
  ProviderReference? _ref;
  FirebaseMessaging? _firebaseMessaging;
  SharedPrefServices? sharedPrefServices;

  // LocalNotificationService? _localNotificationService;
  // OnLaunchActivityAndRoutesService? _onLaunchActivityService;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // ApplicationRouteService? applicationRouteService;

  FirebaseService({ProviderReference? ref}) {
    _ref = ref;
    initService();
  }
  initService() {
    // applicationRouteService = _ref?.read(applicationRouteServiceProvider);
    initNotification();
    sharedPrefServices = _ref!.read(sharedPrefServiceProvider);
  }

  // initFirebase(){
  //   print("try calling firebase initialzeApp");
  //   Firebase.initializeApp().whenComplete(() {
  //     print("firebase completed...");
  //   } );
  // }

  initNotification() async {
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging!.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    // _localNotificationService = _ref!.read(localNotificationServiceProvider);
    // localNotificationService!.initLocalNoticationChannel();

    if (Platform.isIOS) {
      _firebaseMessaging!.requestPermission();
      String? apnsToken = await _firebaseMessaging!.getAPNSToken();
      _firebaseMessaging!
          .getToken()
          .then((value) => print("this is mobile token ${value.toString()}"));
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else {
      _firebaseMessaging!
          .getToken()
          .then((value) => print("this is mobile token ${value.toString()}"));
      if (!kIsWeb) {
        var channel = const AndroidNotificationChannel(
          '2C_Health', // id
          'High Importance Notifications', // title
          description:
              'This channel is used for important notifications.', // description
          importance: Importance.max,
          enableLights: true,
        );

        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
      }
    }
    // _subNotification();
  }

  subNotification() async {
    FirebaseMessaging.onMessage.listen((event) {
      print("this is event${event.notification?.title}");

      // // _onLaunchActivityService?.syncLastApplicationUseDateAndTime();
      // if(event.notification?.title == "New Message Received"){
      //   // Navigator.pushAndRemoveUntil(
      //   //   applicationContext!.currentContext!,
      //   //   MaterialPageRoute(
      //   //     builder: (BuildContext context) =>
      //   //         Home(),
      //   //   ),
      //   //       (route) => false,
      //   // );
      //   // Navigator.push(applicationContext!.currentContext!, PageTransition(
      //   //     child: ChatList(), type: PageTransitionType.fade));
      // }
      // else{
      //   Navigator.pushAndRemoveUntil(
      //     applicationContext!.currentContext!,
      //     MaterialPageRoute(
      //       builder: (BuildContext context) =>
      //           Home(),
      //     ),
      //         (route) => false,
      //   );
      //   Navigator.push(applicationContext!.currentContext!, PageTransition(
      //       child: ModalitiesReading(), type: PageTransitionType.fade));
      // }
    });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   print("OnMessageOpenedApp call");
    //   if(event.notification?.title == "New Message Received"){
    //     Navigator.pushAndRemoveUntil(
    //       applicationContext!.currentContext!,
    //       MaterialPageRoute(
    //         builder: (BuildContext context) =>
    //             Home(),
    //       ),
    //           (route) => false,
    //     );
    //     applicationRouteService?.addAndRemoveScreen(
    //         screenName: "ChatList");
    //     Navigator.push(applicationContext!.currentContext!, PageTransition(
    //         child: ChatList(), type: PageTransitionType.fade));
    //   }
    //   else{
    //     Navigator.pushAndRemoveUntil(
    //       applicationContext!.currentContext!,
    //       MaterialPageRoute(
    //         builder: (BuildContext context) =>
    //             Home(),
    //       ),
    //           (route) => false,
    //     );
    //     Navigator.push(applicationContext!.currentContext!, PageTransition(
    //         child: ModalitiesReading(), type: PageTransitionType.fade));
    //   }
    // });
    print("///////////////  weather ///////////////////");
    CurrentUser? currentUser = await sharedPrefServices?.getCurrentUser();
    if (currentUser != null) {
      await _firebaseMessaging!
          .subscribeToTopic("${currentUser.appUserId}$dataChannel")
          .then((value) => print(
              "${currentUser.appUserId}$dataChannel dataChannel topic subscribe"));
      await _firebaseMessaging!
          .subscribeToTopic("${currentUser.appUserId}$messageChannel")
          .then((value) => print(
              "${currentUser.appUserId}$messageChannel messageChannel topic subscribe"));
    }
  }

  turnOfChatNotification() async {
    try {
      CurrentUser? currentUser = await sharedPrefServices?.getCurrentUser();
      var firebaseMessaging = FirebaseMessaging.instance;
      if (currentUser != null) {
        await firebaseMessaging
            .unsubscribeFromTopic("${currentUser.appUserId}$messageChannel")
            .then((value) => print(
                "Unsubscribe From Topic ${currentUser.appUserId}$messageChannel"));
      }
    } catch (e) {
      print("");
    }
  }

  turnOfReadingNotification() async {
    try {
      CurrentUser? currentUser = await sharedPrefServices?.getCurrentUser();
      var firebaseMessaging = FirebaseMessaging.instance;
      if (currentUser != null) {
        await firebaseMessaging
            .unsubscribeFromTopic("${currentUser.appUserId}$dataChannel")
            .then((value) =>
                print("UnSub Topic${currentUser.appUserId}$dataChannel"));
      }
    } catch (e) {
      print("");
    }
  }

  turnOnChatNotification() async {
    CurrentUser? currentUser = await sharedPrefServices?.getCurrentUser();
    var firebaseMessaging = FirebaseMessaging.instance;
    if (currentUser != null) {
      // firebaseMessaging
      //     .unsubscribeFromTopic(
      //     "${currentUser.appUserId}$messageChannel")
      //     .then((value) => null);
    }
  }

  turnOnReadingNotification() async {
    CurrentUser? currentUser = await sharedPrefServices?.getCurrentUser();
    var firebaseMessaging = FirebaseMessaging.instance;
    if (currentUser != null) {
      firebaseMessaging
          .subscribeToTopic("${currentUser.appUserId}$dataChannel")
          .then((value) => null);
    }
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    Navigator.push(
        applicationContext!.currentContext!,
        PageTransition(
            child: ModalitiesReading(), type: PageTransitionType.topToBottom));
  }

  // Future<void> setupInteractedMessage() async {
  //   // Get any messages which caused the application to open from
  //   // a terminated state.
  //   RemoteMessage? initialMessage =
  //   await FirebaseMessaging.instance.getInitialMessage();
  //
  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }
  //
  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  // }
  //
  // void _handleMessage(RemoteMessage event) {
  //   print("OnMessageOpenedApp call");
  //   if(event.notification?.title == "New Message Received"){
  //     Navigator.pushAndRemoveUntil(
  //       applicationContext!.currentContext!,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) =>
  //             Home(),
  //       ),
  //           (route) => false,
  //     );
  //     applicationRouteService?.addAndRemoveScreen(
  //         screenName: "ChatList");
  //     Navigator.push(applicationContext!.currentContext!, PageTransition(
  //         child: ChatList(), type: PageTransitionType.fade));
  //
  //   }
  //   else{
  //     Navigator.pushAndRemoveUntil(
  //       applicationContext!.currentContext!,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) =>
  //             Home(),
  //       ),
  //           (route) => false,
  //     );
  //     Navigator.push(applicationContext!.currentContext!, PageTransition(
  //         child: ModalitiesReading(), type: PageTransitionType.fade));
  //   }
  // }
}
