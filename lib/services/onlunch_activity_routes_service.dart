import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/auths/login.dart';
import 'package:twochealthcare/views/facility_user/fu_home/fu_home.dart';
import 'package:twochealthcare/views/facility_user/fu_home/fu_profile.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/home/profile.dart';
import 'package:twochealthcare/views/settings/fu_settings/fu_settings.dart';
import 'package:twochealthcare/views/settings/p_settings/p_settings.dart';

import '../main.dart';

class OnLaunchActivityAndRoutesService{
  ProviderReference? _ref;
  DioServices? dio;
  AuthServices? _authService;
  LoginVM? loginVM;
  FirebaseService? firebaseService;
  ChatListVM? _chatListVM;
  SignalRServices? signalRServices;
  ProfileVm? profileVm;

  OnLaunchActivityAndRoutesService({ProviderReference? ref}){
    _ref = ref;
    _initServices();
  }
  _initServices(){
    AuthServices authServices =  _ref!.read(authServiceProvider);
    _chatListVM =  _ref!.read(chatListVMProvider);
    profileVm =  _ref!.read(profileVMProvider);
    signalRServices =  _ref!.read(signalRServiceProvider);
    firebaseService = _ref!.read(firebaseServiceProvider);
    dio = _ref!.read(dioServicesProvider);
    _authService = _ref!.read(authServiceProvider);
    loginVM = _ref!.read(loginVMProvider);
  }

  syncLastApplicationUseDateAndTime() async {
    try{
      int userType = await _authService!.getCurrentUserId();
      if(userType == 1){
        int patientId = await _authService!.getCurrentUserId();
        Response res = await dio!.dio!.post(ApiStrings.setLastAppLaunchDate+"/$patientId");
        print(res);
        if(loginVM?.currentUser?.userType == 1){
          profileVm?.getUserInfo();
        }
      }

      loginVM?.checkLastLoggedInUser(body: {
        "id":loginVM?.currentUser?.id?.toString()??"",
        "userName": loginVM?.currentUser?.fullName??"",
        "lastLogedIn": DateTime.now().toString()
      });
      _chatListVM?.getGroupsIds();
      firebaseService?.initNotification();
      loginVM?.getCurrentUserFromSharedPref();
      signalRServices?.initSignalR();

    }catch(e){
      rethrow;
    }
  }

  decideUserFlow()async{
    CurrentUser currentUser = await loginVM?.getCurrentUserFromSharedPref();
    if(currentUser.userType == 1){
      Navigator.pushReplacement(
          applicationContext!.currentContext!,
          PageTransition(
              child: Home(),
              type: PageTransitionType.bottomToTop));
      return;
    }
    if(currentUser.userType == 5){
      Navigator.pushReplacement(
          applicationContext!.currentContext!,
          PageTransition(
              child: FUHome(),
              type: PageTransitionType.bottomToTop));
      return;
    }
    else{
      Navigator.pushReplacement(
          applicationContext!.currentContext!,
          PageTransition(
              child: Login(),
              type: PageTransitionType.bottomToTop));
      return;
    }
  }
  profileDecider()async{
    CurrentUser currentUser = await loginVM?.getCurrentUserFromSharedPref();
    if(currentUser.userType == 1){
      Navigator.pushReplacement(
          applicationContext!.currentContext!,
          PageTransition(
              child: Profile(),
              type: PageTransitionType.bottomToTop));
    }
    if(currentUser.userType == 5){
      Navigator.pushReplacement(
          applicationContext!.currentContext!,
          PageTransition(
              child: FUProfile(),
              type: PageTransitionType.bottomToTop));
    }else{
    }
  }
  settingsDecider()async{
    CurrentUser currentUser = await loginVM?.getCurrentUserFromSharedPref();
    Navigator.pop(applicationContext!.currentContext!);
    if(currentUser.userType == 1){
      Navigator.push(
          applicationContext!.currentContext!,
          PageTransition(
              child: PSettings(),
              type: PageTransitionType.bottomToTop));
    }
    if(currentUser.userType == 5){
      Navigator.push(
          applicationContext!.currentContext!,
          PageTransition(
              child: FUSettings(),
              type: PageTransitionType.bottomToTop));
    }else{
    }
  }

  HomeDecider()async{
    CurrentUser currentUser = await loginVM?.getCurrentUserFromSharedPref();
    if(currentUser.userType == 1){
      Navigator.pushAndRemoveUntil(
        applicationContext!.currentContext!,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        ),
            (route) => false,
      );
    }
    if(currentUser.userType == 5){
      Navigator.pushAndRemoveUntil(
        applicationContext!.currentContext!,
        MaterialPageRoute(
          builder: (BuildContext context) => FUHome(),
        ),
            (route) => false,
      );
    }else{
    }
  }
}