import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:twochealthcare/views/splash/splash.dart';
import 'package:twochealthcare/views/splash/test_1.dart';

BuildContext? homeContext;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('Handling a background message ${message.notification?.title ?? ""}');
  // Navigator.push(applicationContext!.currentContext!, PageTransition(
  //     child: ModalitiesReading(), type: PageTransitionType.topToBottom));
}

GlobalKey<NavigatorState>? applicationContext = GlobalKey();
Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.green,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    runApp(ProviderScope(child: MyApp()));
  } catch (e) {
    runApp(ProviderScope(child: MyApp()));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    homeContext = context;

    // return MaterialApp.router(
    //   builder: BotToastInit(),
    //   routerConfig: GoRouter(
    //     routes: AppRouteConfig.router,
    //     navigatorKey: applicationContext, 
    //     observers: [BotToastNavigatorObserver()],
    //     ),
      
    //   debugShowCheckedModeBanner: false,
    //   title: '2C Health Care',
    //   theme: ThemeData(
    //       primaryColor: Colors.green.shade50,
    //       primarySwatch: Colors.green,
    //       appBarTheme: AppBarTheme(
    //           backgroundColor: Colors.green,
    //           systemOverlayStyle: SystemUiOverlayStyle.dark)),
    //   // home: const Splash(),
    // );

        return MaterialApp(
      builder: BotToastInit(),
      initialRoute: "/",
      routes: {
        '/': (context) => const Splash(),
        '/phsForm': (context) => Deeplinkwork(),
      },
        navigatorKey: applicationContext, 
        navigatorObservers: [BotToastNavigatorObserver()],
      
      
      debugShowCheckedModeBanner: false,
      title: '2C Health Care',
      theme: ThemeData(
          primaryColor: Colors.green.shade50,
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.green,
              systemOverlayStyle: SystemUiOverlayStyle.dark)),
      // home: const Splash(),
    );
  }
}
