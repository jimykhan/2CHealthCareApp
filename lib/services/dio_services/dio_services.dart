import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/services/dio_services/error_handlers.dart';

class DioServices{
  Dio? dio;
  ProviderReference? _ref;
  DioServices({ProviderReference? ref}){
   _ref = ref;
   _initDio();
  }

  _initDio(){
    dio = Dio(BaseOptions(
      baseUrl: ApiStrings.baseUrl,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    if(dio != null){
      dio!.interceptors.add(InterceptorsWrapper(
        onRequest:_dioRequest,
        onResponse:_dioResponse,
        onError: _errorHandler,
      ));
    }

  }
  _errorHandler(DioError err , handler){
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
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

  _dioResponse(response,handler){}
  _dioRequest(options,handler){}
}
