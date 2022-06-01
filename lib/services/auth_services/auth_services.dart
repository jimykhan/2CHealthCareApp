

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/models/user/is-sms-email-verified.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/views/auths/otp_verification.dart';

class AuthServices{
  ProviderReference? _ref;
  SharedPrefServices? _sharePrf;
  AuthServices({ProviderReference? ref}){
    _ref = ref;
    initServices();
  }
  initServices(){
     if(_sharePrf==null) _sharePrf = _ref!.read(sharedPrefServiceProvider);
  }

  Future<dynamic> userLogin({String? userName, String? password, bool? rememberMe}) async {
    var body = {
      "userName": userName??"",
      "password": password??"",
      "rememberMe": false,
      "isMobileClient": true,

    };
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.signIn,
        data: body,
      );
      if(response.statusCode == 200){
        CurrentUser currentUser = CurrentUser.fromJson(response.data);
        if(currentUser.is2faRequired?? false){
          Navigator.push(applicationContext!.currentContext!,
              PageTransition(child: OtpVerification(userName: currentUser.userName??"",
                from2FA: true,isForgetPassword: false,
                userId: currentUser.appUserId??"",
                bearerToken: currentUser.bearerToken??"",
              ),
                  type: PageTransitionType.fade));
          return null;
        }else{
          updateCurrentUser(response.data);
          return currentUser;
        }
      }
      else{
        // SnackBarMessage(message: response.data?.toString()??"");
        return null;
      }
    }
    catch(e){
      rethrow;
        // return null;
    }
  }
  Future<dynamic> changePassword({String? userName, String? password, String? confirmPassword,
    String? pinCode,}) async {
    var body = {
      "userName": userName??"",
      "password": password??"",
      "confirmPassword": confirmPassword??"",
      "code": pinCode??"",
    };
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.resetPassword,
        data: body,
      );
      if(response.statusCode == 200){
        return true;

      }else{
        SnackBarMessage(message: response.data);
        return false;
      }
    }
    catch(e){
        print(e.toString());
        return false;
    }
  }

  Future<dynamic> isSmsOrEmailVerified({required String userName}) async {

    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.isSmsOrEmailVerified+"?userName=$userName",
      );
      if(response.statusCode == 200){
        IsSmsEmailVerified isSmsEmailVerified = IsSmsEmailVerified.fromJson(response.data);
        return isSmsEmailVerified;
      }else{
        SnackBarMessage(message: response.data?.toString()??"");
        return null;
      }
    }
    catch(e){
        print(e.toString());
    }
  }

  Future<dynamic> sendVerificationCode({String? userName, String? sendBy}) async {

    try{
      Map<String,String> resquestBody = {
        "userName":userName??"",
        "sendBy":sendBy??""
      };
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.forgotPassword,
        data: resquestBody
      );
      if(response.statusCode == 200){
        SnackBarMessage(message: response.data?.toString()??"",error: false);
        return true;
      }else{
        SnackBarMessage(message: response.data?.toString()??"");
        return false;
      }
    }
    catch(e){
        print(e.toString());
    }
  }
  Future<dynamic> verifyResetPasswordCode({String? userName, String? pinCode}) async {

    try{
      Map<String,String> resquestBody = {"userName": userName??"", "code": pinCode??""};
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.verifyResetPasswordCode,
        data: resquestBody
      );
      if(response.statusCode == 200){

        if(response.data is bool){
          if(response.data) {
            // SnackBarMessage(message: "Verification code sent",error: false);
            return response.data;
          }
          else{
            SnackBarMessage(message: "Invalid verification code");
            return response.data;
          }
        }
        else{
          return true;
        }

      }else{
        SnackBarMessage(message: "Invalid verification code");
        return false;
      }
    }
    catch(e){
        print(e.toString());
        return false;
    }
  }

  Future<dynamic> sendVerificationCodeToPhone({String? userName, String? phoneNumber}) async {
    try{
      Map<String,String> resquestBody = {
        "phonenumber":phoneNumber??"",
        "username":userName??""};
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.sendPhoneNoVerificationToken,
          data: resquestBody
      );
      if(response.statusCode == 200){
        SnackBarMessage(message: response.data?.toString()??"",error: false);
        return true;
      }else{
        SnackBarMessage(message: response.data?.toString()??"");
        return false;
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  Future<dynamic> verifyVerificationCodeToPhone({String? userName, String? pinCode}) async {
    try{
      Map<String,String> resquestBody = {
        "code":pinCode??"",
        "username":userName??""
      };
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.verifyPhoneNumber,
          data: resquestBody
      );
      if(response.statusCode == 200){
        SnackBarMessage(message: response.data?.toString()??"",error: false);
        return true;
      }else{
        SnackBarMessage(message: response.data?.toString()??"");
        return false;
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  updateCurrentUser(var data){
    initServices();
    _sharePrf!.setCurrentUser(data);
    // getCurrentUserFromSharedPref();
  }

  Future<CurrentUser?> getCurrentUserFromSharedPref()async{
    initServices();
    var currentUser = await _sharePrf?.getCurrentUser();
    return  currentUser;
  }

  Future<String> getBearerToken()async{
    initServices();
    String token = "";
    int userType = await _sharePrf?.getCurrentUserType()??1;
    if(userType == 1){
      token = await _sharePrf?.getBearerToken();
    }else{
      token = await _sharePrf?.getShortToken();
    }
    return token;
  }

  Future<int> getCurrentUserId() async {
    var currentUser = await getCurrentUserFromSharedPref();
    int Id = 0 ;
    if(currentUser != null) Id = currentUser.id!;
    return Id;
  }

  Future<int> getCurrentUserType() async {
    var currentUser = await getCurrentUserFromSharedPref();
    int userType = 0 ;
    if(currentUser != null) userType = currentUser.userType!;
    return userType;
  }

  Future<String> getCurrentAppUserId() async {

    var currentUser = await getCurrentUserFromSharedPref();
    String appUserId = "" ;
    if(currentUser != null) appUserId = currentUser.appUserId!;
    return appUserId;
  }

  Future<dynamic> verify2FA({required String otp, required String bearerToken}) async {

    try{
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          receiveTimeout: 10000, // 10 seconds
          connectTimeout: 10000,
          sendTimeout: 1000,
          contentType:"application/json",
            headers : {
              "Authorization": "Bearer ${bearerToken}"
            }
        ),);
      String url = Account.loginWith2fa+"?TwoFactorCode=${otp}&RememberMachine=${true}&RememberMe=${true}";
      // String url = Account.loginWith2fa+"?TwoFactorCode=$otp";
      print(url);
      Response response = await dio.post(url,
      );
      if(response.statusCode == 200){
        CurrentUser currentUser = CurrentUser.fromJson(response.data);
          updateCurrentUser(response.data);
          return currentUser;
      }
      else{
        return null;
      }
    }
    catch(e){
      return null;
    }
  }

  Future<dynamic> send2FACode({required var body, required String bearerToken}) async {
    try{
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          receiveTimeout: 10000, // 10 seconds
          connectTimeout: 10000,
          sendTimeout: 1000,
          contentType:"application/json",
            headers : {
              "Authorization": "Bearer ${bearerToken}"
            }
        ),);
      Response response = await dio.post(AccountApi.send2FToken,
        data: body
      );
      if(response.statusCode == 200){
       return true;
      }
      else{
        return null;
      }
    }
    catch(e){
      return null;
    }
  }





}
