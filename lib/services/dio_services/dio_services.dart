import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:twochealthcare/constants/api_strings.dart';
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
      baseUrl: baseUrl,
      receiveTimeout: Duration(seconds: 10), // 10 seconds
      connectTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
        contentType:"application/json",
    ),);

    if(dio != null){
      dio!.interceptors.add(ApiInterceptor(ref: _ref));
    }

  }
}
