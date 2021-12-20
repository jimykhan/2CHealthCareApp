import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/onlunch_activity_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/views/auths/login.dart';
import 'package:twochealthcare/views/home/home.dart';

class SplashVM extends ChangeNotifier{
  ProviderReference? _ref;
  FirebaseService? firebaseService;
  SplashVM({ProviderReference? ref}){
    _ref = ref;
    splashDuration();
  }


  splashDuration(){
    Future.delayed(const Duration(seconds: 2),navigateToHome);
  }

  navigateToHome() async {
     SharedPrefServices sharedPrefServices =  _ref!.read(sharedPrefServiceProvider);
     AuthServices authServices =  _ref!.read(authServiceProvider);
     ApplicationRouteService applicationRouteService =  _ref!.read(applicationRouteServiceProvider);
     LoginVM loginVM =  _ref!.read(loginVMProvider);
     FirebaseService firebaseService =  _ref!.read(firebaseServiceProvider);
     SignalRServices signalRServices =  _ref!.read(signalRServiceProvider);
     OnLaunchActivityService onLunchActivityService =  _ref!.read(onLaunchActivityServiceProvider);

     var bearerToken = await sharedPrefServices.getBearerToken();
     int currenUserId = await authServices.getCurrentUserId();
     if(bearerToken == null){
       applicationRouteService.addAndRemoveScreen(screenName: "Login");
       Navigator.pushReplacement(applicationContext!.currentContext!,
           PageTransition(child:const Login() , type: PageTransitionType.leftToRight));
     }else{
       applicationRouteService.addAndRemoveScreen(screenName: "Home");
       onLunchActivityService.syncLastApplicationUseDateAndTime();
       Navigator.pushReplacement(applicationContext!.currentContext!,
           PageTransition(child:  Home()  , type: PageTransitionType.leftToRight));
       loginVM.checkLastLoggedInUser(currentUserId: currenUserId.toString());
       firebaseService.initNotification();
       loginVM.getCurrentUserFromSharedPref();
       signalRServices.initSignalR();
     }

  }

}