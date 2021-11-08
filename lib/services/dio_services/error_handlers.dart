import 'package:dio/dio.dart';
import 'package:twochealthcare/common_widgets/snackber_message.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';

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
    SnackBarMessage(message: "Unknown error occurred, please try again later.");
    return 'Unknown error occurred, please try again later.';
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
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: "Access denied");
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: "The requested information could not be found");
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    SnackBarMessage(message: "No internet connection detected, please try again.");
    return 'No internet connection detected, please try again.';
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