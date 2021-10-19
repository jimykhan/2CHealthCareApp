import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/views/auths/login.dart';

class SplashVM extends ChangeNotifier{
  ProviderReference? _ref;
  SplashVM({ProviderReference? ref}){
    _ref = ref;
    splashDuration();
  }

  splashDuration(){
    Future.delayed(const Duration(seconds: 2),navigateToHome);
  }
  navigateToHome(){
      Navigator.pushReplacement(applicationContext!.currentContext!,
          PageTransition(child: const Login(), type: PageTransitionType.leftToRight));
  }

}