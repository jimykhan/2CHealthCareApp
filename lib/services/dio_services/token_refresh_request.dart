import 'dart:io';

import 'package:dio/dio.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';

Future<dynamic>refreshTokenRequest(String refreshToken) async {
  // AccountApi
   try{
     Response res = await Dio().post(AccountApi.refreshToken+"?refreshToken=${refreshToken}");
     if(res.statusCode == 200){
        return res.data;
     }
     else{
       return null;
     }
   }on SocketException{
     SnackBarMessage(message: Strings.noConnection);
     return false;
   }
   catch(e){
     return null;
   }
}