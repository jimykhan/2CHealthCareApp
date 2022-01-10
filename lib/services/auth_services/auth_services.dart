

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/models/user/is-sms-email-verified.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';

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
      "rememberMe": false
    };
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.signIn,
        data: body,
      );
      if(response.statusCode == 200){
        updateCurrentUser(response.data);
        return CurrentUser.fromJson(response.data);

      }else{
        return null;
      }
    }
    catch(e){
        print(e.toString());
    }
  }
  Future<dynamic> changePassword({String? userName, String? password, String? confirmPassword,
    String? pinCode,}) async {
    var body = {
      "Email": userName??"",
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
  }

  Future<CurrentUser?> getCurrentUserFromSharedPref()async{
    initServices();
    var currentUser = await _sharePrf?.getCurrentUser();
    return  currentUser;
  }

  dynamic getBearerToken(){
    initServices();
    var token = _sharePrf?.getBearerToken();
    return token;
  }

  Future<int> getCurrentUserId() async {
    var currentUser = await getCurrentUserFromSharedPref();
    int Id = 0 ;
    if(currentUser != null) Id = currentUser.id!;
    return Id;
  }

  Future<String> getCurrentAppUserId() async {

    var currentUser = await getCurrentUserFromSharedPref();
    String appUserId = "" ;
    if(currentUser != null) appUserId = currentUser.appUserId!;
    return appUserId;
  }




}
