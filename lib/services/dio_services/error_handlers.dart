import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:twochealthcare/util/application_colors.dart';
import 'package:twochealthcare/util/application_sizing.dart';

class BadRequestException extends DioError {
  dynamic? data;
  BadRequestException(RequestOptions r, {this.data}) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: data?.toString()??"Invalid request");
    return 'Invalid request ';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: Strings.unknownError);
    return Strings.unknownError;
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: "Conflict occurred");
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  dynamic? data;
  UnauthorizedException(RequestOptions r, {this.data}) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: "Access denied");
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  dynamic? data;
  NotFoundException(RequestOptions r, {this.data}) : super(requestOptions: r);

  @override
  String toString() {

    // if(data is String){
    //   SnackBarMessage(message: data);
    // }else{
    //   SnackBarMessage(message:"The requested information could not be found");
    // }
    SnackBarMessage(message: data?.toString()??"The requested information could not be found");
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: Strings.noConnection);
    return Strings.noConnection;
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: "The connection has timed out, please try again.");
    return 'The connection has timed out, please try again.';
  }
}