import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/constants/strings.dart';
import 'package:twochealthcare/services/dio_services/error_handlers.dart';
import 'package:twochealthcare/services/dio_services/interceptor.dart';

class DioServices{
  Dio? dio;
  ProviderReference? _ref;
  DioServices({ProviderReference? ref}){
   _ref = ref;
   _initDio();
  }

  _initDio(){
    dio = Dio(
      BaseOptions(
      baseUrl: ApiStrings.baseUrl,
      receiveTimeout: 10000, // 10 seconds
      connectTimeout: 10000,
      sendTimeout: 1000,
        contentType:"application/json",
    ),);

    if(dio != null){
      dio!.interceptors.add(ApiInterceptor(ref: _ref));
    }

  }
}
