import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/firebase_service.dart';
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
     LoginVM loginVM =  _ref!.read(loginVMProvider);
     FirebaseService firebaseService =  _ref!.read(firebaseServiceProvider);
     SignalRServices signalRServices =  _ref!.read(signalRServiceProvider);
     var bearerToken = await sharedPrefServices.getBearerToken();
     if(bearerToken == null){
       Navigator.pushReplacement(applicationContext!.currentContext!,
           PageTransition(child:const Login() , type: PageTransitionType.leftToRight));
     }else{

       Navigator.pushReplacement(applicationContext!.currentContext!,
           PageTransition(child:  Home()  , type: PageTransitionType.leftToRight));
       firebaseService.initNotification();
       loginVM.getCurrentUserFromSharedPref();
       signalRServices.initSignalR();
     }

  }

}