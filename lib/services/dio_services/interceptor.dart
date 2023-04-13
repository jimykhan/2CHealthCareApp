import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/main.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/dio_services/error_handlers.dart';
import 'package:twochealthcare/services/dio_services/token_refresh_request.dart';
import 'package:twochealthcare/services/shared_pref_services.dart';
import 'package:twochealthcare/view_models/auth_vm/login_vm.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:twochealthcare/views/auths/login.dart';


class ApiInterceptor extends Interceptor{
  ProviderReference? ref;
  ApiInterceptor({this.ref});
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    // SnackBarMessage(message: err.response!.data.toString());
    super.onError(err, handler);
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions,data: err.response?.statusMessage);
          case 401:
            throw UnauthorizedException(err.requestOptions,data: err.response?.statusMessage);
          case 404:
            throw NotFoundException(err.requestOptions,data: err.response?.statusMessage);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler)async{
     LoginVM loginVM =  ref!.read(loginVMProvider);

     if(loginVM.currentUser?.bearerToken!=null){
       String token = loginVM.currentUser?.bearerToken??"";
       String refreshToken = loginVM.currentUser?.refreshToken??"";
       bool hasExpired = JwtDecoder.isExpired(token);
       // bool isRefreshTokenExpired = JwtDecoder.isExpired(refreshToken);
       // DateTime expirationDate = JwtDecoder.getExpirationDate(token);
       print(token);
       if(hasExpired){
         var res = await refreshTokenRequest(loginVM.currentUser!.refreshToken!);
         if(res== null){
           SnackBarMessage(message: "Sorry, your token expired, please login again");
           loginVM.userLogout();
           return;
         } else if(res is bool){
           return;
         }else{
           loginVM.updateCurrentUser(res);
           options.headers = {
             "Authorization": "Bearer ${loginVM.currentUser?.bearerToken??""}",
             "clientType" : "Mobile",
           };
         }
       }
       else{
         options.headers = {
           "Authorization": "Bearer ${loginVM.currentUser?.bearerToken??""}"
         };
       }
     }
     print(options.path);
     print("${options.data??""}");


    // TODO: implement onRequest
    super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(response.data);
    // print()
    super.onResponse(response, handler);
  }

}