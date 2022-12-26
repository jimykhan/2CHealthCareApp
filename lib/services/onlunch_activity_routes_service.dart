import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/models/user/loged_in_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
import 'package:twochealthcare/services/facility_user_services/facility_service.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/admin_view/home_view/admin_home_view.dart';
import 'package:twochealthcare/views/auths/login.dart';
import 'package:twochealthcare/views/chat/chat_list.dart';
import 'package:twochealthcare/views/facility_user/fu_home/fu_home.dart';
import 'package:twochealthcare/views/facility_user/fu_home/fu_profile.dart';
import 'package:twochealthcare/views/home/home.dart';
import 'package:twochealthcare/views/home/profile.dart';
import 'package:twochealthcare/views/rpm_view/readings/modalities_reading.dart';
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
  FacilityService? _facilityService;
  FUHomeViewModel? _fuHomeViewModel;
  ApplicationRouteService? applicationRouteService;
  SharedPrefServices? sharedPrefServices;

  OnLaunchActivityAndRoutesService({ProviderReference? ref}){
    _ref = ref;
    _initServices();
  }

  _initServices(){
    // AuthServices authServices =  _ref!.read(authServiceProvider);
    _chatListVM =  _ref!.read(chatListVMProvider);
    profileVm =  _ref!.read(profileVMProvider);
    signalRServices =  _ref!.read(signalRServiceProvider);
    firebaseService = _ref!.read(firebaseServiceProvider);
    dio = _ref!.read(dioServicesProvider);
    _authService = _ref!.read(authServiceProvider);
    loginVM = _ref!.read(loginVMProvider);
    _facilityService = _ref!.read(facilityServiceProvider);
    _fuHomeViewModel = _ref!.read(fuHomeVMProvider);
    applicationRouteService = _ref?.read(applicationRouteServiceProvider);
    sharedPrefServices = _ref?.read(sharedPrefServiceProvider);
  }

  syncLastApplicationUseDateAndTime() async {
    try{
      int userType = await _authService!.getCurrentUserType();
      if(userType == 1){
        patientOnStartApplicationData();
      }
      else if(userType == 5){
        facilityUserOnStartApplicationData();
      }
      else if(userType == 3){
        adminUserOnStartApplicationData();
      }
      else{

      }
    }catch(e){
      rethrow;
    }
  }

  patientOnStartApplicationData()async{
    int patientId = await _authService!.getCurrentUserId();
    profileVm?.getUserInfo();
    // loginVM?.checkLastLoggedInUser(body: {
    //   "id":loginVM?.currentUser?.id?.toString()??"",
    //   "userName": loginVM?.currentUser?.fullName??"",
    //   "lastLogedIn": DateTime.now().toString()
    // });
    _chatListVM?.getGroupsIds();
    // firebaseService?.initNotification();
    loginVM?.getCurrentUserFromSharedPref();
    signalRServices?.initSignalR();
    Response res = await dio!.dio!.post(PatientsController.setLastAppLaunchDate+"/$patientId");
  }

  facilityUserOnStartApplicationData()async{
    // loginVM?.checkLastLoggedInUser(body: {
    //   "id":loginVM?.currentUser?.id?.toString()??"",
    //   "userName": loginVM?.currentUser?.fullName??"",
    //   "lastLogedIn": DateTime.now().toString()
    // });
    _chatListVM?.getGroupsIds();
    // firebaseService?.initNotification();
    _fuHomeViewModel?.getFacilitiesByUserId();
    loginVM?.getCurrentUserFromSharedPref();
    await _facilityService?.getHangfireToken();
    signalRServices?.initSignalR();
  }

  adminUserOnStartApplicationData() async {
    loginVM?.getCurrentUserFromSharedPref();
    await _facilityService?.getHangfireToken();
    signalRServices?.initSignalR();
  }

  decideUserFlow()async{
    CurrentUser currentUser = await loginVM?.getCurrentUserFromSharedPref();
    if(currentUser.userType == 1){
      Navigator.pushAndRemoveUntil(
        applicationContext!.currentContext!,
        MaterialPageRoute(
          builder: (BuildContext context) =>
           Home(),
        ),
            (route) => false,
      );
      return;
    }
    if(currentUser.userType == 3){
      Navigator.pushAndRemoveUntil(
        applicationContext!.currentContext!,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              AdminHome(),
        ),
            (route) => false,
      );
      return;
    }

    if(currentUser.userType == 5){
      Navigator.pushAndRemoveUntil(
        applicationContext!.currentContext!,
        MaterialPageRoute(
          builder: (BuildContext context) =>
           FUHome(),
        ),
            (route) => false,
      );
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

  Future<void> handleMessage() async {
    print("OnMessageOpenedApp call");
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    print("decide Flow");
    if (initialMessage != null) {
      if(initialMessage.notification?.title == "New Message Received"){
        HomeDecider();
        applicationRouteService?.addAndRemoveScreen(
            screenName: "ChatList");
        Navigator.push(applicationContext!.currentContext!, PageTransition(
            child: ChatList(), type: PageTransitionType.fade));

      }
      else{
        HomeDecider();
        Navigator.push(applicationContext!.currentContext!, PageTransition(
            child: ModalitiesReading(), type: PageTransitionType.fade));
      }
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
    }
    if(currentUser.userType == 3){
      Navigator.pushAndRemoveUntil(
        applicationContext!.currentContext!,
        MaterialPageRoute(
          builder: (BuildContext context) => AdminHome(),
        ),
            (route) => false,
      );
    }
    else{
    }
  }

  // Future<LogedInUserModel> setAndGetLastLoginDateTime()async{
  //   LogedInUserModel logedInUserModel = LogedInUserModel();
  //   try{
  //     String userId = await _authService!.getCurrentAppUserId();
  //     Response res1 = await dio!.dio!.get(ApiStrings.getLastAppLaunchDate+"/$userId");
  //     logedInUserModel.id = userId;
  //     logedInUserModel.lastLogedIn = Jiffy(DateTime.now().toString()).format(Strings.dateAndTimeFormat);
  //     if(res1.statusCode == 200){
  //       if(res1.data["userLastLogin"] != null){
  //         logedInUserModel.lastLogedIn = Jiffy(res1.data["userLastLogin"]).format(Strings.dateAndTimeFormat);
  //       }
  //     }
  //     await sharedPrefServices?.lastLoggedInUser(data: logedInUserModel.toJson());
  //     // Response res = await dio!.dio!.post(ApiStrings.setLastAppLaunchDate+"/$userId");
  //     return logedInUserModel;
  //   }catch(ex){
  //     return logedInUserModel;
  //   }
  //
  // }
}