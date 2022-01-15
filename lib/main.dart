import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/readings/modalities_reading.dart';
import 'package:twochealthcare/views/splash/splash.dart';

BuildContext? homeContext;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  // _subNotification();
  // print('Handling a background message ${message.messageId}');
  // print('Handling a background message ${message.data}');

  // Navigator.push(applicationContext!.currentContext!, PageTransition(
  //     child: ModalitiesReading(), type: PageTransitionType.topToBottom));
}

void requestNotificationPermission() async {
  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("user granted permission");
  } else if (settings.authorizationStatus ==
      AuthorizationStatus.provisional) {
    print('user granted provisional permission');
  } else {
    print('user declined or has not accepted permission');
  }
}

GlobalKey<NavigatorState>? applicationContext = GlobalKey();
Future<void> main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.green,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    runApp(ProviderScope(child: MyApp()));
  }
  catch(e){
    runApp(ProviderScope(child: MyApp()));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    homeContext = context;
    return MaterialApp(
      builder: BotToastInit(),
      navigatorKey: applicationContext,
      debugShowCheckedModeBanner: false,
      title: '2C Health Care',
        navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
          primaryColor: Colors.green.shade50, primarySwatch: Colors.green,
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.green,
      systemOverlayStyle: SystemUiOverlayStyle.dark

    )
    ),
      home: const Splash(),
    );
  }
}