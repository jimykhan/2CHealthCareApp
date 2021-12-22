import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/io_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:twochealthcare/constants/api_strings.dart';
import 'package:twochealthcare/models/chat_model/ChatMessage.dart';
import 'package:twochealthcare/providers/providers.dart';
import 'package:twochealthcare/services/application_route_service.dart';
import 'package:twochealthcare/services/auth_services/auth_services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:twochealthcare/services/dio_services/dio_services.dart';
class HealthGuidesService {

  ProviderReference? _ref;
  AuthServices? _authServices;
  DioServices? dio;
  HealthGuidesService({ProviderReference? ref}){
    _ref = ref;
    initService();
  }
  initService(){
    _authServices = _ref!.read(authServiceProvider);
     dio = _ref!.read(dioServicesProvider);
  }


  getAllHealthGuides() async{
    Response response = await dio!.dio!.get(ApiStrings.healthGuideLines);
  }

}