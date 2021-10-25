

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/models/user/current_user.dart';
import 'package:twochealthcare/providers/providers.dart';

class LoginServices{
  ProviderReference? _ref;
  LoginServices({ProviderReference? ref}){
    _ref = ref;
  }

  Future<dynamic> userLogin({String? userName, String? password, String? rememberMe}) async {

    var body = {
      "userName": userName,
      "password": password,
      "rememberMe": rememberMe
    };
    try{
      final dio = _ref!.read(dioServicesProvider);
      Response response = await dio.dio!.post(ApiStrings.SIGN_IN,
        data: body,
      );

      if(response.statusCode == 200){
        return CurrentUser.fromJson(response.data);

      }else{
        dd();
      }
    }
    catch(e){

    }
  }

}
dd({String? message}){
  ScaffoldMessenger.of(applicationContext!.currentContext!).showSnackBar(
     SnackBar(
      content: Text(message??'A SnackBar has been shown.'),
    ),
  );
}