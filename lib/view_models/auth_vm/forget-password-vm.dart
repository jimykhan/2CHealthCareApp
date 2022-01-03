import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/views/auths/otp_verification.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ForgetPasswordVM extends ChangeNotifier{
  ProviderReference? _ref;
  AuthServices? authService;
  bool verificationWithPhone = false;
  bool verificationWithEmail = false;
  bool verifyOtpLoading = false;
  int otpLength = 0;
  TextEditingController emailController = TextEditingController(text: "");
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isloading = false;
  Map error = {
    "email": [true, ""],
    "password": [true, ""]
  };

  listenForAutoSms() async {
   var data = await SmsAutoFill().listenForCode();
   // String appsign = await SmsAutoFill().getAppSignature;
   // String? hint = await SmsAutoFill().hint;
   SmsAutoFill().code.listen((event) {
     otpTextEditingController?.text = event.toString();
     notifyListeners();
     print(event.toUpperCase());
   });

  }

  autoFill(){
    return PinFieldAutoFill(
      codeLength: 6,
      onCodeChanged: (val){
        print(val);
      },
    );
    // TextFieldPinAutoFill(
    //   // currentCode: _code,
    // ),
  }

  TextEditingController? otpTextEditingController;
  StreamController<ErrorAnimationType>? errorController;
  // FirebaseService? firebaseService;
  // SignalRServices? signalRServices;
  // SharedPrefServices? sharedPrefServices;

  ForgetPasswordVM({ProviderReference? ref}){
    _ref = ref;
    initServices();
  }
  initServices(){
    authService = _ref?.read(authServiceProvider);
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
    SetVerifyOtpLoadingState(true);
    var res = await authService?.sendVerificationCode(userName: userName,sendBy: sendBy);
    if(res is bool){
      if(res){
        Future.delayed(Duration(seconds: 3),(){
          SetVerifyOtpLoadingState(false);
          Navigator.push(applicationContext!.currentContext!, PageTransition(child: OtpVerification(
            userName: userName??"",
          ), type: PageTransitionType.fade));
        });
      }else{
        SetVerifyOtpLoadingState(false);
      }
    }


    SetVerifyOtpLoadingState(false);

  }

  sendVerificationCodeToPhone({String? userName,String? phoneNumber}) async{
    SetVerifyOtpLoadingState(true);
    var res = await authService?.sendVerificationCodeToPhone(userName: userName,phoneNumber: phoneNumber);
    if(res is bool){
      if(res){
        SetVerifyOtpLoadingState(false);
      }else{
        SetVerifyOtpLoadingState(false);
      }
    }
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
  // hash: 9vXNm+dASeo

}