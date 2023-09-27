import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
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
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/services/signal_r_services.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:twochealthcare/view_models/chat_vm/chat_list_vm.dart';
import 'package:twochealthcare/view_models/facility_user_view_model/home/fu_home_view_model.dart';
import 'package:twochealthcare/view_models/profile_vm.dart';
import 'package:twochealthcare/views/auths/login.dart';
import 'package:twochealthcare/views/phs_form/phs_form_screen.dart';
import '../main.dart';

class ApplicationStartupService {
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
  OnLaunchActivityAndRoutesService? onLaunchActivityService;
  AuthServices? authServices;

  ApplicationStartupService({ProviderReference? ref}) {
    _ref = ref;
    _initServices();
  }

  _initServices() {
    authServices = _ref!.read(authServiceProvider);
    _chatListVM = _ref!.read(chatListVMProvider);
    profileVm = _ref!.read(profileVMProvider);
    signalRServices = _ref!.read(signalRServiceProvider);
    firebaseService = _ref!.read(firebaseServiceProvider);
    dio = _ref!.read(dioServicesProvider);
    _authService = _ref!.read(authServiceProvider);
    loginVM = _ref!.read(loginVMProvider);
    _facilityService = _ref!.read(facilityServiceProvider);
    _fuHomeViewModel = _ref!.read(fuHomeVMProvider);
    applicationRouteService = _ref?.read(applicationRouteServiceProvider);
    sharedPrefServices = _ref?.read(sharedPrefServiceProvider);
    onLaunchActivityService = _ref?.read(onLaunchActivityServiceProvider);
  }

  applicationStart(
      {bool fromSplash = false,
      bool fromLogin = false,
      bool from2FA = false,
      bool fromResetPassword = false,
      var url}) async {
    int userType = await authServices?.getCurrentUserType() ?? -1;
    if (fromSplash) {
      var bearerToken = await sharedPrefServices?.getBearerToken();
      int userType = await authServices?.getCurrentUserType() ?? -1;
      if (bearerToken == null) {
        applicationRouteService?.addAndRemoveScreen(screenName: "Login");
        
        Navigator.push(
            applicationContext!.currentContext!,
            PageTransition(
                child: Login(
                  path: url.toString(),
                ),
                type: PageTransitionType.leftToRight));
        return;
      }
    }
    if (fromLogin) {
      // onLaunchActivityService?.setAndGetLastLoginDateTime().then((value)
      // {
      //   loginVM?.getLastLoginDateTimeFromSharePref();
      // } );
    }
    if (from2FA) {}
    if (fromResetPassword) {
      if (userType == 1) {
        profileVm?.getUserInfo();
      }
    }

    applicationRouteService?.addAndRemoveScreen(screenName: "Home");
    onLaunchActivityService?.decideUserFlow();
    onLaunchActivityService?.syncLastApplicationUseDateAndTime();
    loginVM?.getLastLoginDateTimeFromSharePref();
    firebaseService?.subNotification();
  }
}
