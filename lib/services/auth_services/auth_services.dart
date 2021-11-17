

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/user/current_user.dart';
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
