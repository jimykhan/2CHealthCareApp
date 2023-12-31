import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/application_startup_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/views/auths/login.dart';
import 'package:twochealthcare/views/chat/chat_list.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:flutter/services.dart';

class SplashVM extends ChangeNotifier {
  ProviderReference? _ref;
  FirebaseService? firebaseService;
  ApplicationRouteService? applicationRouteService;
  ChatListVM? _chatListVM;
  SplashVM({ProviderReference? ref}) {
    _ref = ref;
    applicationRouteService = _ref?.read(applicationRouteServiceProvider);
    firebaseService = _ref?.read(firebaseServiceProvider);
    splashDuration();
  }



  splashDuration() {
    Future.delayed(const Duration(seconds: 2), navigateToHome);
  }

  navigateToHome() async {
    // SharedPrefServices sharedPrefServices =  _ref!.read(sharedPrefServiceProvider);
    // AuthServices authServices =  _ref!.read(authServiceProvider);
    // ApplicationRouteService applicationRouteService =  _ref!.read(applicationRouteServiceProvider);
    // // LoginVM loginVM =  _ref!.read(loginVMProvider);
    // // FirebaseService firebaseService =  _ref!.read(firebaseServiceProvider);
    // // SignalRServices signalRServices =  _ref!.read(signalRServiceProvider);
    // OnLaunchActivityAndRoutesService onLunchActivityService =  _ref!.read(onLaunchActivityServiceProvider);
    // _chatListVM =  _ref!.read(chatListVMProvider);
    ApplicationStartupService applicationStartupService =
        _ref!.read(applicationStartupServiceProvider);




    applicationStartupService.applicationStart(fromSplash: true);


    // await startUri();

    // var bearerToken = await sharedPrefServices.getBearerToken();
    // int currenUserId = await authServices.getCurrentUserId();
    // if(bearerToken == null){
    //   applicationRouteService.addAndRemoveScreen(screenName: "Login");
    //   Navigator.pushReplacement(applicationContext!.currentContext!,
    //       PageTransition(child:const Login() , type: PageTransitionType.leftToRight));
    // }else{
    //   applicationRouteService.addAndRemoveScreen(screenName: "Home");
    //   onLunchActivityService.decideUserFlow();
    //   onLunchActivityService.syncLastApplicationUseDateAndTime();
    // }
  }
}
