import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/services/firebase_service.dart';
import 'package:twochealthcare/services/onlunch_activity_routes_service.dart';
import 'package:twochealthcare/views/auths/otp_verification.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:twochealthcare/views/auths/reset_password.dart';
import 'package:twochealthcare/views/home/profile.dart';

// class ForgetPasswordVM extends ChangeNotifier with CodeAutoFill{
class ForgetPasswordVM extends ChangeNotifier{
  ProviderReference? _ref;
  AuthServices? authService;
  bool verificationWithPhone = false;
  bool verificationWithEmail = false;
  bool verifyOtpLoading = false;
  int otpLength = 0;
  ApplicationRouteService? applicationRouteService;
  FirebaseService? firebaseService;
  OnLaunchActivityAndRoutesService? onLaunchActivityService;
  TextEditingController emailController = TextEditingController(text: "");
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isloading = false;
  Map error = {
    "email": [true, ""],
    "password": [true, ""]
  };



  // autoFill(){
  //   return PinFieldAutoFill(
  //     codeLength: 6,
  //     onCodeChanged: (val){
  //       print(val);
  //     },
  //   );
  //   // TextFieldPinAutoFill(
  //   //   // currentCode: _code,
  //   // ),
  // }

  TextEditingController? otpTextEditingController;
  StreamController<ErrorAnimationType>? errorController;
  // FirebaseService? firebaseService;
  // SignalRServices? signalRServices;
  // SharedPrefServices? sharedPrefServices;

  ForgetPasswordVM({ProviderReference? ref}){
    _ref = ref;
    initServices();
    // listenForCode();
  }
  initServices(){
    authService = _ref?.read(authServiceProvider);
    applicationRouteService = _ref?.read(applicationRouteServiceProvider);
    onLaunchActivityService = _ref?.read(onLaunchActivityServiceProvider);
    firebaseService = _ref?.read(firebaseServiceProvider);
  }

  listenForAutoSms() async {
    String appsin = await SmsAutoFill().getAppSignature;
    print("this is AppSignature $appsin");
    await SmsAutoFill().listenForCode();
    SmsAutoFill().code.listen((event) {
      otpTextEditingController?.text = event.toString();
      notifyListeners();
      listenForAutoSms();
    });
  }



  initForgetPasswordScreen({required String userName}){
    emailController.text = userName;
    verificationWithPhone = false;
    verificationWithEmail = false;
  }
  initOtpVerificationScreen(){
    otpTextEditingController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
  }

  sendVerificationCode({String? userName, String? sendBy})async{
    otpTextEditingController?.text = "";
    listenForAutoSms();
    SetVerifyOtpLoadingState(true);
    var res = await authService?.sendVerificationCode(userName: userName,sendBy: sendBy);
    if(res is bool){
      if(res){
        SetVerifyOtpLoadingState(false);
      }else{
        SetVerifyOtpLoadingState(false);
      }
    }
    SetVerifyOtpLoadingState(false);

  }

  verifyResetPasswordCode({String? userName, String? pinCode})async{
    listenForAutoSms();
    SetVerifyOtpLoadingState(true);
    var res = await authService?.verifyResetPasswordCode(userName: userName,pinCode: pinCode);
    if(res is bool){
      if(res){
        Navigator.push(applicationContext!.currentContext!, PageTransition(child: ResetPassword(userName: userName??"",pinCode: pinCode??"",), type: PageTransitionType.fade));
        SetVerifyOtpLoadingState(false);
      }else{
        SetVerifyOtpLoadingState(false);
      }
    }
    SetVerifyOtpLoadingState(false);
  }


  sendVerificationCodeToPhone({String? userName,String? phoneNumber}) async{
    otpTextEditingController?.text = "";
    listenForAutoSms();
    SetVerifyOtpLoadingState(true);
    var res = await authService?.sendVerificationCodeToPhone(userName: userName,phoneNumber: phoneNumber);
    if(res is bool){
      if(res){
        SetVerifyOtpLoadingState(false);
      }else{
        SetVerifyOtpLoadingState(false);
      }
    }
    SetVerifyOtpLoadingState(false);
  }

  verifyVerificationCodeToPhone({String? userName,String? pinCode}) async{
    SetVerifyOtpLoadingState(true);
    var res = await authService?.verifyVerificationCodeToPhone(userName: userName,pinCode: pinCode);
    if(res is bool){
      if(res){
        SetVerifyOtpLoadingState(false);
        onLaunchActivityService?.profileDecider();
        // Navigator.pushReplacement(applicationContext!.currentContext!, PageTransition(child: Profile(), type: PageTransitionType.fade));
      }else{
        SetVerifyOtpLoadingState(false);
      }
    }
    SetVerifyOtpLoadingState(false);
  }

  verify2FA({required String otp,required String bearerToken}) async{
    SetVerifyOtpLoadingState(true);
    var res = await authService?.verify2FA(otp: otp,bearerToken: bearerToken);
    if(res is CurrentUser){
      // currentUser = res;
      SetVerifyOtpLoadingState(false);
      applicationRouteService?.addAndRemoveScreen(screenName: "Home");
      firebaseService?.subNotification();
      onLaunchActivityService?.decideUserFlow();
      onLaunchActivityService?.syncLastApplicationUseDateAndTime();

    }
    SetVerifyOtpLoadingState(false);

  }

  send2FACode({required String userId,required int method,required String bearerToken}) async{
    SetVerifyOtpLoadingState(true);
    listenForAutoSms();
    var body = {
      "userId": userId,
      "sendMethod": method
    };
    var res = await authService?.send2FACode(body: body,bearerToken: bearerToken);
    SetVerifyOtpLoadingState(false);
  }
  send2FACodeInStartUp({required String userId,required int method,required String bearerToken}) async{
    listenForAutoSms();
    var body = {
      "userId": userId,
      "sendMethod": method
    };
    var res = await authService?.send2FACode(body: body,bearerToken: bearerToken);
  }
  sendVerificationCodeToEmail(){}

  VerifyPinCode({required String userName, required String pinCode}) async {

  }

  SetVerificationWithPhone(bool isTrue) {
    verificationWithPhone = isTrue;
    verificationWithEmail = !isTrue;
    notifyListeners();
  }

  SetVerifyOtpLoadingState(bool isLoading) {
    verifyOtpLoading = isLoading;
    notifyListeners();
  }

  SetVerificationWithEmail(bool isTrue) {
    verificationWithPhone = !isTrue;
    verificationWithEmail = isTrue;
    notifyListeners();
  }

  setOtpLength(int val) {
    otpLength = val;
    notifyListeners();
  }

  // @override
  // void codeUpdated() {
  //   otpTextEditingController?.text = code!;
  //   notifyListeners();
  //   // TODO: implement codeUpdated
  // }

  ///Old hash: 9vXNm+dASeo
  ///New hash: oOYc1XZBQRl

}